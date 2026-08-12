/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/

// hideObjectGlobal et checkOnConnect déjà appelés dans initPlayerLocal.sqf

diag_log "------------------------------------------------------------------------------------------------------";
diag_log "---------------------------- Starting Martinique RP Client Init -----------------------------------";
diag_log "------------------------------------------------------------------------------------------------------";

disableSerialization;
0 cutRsc ["init_progress","BLACK FADED"];
0 cutFadeOut 9999999;
private _ui = uiNamespace getVariable "init_progress";
private _progressBar = _ui displayCtrl 38301;
private _titleText = _ui displayCtrl 38302;
private _img = _ui displayCtrl 38303;


_titleText ctrlSetText format["Initialisation de la DLL ... (10%1)...","%"];
_img ctrlSetText selectRandom["\LIFE_Client\1.jpg","\LIFE_Client\2.jpg","\LIFE_Client\3.jpg","\LIFE_Client\4.jpg"];
_progressBar progressSetPosition 0.1;

waitUntil {sleep 0.3; !(isNil "ALF_DLL_Loaded")};
_progressBar progressSetPosition 0.1;
0 cutFadeOut 99999999;

if !(ALF_DLL_Loaded) exitWith 
{
	_titleText ctrlSetText "Erreur lors du chargement de la DLL !";
	_progressBar progressSetPosition 0;
	0 cutFadeOut 99999999;
};

_titleText ctrlSetText format["Initialisation du client... (20%1)...","%"];
_progressBar progressSetPosition 0.2;
0 cutFadeOut 99999999;
// hint "1";
waitUntil {uiSleep 0.3; !(isNull (findDisplay 46))};
waitUntil {uiSleep 0.3; !isNull player};

_titleText ctrlSetText format["Initialisation du client... (30%1)...","%"];
_progressBar progressSetPosition 0.3;

life_firstSpawn = true;
life_session_completed = false;
// hint "2";
enableSentences false;
[] call ALF_fnc_configuration;
player setVariable ["tf_voiceVolume", 0, true];
// hint "3";
//Erreur de connection base de donnée.
waitUntil{sleep 0.3; !isNil "ALF_extDB_notLoaded"};

if(ALF_extDB_notLoaded isEqualType []) exitWith 
{
	_titleText ctrlSetText "Erreur base de données.";
	_progressBar progressSetPosition 0;
	0 cutFadeOut 99999999;
};

_titleText ctrlSetText format["Initialisation du client... (40%1)...","%"];
_progressBar progressSetPosition 0.4;

// hint "4";
//On attend que le server soit pret !
waitUntil{sleep 0.3; !isNil "ALF_serverReady"};
waitUntil{sleep 0.3; ALF_serverReady};

_titleText ctrlSetText format["Initialisation du client... (50%1)...","%"];
_progressBar progressSetPosition 0.5;

// Attendre que les 3 Headless Clients soient prets
_titleText ctrlSetText format["Initialisation des HeadLess Clients... (55%1)...","%"];
_progressBar progressSetPosition 0.55;

// OPTIMISE: Ajout timeout 180s pour eviter freeze JIP si un HC ne demarre pas
private _hcTimeout = diag_tickTime + 10; // 3 minutes max
waitUntil {
	sleep 0.3;
	(diag_tickTime > _hcTimeout) OR {
		(!isNil "MRP_HC1_Ready" && !isNil "MRP_HC2_Ready" && !isNil "MRP_HC3_Ready") &&
		{missionNamespace getVariable ["MRP_HC1_Ready", false] && 
		 missionNamespace getVariable ["MRP_HC2_Ready", false] && 
		 missionNamespace getVariable ["MRP_HC3_Ready", false]}
	}
};
if (diag_tickTime > _hcTimeout) then {
	diag_log "[MRP][WARNING] HC timeout atteint apres 180s - continuation sans tous les HC ready";
	hint "Attention: Certains Headless Clients ne sont pas disponibles. Certaines fonctionnalites peuvent etre limitees.";
};

