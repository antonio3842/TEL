if (!alive player) exitWith {};
if (!isNil {player getVariable "MRP_Ambulancier_EnService"}) exitWith {
    ["Ambulancier", "Déjà en service", "danger"] spawn ALF_fnc_doMsg;
};

if (!license_driver) exitWith {
    ["Ambulancier", "Pas de permis de conduire", "danger"] spawn ALF_fnc_doMsg;
};

if (!license_ambulancier) exitWith {
    ["Ambulancier", "Pas de licence ambulancier. Allez à la préfecture.", "danger"] spawn ALF_fnc_doMsg;
};

// Initialisation variables
MRP_AmbulancierEnCours = false;
MRP_Ambulancier_Destination = "";

_type = param[0,""];
if (_type isEqualTo "") exitWith {
    ["Ambulancier", "Erreur de destination", "danger"] spawn ALF_fnc_doMsg;
};
_nearestCar1 = nil;
_nearestCar2 = nil;
_nearestCar3 = nil;
_markerPos = nil;
_markerDir = nil;
// Vérifier places disponibles
if (_type isEqualTo (toLowerANSI "MRPV2_PNJ_Emploi_Ambulancier_1")) then {
    _nearestCar1 = nearestObjects [[4499.829,5399.792,0], ["Car"], 5];
    _nearestCar2 = nearestObjects [[4488.851,5403.8,0], ["Car"], 5];
    _nearestCar3 = nearestObjects [[4477.594,5408.16,0], ["Car"], 5];

    _markerPos = [4499.829,5399.792,0];
    _markerDir = 291.648;

    if (count _nearestCar1 > 0) then {
        private _markerPos = [4488.851,5403.8,0];
        private _markerDir = 291.648;
    };

    if (count _nearestCar2 > 0) then {
        private _markerPos = [4477.594,5408.16,0];
        private _markerDir = 291.648;
    };
} else {
    _nearestCar1 = nearestObjects [[6531.914,7267.961,0], ["Car"], 5];
    _nearestCar2 = nearestObjects [[6520.19,7267.386,0], ["Car"], 5];
    _nearestCar3 = nearestObjects [[6508.306,7266.933,0], ["Car"], 5];

    _markerPos = [6531.914,7267.961,0];
    _markerDir = 267.284;

    if (count _nearestCar1 > 0) then {
        private _markerPos = [6520.19,7267.386,0];
        private _markerDir = 267.284;
    };

    if (count _nearestCar2 > 0) then {
        private _markerPos = [6508.306,7266.933,0];
        private _markerDir = 267.284;
    };
};


if ((count _nearestCar1 > 0) && (count _nearestCar2 > 0) && (count _nearestCar3 > 0)) exitWith {
    ["Ambulancier", "Points de sortie encombrés!", "danger"] spawn ALF_fnc_doMsg;
};


private _vehicle = "V_ALF_Mercedes_Benz_Ambulance_MRPV2" createVehicle _markerPos;
_vehicle setDir _markerDir;

_vehicle setVariable ["MRP_Ambulancier", false, true];


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
if (isNil "MRP_AMBULANCIER_CARS") then {
    MRP_AMBULANCIER_CARS = [[_plaque, player]];
} else {
    MRP_AMBULANCIER_CARS pushBack [_plaque, player];
};
publicVariable "MRP_AMBULANCIER_CARS";

// Variables joueur
MRP_Ambulancier_EnService = true;
player setVariable ["MRP_Ambulancier_EnService", true, true];
player setVariable ["MRP_Ambulancier_Camion", _vehicle, true];
player setVariable ["MRP_Ambulancier", true, true];

["Ambulancier", "Service démarré! Vous pouvez récupérer votre véhicule de service.", "success"] spawn ALF_fnc_doMsg;