/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
#include "\ALF_Core\SERVER\script_macros.hpp"
// --- Readiness flag defined at boot (fix undefined variable spam) ---
ALF_serverReady = false;
publicVariable "ALF_serverReady";

// --- Headless Client Ready flags (broadcast from SERVER for JIP compatibility) ---
MRP_HC1_Ready = false;
publicVariable "MRP_HC1_Ready";
MRP_HC2_Ready = false;
publicVariable "MRP_HC2_Ready";
MRP_HC3_Ready = false;
publicVariable "MRP_HC3_Ready";

// Fonction appelée par les HCs pour signaler qu'ils sont prêts
ALF_Server_fnc_setHCReady = {
    params ["_hcNumber"];
    switch (_hcNumber) do {
        case 1: { MRP_HC1_Ready = true; publicVariable "MRP_HC1_Ready"; diag_log "[ALF_Server] HC1 Ready - publicVariable sent from SERVER"; };
        case 2: { MRP_HC2_Ready = true; publicVariable "MRP_HC2_Ready"; diag_log "[ALF_Server] HC2 Ready - publicVariable sent from SERVER"; };
        case 3: { MRP_HC3_Ready = true; publicVariable "MRP_HC3_Ready"; diag_log "[ALF_Server] HC3 Ready - publicVariable sent from SERVER"; };
    };
};

// === Variables anti-cheat / leurres (broadcast auto) ===
private _trapVars = [
    "IHBYYVHBOLLOUJUBIOJNOOIYUGU",
    "LACLEQUISERTAFAIRECRASHTONJEU",
    "PSOUZUYBBDIDIIDODOVYYYSONOO",
    "NSDJHBKJNZDIHKJIZYGDIJUIHZS",
    "VARIABLESECUALFCHEHGETREKT"
];
{ missionNamespace setVariable [_x, false, true]; } forEach _trapVars;

/* -- Init client config -- */
[] call ALFCore_fnc_initClientConfig;

ALF_isUnderMaintenance = false;

/* Event handler for disconnecting players */
addMissionEventHandler ["HandleDisconnect",{_this call TON_fnc_clientDisconnect; false;}];
[] call ALFCore_fnc_initFunctions;
[] call ALFCore_fnc_initConfig;

addMissionEventHandler ["Ended", {
    diag_log format ["ALF_End_Game : %1",_this select 0];
}];

//Fonctions serveur.
[] spawn ALFCore_fnc_ALF_Dealer;
[] call ALFCore_fnc_ALF_Eggs;

disableRemoteSensors true;

/* -- SETUP SERVER -- */

diag_log "-------------------------------------------------------------------------------------------------------------------";
diag_log "----------------------------------------- Initialization - ALF ----------------------------------------------------";
diag_log "-------------------------------------------------------------------------------------------------------------------";

ALF_extDB_notLoaded = "";
_timeStamp = diag_tickTime;

if(isNil {uiNamespace getVariable "life_sql_id"}) then {
	private _sql_id_raw = round(random(9999));
	life_sql_id = compileFinal str _sql_id_raw;

	uiNamespace setVariable ["life_sql_id",life_sql_id];

	// Broadcast SQL ID pour les Headless Clients
	ALF_sql_id_raw = str _sql_id_raw;
	publicVariable "ALF_sql_id_raw";
	ALF_db_name = getText(configFile >> "CfgServer" >> "DatabaseName");
	publicVariable "ALF_db_name";

	try {
		private _result = "extDB3" callExtension format["9:ADD_DATABASE:%1",ALF_db_name];
		if !(_result isEqualTo "[1]") then {throw "[ALF - SERVER] extDB3: Error with Database Connection"};
		_result = "extDB3" callExtension format["9:ADD_DATABASE_PROTOCOL:%2:SQL:%1:TEXT2",call life_sql_id,ALF_db_name];
		if !(_result isEqualTo "[1]") then {throw "[ALF - SERVER] extDB3 : Error with Database Connection"};
	} catch {
		ALF_extDB_notLoaded = [true, _exception];
	};

	publicVariable "ALF_extDB_notLoaded";
	if(ALF_extDB_notLoaded isEqualType []) exitWith {
		diag_log "[ALF - SERVER] extDB3 : Error with Database Connection";
	};
	"extDB3" callExtension "9:LOCK";
	diag_log "[ALF - SERVER] extDB3 : Connected to Database";
} else {
	life_sql_id = uiNamespace getVariable "life_sql_id";
};
if(ALF_extDB_notLoaded isEqualType []) exitWith {
	diag_log "[ALF - SERVER] extDB3 : Error with Database Connection";
};

/* -- Setup Request System -- */
private _getServerStatus = ("ALF_Core" callExtension "ALF_API_GetServerStatus");
if (_getServerStatus isEqualTo "") exitWith {
    diag_log "[ALF Core - API] STOP INIT - dll not Loaded";
	ALF_DLL_Loaded = false;publicVariable "ALF_DLL_Loaded";
};

