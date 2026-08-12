/*
    File: fn_eboueur_initMission.sqf
    Author: MRP
    Description: Prise de service éboueur
    
    CORRECTIONS:
    - Fix camion plein au spawn
    - Ordre d'initialisation corrigé
    - Logs debug ajoutés
*/

if (!alive player) exitWith {};

if (!isNil {player getVariable "MRP_Eboueur_EnService"}) exitWith {
    ["Éboueur", "Déjà en service", "danger"] spawn ALF_fnc_doMsg;
};

if (!license_driver) exitWith {
    ["Éboueur", "Pas de permis de conduire", "danger"] spawn ALF_fnc_doMsg;
};

if (!license_eboueur) exitWith {
    ["Éboueur", "Pas de licence éboueur. Allez à la préfecture.", "danger"] spawn ALF_fnc_doMsg;
};

// Initialisation variables
MRP_EboueurEnCours = false;
MRP_PoubelleAttachee = objNull;


// Vérifier places disponibles
private _nearestCar1 = nearestObjects [[3278,4337,0], ["Car"], 5];
private _nearestCar2 = nearestObjects [[3272,4337,0], ["Car"], 5];
private _nearestCar3 = nearestObjects [[3268,4337,0], ["Car"], 5];
private _nearestCar4 = nearestObjects [[3262,4337,0], ["Car"], 5];

private _markerPos = [3278,4337,0];
private _markerDir = 0;

if (count _nearestCar1 > 0) then {
	private _markerPos = [3272,4337,0],;
	private _markerDir = 0;
};

if (count _nearestCar2 > 0) then {
	private _markerPos = [3268,4337,0],;
	private _markerDir = 0;
};

if (count _nearestCar3 > 0) then {
	private _markerPos = [3262,4337,0],;
	private _markerDir = 0;
};

if ((count _nearestCar1 > 0) && (count _nearestCar2 > 0) && (count _nearestCar3 > 0) && (count _nearestCar4 > 0)) exitWith {
    ["Éboueur", "Points de sortie encombrés!", "danger"] spawn ALF_fnc_doMsg;
};


private _vehicle = "VEH_Mercura_MRP_Volvo_Poubelle" createVehicle _markerPos;
_vehicle setDir _markerDir;

// === CORRECTION 1 : INIT ORDURES À 0 EN PREMIER ===
_vehicle setVariable ["MRP_Eboueur_NbOrdures", 0, true];


// Configuration véhicule
private _plaque = [] call MRPV2_fnc_Vehicule_Creation_Plaque;
life_vehicles pushBack _vehicle;
_vehicle setVariable ["owner", getPlayerUID player, true];
_vehicle setVariable ["vehicle_info_owners", ["", getPlayerUID player], true];
_vehicle setVariable ["dbInfo", [(getPlayerUID player), _plaque, 1, 10, 0], true];
_vehicle setVariable ["Flashed", false, true];
_vehicle setPlateNumber _plaque;

// === CORRECTION 2 : VIDER TOUT LE COFFRE ===
clearItemCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearWeaponCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;

// Reset animations
_vehicle animateSource ["ordure_10_source", 0];
_vehicle animateSource ["ordure_50_source", 0];
_vehicle animateSource ["ordure_100_source", 0];

// Texture plaque
private _plaqueArray = _plaque splitString "";
_vehicle setObjectTextureGlobal [1, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa", _plaqueArray select 0]];
_vehicle setObjectTextureGlobal [2, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa", _plaqueArray select 1]];
_vehicle setObjectTextureGlobal [3, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa", _plaqueArray select 3]];
_vehicle setObjectTextureGlobal [4, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa", _plaqueArray select 4]];
_vehicle setObjectTextureGlobal [5, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa", _plaqueArray select 5]];
_vehicle setObjectTextureGlobal [6, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa", _plaqueArray select 7]];
_vehicle setObjectTextureGlobal [7, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa", _plaqueArray select 8]];

// Enregistrement
if (isNil "MRP_EBOUEUR_CARS") then {
    MRP_EBOUEUR_CARS = [[_plaque, player]];
} else {
    MRP_EBOUEUR_CARS pushBack [_plaque, player];
};
publicVariable "MRP_EBOUEUR_CARS";

// Variables joueur
MRP_Eboueur_EnService = true;
player setVariable ["MRP_Eboueur_EnService", true, true];
player setVariable ["MRP_Eboueur_Camion", _vehicle, true];
player setVariable ["MRP_Eboueur_NbColisRamasses", 0, true];
player setVariable ["MRP_Eboueur_Collegue", getPlayerUID player, true];

// Ajouter actions
[_vehicle] call ALF_fnc_eboueur_ajouterActions;

_ville = "";
_EboueurZoneTourne = player getVariable ["MRP_Eboueur_Zone", ""];

if (_EboueurZoneTourne isEqualTo "") then {
_EboueurZoneList = missionNamespace getVariable ["MRP_Eboueur_ZoneDIspo", []];
_EboueurZoneTourne = selectRandom _EboueurZoneList;
player setVariable ["MRP_Eboueur_Zone", _EboueurZoneTourne, true];
};

switch (_EboueurZoneTourne) do {
    case "AU" : {_ville = "L'Autoroute"};
    case "VA" : {_ville = "Le Vauclin"};
    case "FR" : {_ville = "Le François"};
    case "TR" : {_ville = "Trinité"};
    case "LO" : {_ville = "Le Lorrain"};
    case "MA" : {_ville = "Grand'Rivière"};
    case "ST" : {_ville = "Saint Pierre"};
    case "FD" : {_ville = "Fort-De-France"};
    case "AN" : {_ville = "Les Ansles D'Arlet"};
    case "MR" : {_ville = "Le Marin"};
};

private _msg = format ["Vous devez rammaser les poubelles dans le secreur de %1 (Position indiqué sur votre GPS)", _ville];
["Éboueur", _msg, "success"] spawn ALF_fnc_doMsg;

["Éboueur", "Service démarré! Collectez les poubelles.", "success"] spawn ALF_fnc_doMsg;