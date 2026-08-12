#include "\ALF_Core\SERVER\script_macros.hpp"
/*
Spawn d'un objet, script init par "fn_dirObjEventStart.sqf"
*/


if (!isServer) exitWith { diag_log "[DIR][Spawn Objet] ABORT: not server"; objNull };

private _despawnDelaySec = 600;   // 4 min Temps despawn auto

// === CONFIG liste objets ===
private _ObjListClass = [
    "Land_Tyre_F"
];

// Variables globales
private _gVarWreck  = "MRP_dirObj_currentWreck";


// CLEAN ancien objet

private _data = missionNamespace getVariable ["MRP_dirObj_currentWreck", [objNull, false]];
_data params ["_obj", "_actif"];  // _obj = objet, _actif = bool

if (!isNull _obj && {_obj != objNull}) then {
    deleteVehicle _obj;  // Supprime l'objet
    missionNamespace setVariable ["MRP_dirObj_currentWreck", [objNull, false], true];
    diag_log format ["[DIR][Spawn Objet] Ancienne objet delete avant recréation %1).", _obj];

};

// Sélection position aléatoire sur une route de la map

_mapCenter = [worldSize / 2, worldSize / 2, 0];
_mapRadius = worldSize / 2;

_allRoads = _mapCenter nearRoads _mapRadius;
_mainRoads = _allRoads select {
    private _info = getRoadInfo _x;
    private _surface = _info select 0;
    // Prendre que les routes en asphalt
	if ((_surface == "ROAD") OR (_surface == "MAIN ROAD")) then {true} else {false};
};

if (_mainRoads isEqualTo []) exitWith {
    diag_log "[DIR] Aucune route principale trouvée";
};

_randomRoad = selectRandom _mainRoads;

_roadPos = getPosATL _randomRoad;
_dir = getDir _randomRoad;

// Décalage latéral (évite de spawn pile au centre)
_offsetPos = _roadPos vectorAdd [
    2 * sin (_dir + 90),
    2 * cos (_dir + 90),
    0
];

_posASL = ATLToASL _offsetPos;


//Vérification qu'aucun joueur est à proximité du spawn
private _radius = 100;
if ((allPlayers findIf { _x distance _posASL <= 100 }) != -1) exitWith {
    diag_log "[DIR][Spawn Objet] ERROR: Joueur à proximite du spawn, arret de la fonction.";
};


// Choisir l'objet
private _selectedClass = selectRandom _ObjListClass;
if (_selectedClass isEqualTo "") then {
    diag_log "[DIR][Spawn Objet] ERROR: Pas de classname.";
};

// Spawn objet sur les voies (createVehicle -> fallback createSimpleObject)
private _wreck = objNull;
if !(_selectedClass isEqualTo "") then {
    _wreck = createVehicle [_selectedClass, _posASL, [], 0, "CAN_COLLIDE"];
    if (isNull _wreck) then {
        diag_log format ["[DIR][Spawn Objet] createVehicle failed for %1. Trying createSimpleObject ...", _selectedClass];
        private _model = getText (configFile >> "CfgVehicles" >> _selectedClass >> "model");
        if (_model isEqualType "" && {_model != ""}) then {
            _wreck = createSimpleObject [_model, _posASL];
            if (!isNull _wreck) then {
                _wreck setDir (random 360);
            };
        } else {
            diag_log format ["[DIR][Spawn Objet] No model path for %1 -> cannot createSimpleObject.", _selectedClass];
        };
    } else {
        _wreck setVectorUp [0,0,1];
        _wreck setDir (random 360);
        _wreck enableSimulationGlobal true;
    };
};

missionNamespace setVariable [_gVarWreck, [_wreck,false], true];