// hint "5";
//On récupère les informations du joueur.
[] call SOCK_fnc_dataQuery;
waitUntil {sleep 0.3; life_session_completed};
if (isNil "MRP_rebr_loopStarted") then {
    missionNamespace setVariable ["MRP_rebr_loopStarted", true];

    if (isNil "MRPV2_fnc_rebreatherLoop") then {
        MRPV2_fnc_rebreatherLoop = compileFinal preprocessFileLineNumbers "\ALF_Core\CLIENT\MRPV2_Fonctions\Diving\fn_rebreatherLoop.sqf";
    };
    [] spawn MRPV2_fnc_rebreatherLoop;
};

_titleText ctrlSetText format["Initialisation de la mission... (60%1)...","%"];
_progressBar progressSetPosition 0.6;
0 cutFadeOut 9999999;

[] call ALF_fnc_setupEVH;

//Initialize Civilian Settings
private _handle = [] spawn ALF_fnc_initPlayer;
waitUntil {sleep 0.3; scriptDone _handle};
/*
// Surveiller les portes de maisons
[] spawn ALF_fnc_monitorHouseDoors;
*/
_titleText ctrlSetText format["Initialisation de la mission... (70%1)...","%"];
_progressBar progressSetPosition 0.7;

//ClientID pour les HCs.
life_fnc_RequestClientId = player;
publicVariableServer "life_fnc_RequestClientId"; 

ALFBOURSE_NbAchat = [];
[player] remoteExecCall ["ALF_Server_fnc_loggedBourse",2];

//On récupère les maisons du joueur et on place les mobiliers.
// [player,getPlayerUID player] remoteExecCall ["ALF_Server_fnc_fetchPlayerHouses",2];

// placage marqueur maison joueur
[player] remoteExec ['MRPV2_Server_fnc_Divers_Recup_Liste_Maison_Joueur',2];

//On récupère les clés des véhicules présent sur le serveur.
if (life_coplevel > 0) then 
{
	if (life_mediclevel > 0) then 
	{
		[player,3] remoteExecCall ["ALF_Server_fnc_getVehiclesKeys",2];
	} else 
	{
		if (life_penit > 0) then
		{
			[player,4] remoteExecCall ["ALF_Server_fnc_getVehiclesKeys",2];
		}else
		{
			[player,1] remoteExecCall ["ALF_Server_fnc_getVehiclesKeys",2];
		};		
	};
} else 
{
	if (life_mediclevel > 0) then 
	{
		[player,2] remoteExecCall ["ALF_Server_fnc_getVehiclesKeys",2];
	} else 
	{
		if (life_penit > 0) then
		{
			[player,4] remoteExecCall ["ALF_Server_fnc_getVehiclesKeys",2];
		}else
		{
			[player,0] remoteExecCall ["ALF_Server_fnc_getVehiclesKeys",2];
		};
	};
};

