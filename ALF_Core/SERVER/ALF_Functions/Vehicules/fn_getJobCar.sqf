/*
	File: fn_getJobCar.sqf
	Author: ALF Adam
*/

params [
	["_classname","",[""]],
	["_posSpawn",[],[[]]],
	["_unit",objNull,[objNull]]
];

if (_classname isEqualTo "" || {_posSpawn isEqualTo []} || {isNull _unit}) exitWith {};

private _jobCar = missionNamespace getVariable [format["jobCar_%1",getPlayerUID _unit],objNull];
if (!(isNull _jobCar) && {alive _jobCar}) exitWith {["GARAGE", "Vous disposez déjà d'un véhicule de service.", "warning"] remoteExec ["ALF_fnc_doMsg",_unit];};

private _nearCar = _posSpawn nearEntities [["Car","Air","Ship"],10];
if (count _nearCar > 0) exitWith {["GARAGE", "Un véhicule est trop proche pour effectuer une sortie de garage.", "warning"] remoteExec ["ALF_fnc_doMsg",_unit];};

private _dispo = false;
private _vInfo = ["SELECT id, classname, type, active, plate FROM vehicles WHERE pid='eboueur'",2,true] call ALF_Server_fnc_asyncCall;
if (isNil "_vInfo" OR {_vInfo isEqualType ""} OR {count(_vInfo) isEqualTo 0}) exitWith {};

{
	if !((_x select 3) isEqualTo 1) exitWith {_vInfo = _vInfo select _forEachIndex; _dispo = true;};
} forEach _vInfo;

if !(_dispo) exitWith {["GARAGE", "Il n'y a plus de véhicule de service disponible.", "warning"] remoteExec ["ALF_fnc_doMsg",_unit];};

private _vid = _vInfo select 0;
[format["UPDATE vehicles SET active='1' WHERE pid='eboueur' AND id='%1'",_vid],1] spawn ALF_Server_fnc_asyncCall;

private _plate = [(_vInfo select 4)] call ALF_Server_fnc_mresToArray;
if(_plate isEqualType "") then {_plate = call compile format["%1", _plate];};

private _vehicle = _classname createVehicle [0,0,1000];
_vehicle allowDamage false;

_vehicle setPos _posSpawn;
_vehicle setVectorUp (surfaceNormal _posSpawn);

_vehicle allowDamage true;

//On donne les clés
[_vehicle] remoteExecCall ["ALF_fnc_addVehicle2Chain",_unit];
[getPlayerUID _unit,_vehicle,1] call ALF_Server_fnc_keyManagement;

_vehicle lock 2;
_vehicle setVariable ["vehicle_info_owners",["",getPlayerUID _unit],true];
_vehicle setVariable ["dbInfo",["eboueur",_plate]];
_vehicle setVariable ["Flashed",false];
_vehicle disableTIEquipment true;
[_vehicle] call ALF_fnc_clearVehicleAmmo;
_vehicle enableDynamicSimulation true;

_vehicle animateSource ["assu", 0, true];
["Garage","Votre véhicule de service est disponible, Dévérouille le et lance vous à la conquette des poubelles en ville","success",false] remoteExec ["ALF_fnc_doMsg",_unit];
missionNamespace setVariable [format["jobCar_%1",getPlayerUID _unit], _vehicle];

_vehicle animateSource ["tracker", 1, true];