//private _retVal = [] call ALFCore_fnc_startRequests;
//if !(_retVal) exitWith {ALF_DLL_Loaded = false;publicVariable "ALF_DLL_Loaded";};
ALF_DLL_Loaded = true;
publicVariable "ALF_DLL_Loaded";

["CALL deleteDeadVehicles",1] call ALF_Server_fnc_asyncCall;
["CALL deleteOldForfait",1] call ALF_Server_fnc_asyncCall;
["CALL deleteOldSms",1] call ALF_Server_fnc_asyncCall;

[] spawn ALF_Server_fnc_initCNG;
[] spawn ALF_Server_fnc_initCNP;
[] spawn ALF_Server_fnc_initCNPM;
[] spawn ALF_Server_fnc_initCoffre;
[] spawn ALF_Server_fnc_initBanqueSang;
[] spawn ALF_Server_fnc_initBourse;
[] spawn ALF_Server_fnc_randomEvent;

ALF_allMarkers_Depanneur = [];
ALF_allMarkers_DIR = [];
ALF_allMarkers_Gendarme = [];
ALF_allMarkers_Pompier = [];
alf_GN_Command = [];
ALF_fireON = false;
publicVariable "ALF_fireON";
ALF_allAmbianceFeux = [];
ALF_HC_Fire = [];
publicVariable "ALF_HC_Fire";

// === HEADLESS CLIENT SYSTEM ===
// Flags pour savoir si les HCs sont connectes (set par les HCs via publicVariable)
diag_log "[MRP_HC] Systeme Headless Client initialise - En attente des HC...";

// === FALLBACK: Si aucun HC apres 120 secondes, lancer sur le serveur ===
[] spawn {
    sleep 120;

    if (isNil "MRP_HC1_Ready" || {!MRP_HC1_Ready}) then {
        diag_log "[MRP_HC] FALLBACK: hc_1 non pret apres 120s - Lancement sur SERVEUR";
        [] spawn ALF_Server_fnc_cleanup;
        [] spawn ALF_Server_fnc_appleSystem;
        [] spawn ALF_Server_fnc_raisinSystem;
        [] spawn ALF_Server_fnc_spawnAlgues;
        [] spawn ALF_Server_fnc_sanctuaireTurtles;
    };

    if (isNil "MRP_HC2_Ready" || {!MRP_HC2_Ready}) then {
        diag_log "[MRP_HC] FALLBACK: hc_2 non pret apres 120s - Lancement sur SERVEUR";
        [] spawn ALF_Server_fnc_feuForet;
        [] spawn ALF_Server_fnc_startEventFire;
        [] spawn ALF_Server_fnc_startEventOrgane;
        [] spawn ALF_Server_fnc_wreckEventStart;
        [] spawn ALF_Server_fnc_countService;
    };

    if (isNil "MRP_HC3_Ready" || {!MRP_HC3_Ready}) then {
        diag_log "[MRP_HC] FALLBACK: hc_3 non pret apres 120s - Lancement sur SERVEUR";
        [] spawn ALF_Server_fnc_countDownForfait;
        [] spawn ALF_Server_fnc_countDownBracelet;
        [] spawn ALF_Server_fnc_countDownPrison;
        [] spawn ALF_Server_fnc_initReboot;
    };

    diag_log "[MRP_HC] Verification des HC terminee";
};

[] call ALF_Server_fnc_checkAxa;
[] call ALF_Server_fnc_initHouses;
/*
[] spawn {
	sleep 5; // Attendre que toutes les maisons soient bien chargées dans le monde et que les variables soient initialisées
	// Vérifier que les variables de mobilier sont disponibles
	waitUntil {sleep 1; !isNil "ALF_Mobiliers_Objects" && !isNil "ALF_Mobiliers_Objects_Data"};
	diag_log "[initServer] Variables de mobilier disponibles, chargement des meubles...";
	[] call ALF_Server_fnc_loadAllFurniture;
};
*/
[] call ALF_Server_fnc_initLocaux;
[] call ALF_Server_fnc_initBusiness;
// [] call ALF_Server_fnc_initStation;
// TEMPORAIRE — distributeur désactivé
// [] call ALF_Server_fnc_distrib_initAllMachines;
// Verrouiller toutes les portes de toutes les maisons achetables après l'initialisation
[] spawn {
	sleep 2; // Attendre que toutes les initialisations soient terminées
	[] call ALF_Server_fnc_cfghouseclassnameslock;
};
[] call ALF_Server_fnc_spawnVehicleLaunch;
[] spawn ALF_Server_fnc_dirObjEventStart;
[] spawn ALF_Server_fnc_EnedisEventStart;
[] call ALF_Server_fnc_receleurInit;
[] call ALF_Server_fnc_initEboueur;

