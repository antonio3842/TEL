params[
	["_type",0]
];
//_type = 0 --> Fourgon
//_type = 1 --> Nacelle

if (!license_driver) exitWith {
    ["Enedis", "Pas de permis de conduire", "danger"] spawn ALF_fnc_doMsg;
};

_veh = player getVariable ["MRP_Bie_Camion", objNull];

if (!isnull _veh) exitWith {
    ["Enedis", "Vous avez déjà un véhicule attribué!", "danger"] spawn ALF_fnc_doMsg;
};

private _spawn1 = [6690.25,6212.45,0]; // Marqueur spawn 1
private _spawn2 = [6693.77,6201.86,0]; // Marqueur spawn 2
private _rayonDetection = 10; // Rayon en mètres pour détecter les véhicules

// --- Fonction pour vérifier si un emplacement est libre ---
private _fnc_estLibre = {
    params ["_position", "_rayon"];
    private _vehiculesProches = _position nearObjects ["LandVehicle", _rayon];
    (count _vehiculesProches == 0)
};

// --- Vérification des emplacements ---
private _spawn1Libre = [_spawn1, _rayonDetection] call _fnc_estLibre;
private _spawn2Libre = [_spawn2, _rayonDetection] call _fnc_estLibre;

// --- Logique de sélection ---
private _spawnChoisi = [];

if (_spawn1Libre) then {
    _spawnChoisi = _spawn1;
} else {
    if (_spawn2Libre) then {
        _spawnChoisi = _spawn2;
    };
};

if (count _spawnChoisi == 0 ) exitWith {
    ["Enedis", "Points de sortie encombrés!", "danger"] spawn ALF_fnc_doMsg;
};
private _vehicle = objNull;
// --- Spawn du véhicule si un emplacement a été trouvé ---
if (_type == 1) then {
	_vehicle = createVehicle ["V_ALF_Sprinter_C_Enedis_MRPV2", _spawnChoisi, [], 0, "CAN_COLLIDE"];
} else {
	_vehicle = createVehicle ["V_ALF_Berlingo_BIE_MRPV2", _spawnChoisi, [], 0, "CAN_COLLIDE"];
};

_vehicle setDir 71.048;

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
if (isNil "MRP_BIE_CARS") then {
    MRP_BIE_CARS = [[_plaque, player]];
} else {
    MRP_BIE_CARS pushBack [_plaque, player];
};
publicVariable "MRP_BIE_CARS";
player setVariable ["MRP_Bie_Camion", _vehicle, true];
["Enedis", "Camion en place", "success"] spawn ALF_fnc_doMsg;