_vehicle setObjectTextureGlobal [1, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plate select 0]];
_vehicle setObjectTextureGlobal [2, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plate select 1]];
_vehicle setObjectTextureGlobal [3, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plate select 3]];
_vehicle setObjectTextureGlobal [4, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plate select 4]];
_vehicle setObjectTextureGlobal [5, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plate select 5]];
_vehicle setObjectTextureGlobal [6, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plate select 7]];
_vehicle setObjectTextureGlobal [7, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plate select 8]];
/*
// Sélection d'une poubelle aléatoire pour afficher un marqueur
private _positions = [
    [3391.54,4242.19,0], [3646.28,4250.47,0], [3735.27,4026.95,0], [3677.88,4397.36,0],
    [3299.99,4438.6,0], [3958.27,4469.88,0], [3881.72,4532.32,0], [3881.33,4567.31,0],
    [3879.15,4610.89,0], [3751.87,4613.97,0], [4088.96,4693.52,0], [5269.69,4644.09,0],
    [4252.29,4251.71,0], [4576.74,4620.67,0], [4049.3,4507.16,0], [4561.75,4751.67,0],
    [4342.39,4327.4,0], [4807.37,4460.62,0], [4083.02,4310.32,0], [4706.43,4751.59,0]
];

private _randomPosition = selectRandom _positions;
diag_log format ["🔍 DEBUG: Position du marqueur sélectionnée -> %1", _randomPosition];
private _marker = createMarkerLocal ["eboueur_marker_", _randomPosition];
_marker setMarkerType "Mil_dot";
_marker setMarkerColor "ColorYellow";
_marker setMarkerTextLocal "Poubelle à vider";
_marker setMarkerAlpha 1;

// Suppression et réassignation après vidage
"fn_viderTrash" addPublicVariableEventHandler {
    deleteMarker "eboueur_marker_";
    private _newPosition = selectRandom _positions;
    diag_log format ["🔄 DEBUG: Nouvelle position sélectionnée -> %1", _newPosition];
    private _newMarker = createMarkerLocal ["eboueur_marker_", _newPosition];
    _newMarker setMarkerType "Mil_dot";
    _newMarker setMarkerColor "ColorYellow";
    _newMarker setMarkerTextLocal "Poubelle à vider";
    _newMarker setMarkerAlpha 1;
};
*/
/*
// Sélection d'une poubelle aléatoire pour afficher un marqueur
private _positions = [
    [3391.54,4242.19,0], [3646.28,4250.47,0], [3735.27,4026.95,0], [3677.88,4397.36,0],
    [3299.99,4438.6,0], [3958.27,4469.88,0], [3881.72,4532.32,0], [3881.33,4567.31,0],
    [3879.15,4610.89,0], [3751.87,4613.97,0], [4088.96,4693.52,0], [5269.69,4644.09,0],
    [4252.29,4251.71,0], [4576.74,4620.67,0], [4049.3,4507.16,0], [4561.75,4751.67,0],
    [4342.39,4327.4,0], [4807.37,4460.62,0], [4083.02,4310.32,0], [4706.43,4751.59,0]
];

private _randomPosition = selectRandom _positions;
diag_log format ["🔍 DEBUG: Position du marqueur sélectionnée -> %1", _randomPosition];
private _marker = createMarkerLocal ["eboueur_marker", _randomPosition];
_marker setMarkerTypeLocal "Mil_dot";
_marker setMarkerColorLocal "ColorYellow";
_marker setMarkerTextLocal "Poubelle à vider";
_marker setMarkerAlphaLocal 1;

// Suppression et réassignation après vidage basé sur la présence de "ALF_Dechets"
[] spawn {
    while {true} do {
        sleep 1;
        private _poubelle = nearestObjects [_randomPosition, ["ALF_Poubelle"], 10];
        if (count _poubelle > 0) then {
            _poubelle = _poubelle select 0;
            diag_log format ["🟢 DEBUG: Poubelle trouvée à %1", _randomPosition];
            waitUntil {
                sleep 1;
                private _dechetCount = {_x isEqualTo "ALF_Dechets"} count (magazineCargo _poubelle);
                diag_log format ["📦 DEBUG: Déchets restants dans la poubelle -> %1", _dechetCount];
                _dechetCount < 1;
            };
            deleteMarker "eboueur_marker";
            diag_log format ["🔄 DEBUG: Marqueur supprimé, nouvelle position sélectionnée"];
            _randomPosition = selectRandom _positions;
            private _newMarker = createMarkerLocal ["eboueur_marker", _randomPosition];
            _newMarker setMarkerTypeLocal "Mil_dot";
            _newMarker setMarkerColorLocal "ColorYellow";
            _newMarker setMarkerTextLocal "Poubelle à vider";
            _newMarker setMarkerAlphaLocal 1;
        } else {
            diag_log "⚠️ DEBUG: Aucune poubelle trouvée à la position sélectionnée, tentative avec une nouvelle position.";
        };
    };
};
*/