// On récupère les véhicules du joueur et on lui donne les clés.
private _liste_Vehicules_Du_Joueur = ((8 allObjects 1) select 
{
	_x iskindof "allvehicles" AND
	{((_x getVariable ["vehicle_info_owners",["",""]]) # 1) isequalto (getPlayerUID player)}
});

{if !(_x in life_vehicles) then {life_vehicles pushback _x;};} foreach _liste_Vehicules_Du_Joueur;

setTerrainGrid 25;

waitUntil {sleep 0.3; !(isNull (findDisplay 46))};
(findDisplay 46) displayAddEventHandler ["KeyDown", "_this call ALF_fnc_keyHandler"];

ALF_fnc_moveIn = compileFinal "
	life_disable_getIn = false;
	player moveInCargo (_this select 0);
	life_disable_getOut = true;
";

_titleText ctrlSetText format["Initialisation de la mission... (80%1)...","%"];
_progressBar progressSetPosition 0.8;

tf_no_auto_long_range_radio = true;
player setVariable ["tf_unable_to_use_radio",true];

[] call MRPV2_fnc_MRP_Tel_Init_Joueur;

[] spawn ALF_fnc_hudSetup;
[] spawn ALF_fnc_survival;
[] spawn ALF_fnc_interaction3D;
[] spawn ALF_fnc_initClientEboueur;
[] spawn ALF_fnc_initClientBusJob;
[] spawn ALF_fnc_initClientTaxi;
[] spawn ALF_fnc_initClientAmbulancier;
// TEMPORAIRE — distributeur désactivé
// [] spawn ALF_fnc_initClientDistrib;
[] spawn ALF_fnc_initBIE; //A disable si lag
// SUPPRIMÉ: Double spawn rebreatherLoop - déjà lancé ligne 116 avec guard MRP_rebr_loopStarted
// [] spawn MRPV2_fnc_rebreatherLoop;
player setVariable ["tf_voiceVolume", 1, true];
player action ["SwitchWeapon", player, player, -1];

ALF_itsTimeToLoadTFAR = true;

_titleText ctrlSetText format["Initialisation de TASK FORCE RADIO... (90%1)...","%"];
_progressBar progressSetPosition 0.9;
0 cutFadeOut 9999999;

ALF_itsTimeToLoadTFAR = false;
waitUntil {sleep 0.3; !(ALF_itsTimeToLoadTFAR)};

// Configuration des distances de voix TFAR pour corriger le problème de chuchotement
[] spawn ALF_fnc_configureTFARVoiceDistance;

enableEnvironment [false, true];
player allowDamage true;
cutText ["","BLACK IN",10]; 
10 fadeSound 1;
[player,FALSE] remoteExecCall ["hideObjectGlobal",2];

//Fin de l'init du joueur. Si il se reconnect avec un life_is_alive = false, on le bute!!!!!
if !(life_is_alive) then {player setDamage 1;};

disableRemoteSensors true;

// On désactive les touches de TFAR comme le menu ou le changement de canal par pavé numerique
// private _liste_Action_Appel_TFAR = ["SWTransmit","SWTransmitAdditional","LRTransmit","LRTransmitAdditional"];
private _liste_Action_Stereo_TFAR = ["SWStereoBoth","SWStereoLeft","SWStereoRight","LRStereoBoth","LRStereoLeft","LRStereoRight"];
private _liste_Action_Cannaux_TFAR = ["SWChannel1","SWChannel2","SWChannel3","SWChannel4","SWChannel5","SWChannel6","SWChannel7","SWChannel8"];
private _liste_Action_Menu_TFAR = ["OpenSWRadioMenu","OpenLRRadioMenu"];
private _liste_Action_Cycle_Radio = ["CycleSRRadiosNext","CycleSRRadiosPrev","CycleLRRadiosNext","CycleLRRadiosPrev","CycleSRRadioChannelNext","CycleSRRadioChannelPrev","CycleLRRadioChannelNext","CycleLRRadioChannelPrev"];
// private _liste_Action_Final = (_liste_Action_Appel_TFAR + _liste_Action_Stereo_TFAR + _liste_Action_Cannaux_TFAR + _liste_Action_Menu_TFAR + _liste_Action_Cycle_Radio);
private _liste_Action_Final = (_liste_Action_Stereo_TFAR + _liste_Action_Cannaux_TFAR + _liste_Action_Menu_TFAR + _liste_Action_Cycle_Radio);

{
	private _raccourcis = _x;

	private _configuration_Raccourcis_TFAR = ["TFAR",_raccourcis] call CBA_fnc_getKeybind;
	_configuration_Raccourcis_TFAR set [3,{[] call TFAR_fnc_hideHint;}];
	_configuration_Raccourcis_TFAR set [4,{[] call TFAR_fnc_hideHint;}];
	_configuration_Raccourcis_TFAR set [8,TRUE];

	_configuration_Raccourcis_TFAR call CBA_fnc_addKeybind;
} foreach _liste_Action_Final;

if !(isnil {call TFAR_fnc_ActiveSwRadio}) then {[call TFAR_fnc_ActiveSwRadio,""] call TFAR_fnc_setSwFrequency;};

showHUD 
[
	true, // scriptedHUD 
	true, // info 
	FALSE, // radar 
	true, // compass 
	FALSE, // direction 
	true, // menu 
	FALSE, // group 
	true, // cursors 
	true, // panels 
	FALSE, // kills 
	true  // showIcon3D 
];

// Verrouillage des casiers a l'init joueur PAS Actif pr le moment
// {_x lockInventory true;} foreach (allMissionObjects "land_MRP_MEUBLE_COFFRE_casier");