// === vehicleAutoSync sur SERVEUR (dbInfo non broadcast) ===
[] spawn
{
    for "_i" from 0 to 1 step 0 do
	{
    	sleep (5 * 60);
    	[] spawn ALF_Server_fnc_vehicleAutoSync;
    };
};

[] execFSM "\ALF_Core\SERVER\ALF_FSM\cleanup.fsm";
[4,true,8] execFSM "\ALF_Core\SERVER\ALF_FSM\timeModule.fsm";

// === Disable ===
// [] spawn MRPV2_Server_fnc_Divers_Objets_Carte_En_Objet_Simple; // → hc_1 (MRP_HC1_fnc_objetsCarteEnObjetSimple)
// [] spawn ALF_Server_fnc_tresorSystem;
// [] spawn ALF_Server_fnc_feuTricolore;
// [] spawn ALF_Server_fnc_casseFeuTricolore;
// [] spawn ALF_Server_fnc_eboueurSystem;

/*
// Chargement automatique du mapping de Noël
[] spawn {
	sleep 1; // Attendre un peu que le serveur soit prêt
	private _path = "\ALF_Core\CLIENT\MRPV2_Mapping\noel_martinique.sqf";
	if (fileExists _path) then {
		[] execVM _path;
		diag_log "[MAPPING] Mapping 'noel_martinique' chargé automatiquement au démarrage du serveur.";
	} else {
		diag_log format ["[MAPPING ERROR] Le fichier '%1' est introuvable.", _path];
	};
};
*/
// Rajout par NorX : init Zone chasse
// Paramètres : Nom marqueur zone,max animaux vivant,max animaux mort,rayon d'entrer zone,durée boucle

private _liste_Zone_Chasse = allMapMarkers select {"zone_chasse" in tolower str _x};
{
	[_x,20,20,100,5] spawn ALF_Server_fnc_huntingZone;
} foreach _liste_Zone_Chasse;

[] spawn 
{// On attend un peu histoire que les pnj est le temps de bien spawn avant de les verrouiller, voir si ca regle le pnj de travers
	// sleep 5;
	private _liste_PNJ = (8 allObjects 1) select {"MRPV2_PNJ" in str _x};
	{
		[_x] spawn ALF_Server_fnc_ambientAnim;
		sleep 0.05;
	} foreach _liste_PNJ;
};

/* 
private _object = [11006.8,3743.75,0] nearObjects ["Land_ALF_Prison_Part2",20];
_object = _object select 0;
_pos1 = AGLToASL (_object modelToWorld [11.2549,5.49805,-2.15601]);
_pos2 = AGLToASL (_object modelToWorld [11.3213,4.75586,-2.19031]);
[{
	_prison = (_this select 0) select 0;
	_ins = lineIntersectsSurfaces [
		(_this select 0) select 1,
		(_this select 0) select 2,
		_prison,
		objNull,
		true,
		1,
		"GEOM",
		"NONE"
	];
	if (count _ins == 0) exitWith {};
	if (((_ins select 0) select 3) isKindOf "Man" && {(!((weapons ((_ins select 0) select 3)) isEqualTo []))}) then {
        playSound3D ["ALF_Client2\sounds\ALF_CB1.ogg", objNull, false, ((_ins select 0) select 0), 1, 1, 35];
    };
}, 0, [_object,_pos1,_pos2]] call CBA_fnc_addPerFrameHandler;
*/
/* -- END HC 3 -- */

private _liste_Joueur_Avec_Maison_Temp = flatten (["SELECT players.playerid
FROM players
INNER JOIN Houses
WHERE players.playerid = Houses.pid",2,true] call ALF_Server_fnc_asyncCall);

private _liste_Joueur_Avec_Maison = [];
{_liste_Joueur_Avec_Maison pushBackUnique _x;} foreach _liste_Joueur_Avec_Maison_Temp;


{[_x] spawn ALF_Server_fnc_fetchPlayerHouses;} forEach _liste_Joueur_Avec_Maison;

setMissionOptions createHashMapFromArray 
[
	["IgnoreNoDamage", true],
	["IgnoreFakeHeadHit", true],
	["IgnoreUpsideDownDamage", true],
	["AIThinkOnlyLocal", true]
];

// --- Heure personnalisée au démarrage
setDate [2025, 10, 7, 00, 00];   // [année, mois, jour, heure, minute]

[] call MRPV2_Server_fnc_Divers_Init_Var_Heure_Session;
// Marquer le serveur comme prêt après toutes les initialisations
ALF_serverReady = true;
publicVariable "ALF_serverReady";
diag_log "[ALF_serverReady] Server marked as READY - publicVariable sent";

[] spawn ALF_Server_fnc_spawnFire_serveur;

diag_log "-------------------------------------------------------------------------------------------------------------------";
diag_log format ["ALF Framework Ready :: Executed in %1 seconds ", (diag_ticktime - _timeStamp)];
diag_log "-------------------------------------------------------------------------------------------------------------------";