private _pos = getPos _wreck;
private _zone = "";
private _zoneVille = "";
//Definir les 6 zones de la carte
_zones = [
    [
        [
            [0,10240,0],
            [4328,10240,0],
            [4328,6328,0],
            [0,6328,0]
        ],
        "Saint-Pierre"
    ],
    [
        [
            [4328,10240,0],
            [10240,10240,0],
            [10240,6328,0],
            [4328,6328,0]
        ],
        "Trinité"
    ],
    [
        [
            [0,6328,0],
            [5849,6328,0],
            [5849,3779,0],
            [0,3779,0]
        ],
        "Fort-De-France"
    ],
    [
        [
            [5849,6328,0],
            [10240,6328,0],
            [10240,3779,0],
            [5849,3779,0]
        ],
        "Le Robert"
    ],
    [
        [
            [5849,3779,0],
            [10240,3779,0],
            [10240,0,0],
            [5849,0,0]
        ],
        "Le Marin"
    ],
    [
        [
            [0,3779,0],
            [5849,3779,0],
            [5849,0,0],
            [0,0,0]
        ],
        "Les Anses-d'Arlet"
    ]
];

    {
        private _polygon = _x select 0;
        private _zoneName = _x select 1;

        if (_pos inPolygon _polygon) exitWith {
            _zoneVille = _zoneName;
        };
    } forEach _zones;

//Script qui détecte la zone de spawn (NE, NO, SE, SO, centre)
private _pos = getPos _wreck;  // position de ton objet
private _centerX = worldSize / 2;
private _centerY = worldSize / 2;


if ((_pos select 1) >= _centerY) then {
    _zone = if ((_pos select 0) >= _centerX) then {"NORD-EST"} else {"NORD-OUEST"};
} else {
    _zone = if ((_pos select 0) >= _centerX) then {"SUD-EST"} else {"SUD-OUEST"};
};

diag_log format ["[DIR][Spawn Objet] Objet dans la zone : %1", _zone];

//Envoie d'une notif à la DIR
private _msg = format ["Objet sur les voies signalés au %1 de l'île", _zone];
["Alerte PC DIR", _msg, "warning"] remoteExec [
    "ALF_fnc_doMsg",
    (allPlayers select { _x getVariable ['b_18', false] })
];

uiSleep 300;

private _data2 = missionNamespace getVariable ["MRP_dirObj_currentWreck", [objNull,false]];
_data2 params ["_obj", "_actif"];
if (!isNull _obj && {_obj != objNull}) then {
private _msg = format ["Rappel : Objet sur les voies signalés au %1 de l'île", _zone];
["Alerte PC DIR", _msg, "warning"] remoteExec [
    "ALF_fnc_doMsg",
    (allPlayers select { _x getVariable ['b_18', false] })
];
};

uiSleep 480;

private _data2 = missionNamespace getVariable ["MRP_dirObj_currentWreck", [objNull,false]];
_data2 params ["_obj", "_actif"];
if (!isNull _obj && {_obj != objNull}) then {
private _msg = format ["Rappel : Objet sur les voies signalés dans le secteur de %1", _zoneVille];
["Alerte PC DIR", _msg, "warning"] remoteExec [
    "ALF_fnc_doMsg",
    (allPlayers select { _x getVariable ['b_18', false] })
];
};

//Attente 1min avant de mettre le point sur la carte + send notif
uiSleep 420;

private _data2 = missionNamespace getVariable ["MRP_dirObj_currentWreck", [objNull,false]];
_data2 params ["_obj", "_actif"];
if (!isNull _obj && {_obj != objNull}) then {
	missionNamespace setVariable ["MRP_dirObj_currentWreck", [_wreck, true], true];
    ["Alerte PC DIR","Position de l'objet indiqué sur votre carte","warning"] remoteExec ["ALF_fnc_doMsg",(allPlayers select { _x getVariable ['b_18', false] })];
};


// AUTO-DESPAWN à T+ _despawnDelaySec
[
    _despawnDelaySec, _wreck, _gVarWreck
] spawn {
    params ["_delay","_w","_gvW"];
    uiSleep _delay;

    // Si un nouveau spawn a eu lieu entre-temps, on ne supprime que nos propres objets (références directes)
    if (!isNull _w) then { 
	deleteVehicle _w; 
	missionNamespace setVariable [_gvW, [objNull, false], true];
	private _nom_Marqueur = "DirObj_marker";
	private _targetPlayers = (allPlayers select { _x getVariable ['b_18', false] });
	_targetPlayers pushBackUnique player;
	[FALSE, _nom_Marqueur] remoteExec ['MRPV2_fnc_Marqueur_Gestion', _targetPlayers];
	["Alerte PC DIR","Objet rammassé !","warning"] remoteExec ["ALF_fnc_doMsg",(allPlayers select { _x getVariable ['b_18', false] })];
    diag_log "[DIR][Spawn Objet] Auto-despawn completed.";
	};


};