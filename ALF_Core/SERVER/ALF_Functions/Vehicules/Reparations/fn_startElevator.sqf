/*
	File: fn_startElevator.sqf
	Author: ALF TEAM
*/
/*
params [
	["_elevator", [], [[]]],
	["_mode", true, [true]],
	["_unit", objNull, [objNull]]
];

private _garage = (nearestObjects [_unit,["Land_ALF_AtelierMecanique"],30]) select 0;
if (isNull _garage) exitWith {};

if (((_garage animationSourcePhase (_elevator select 1)) != 0) && ((_garage animationSourcePhase (_elevator select 1)) < 0.5)) exitWith {};

private _veh = objNull;
private _distance = 10;
private _pos = _garage modelToWorld (_garage selectionPosition [(_elevator select 0), "Memory"]);
{
	if ((_x distance _pos) < _distance) then {
		_distance = (_x distance _pos);
		_veh = _x;
	};
} forEach (nearestObjects [_unit,["Car"],10]);

if (isNull _veh) exitWith {};

_veh allowDamage false;

_garage setVariable[(_elevator select 0) + "_diag", 0];
[_garage, (_elevator select 0) + "_diag", 0, false] remoteExec ["ALF_fnc_setVariable",_unit];

private _t = 0;
if (_mode) then {
	_garage animateSource [(_elevator select 1), 1];

	_garage setVariable [(_elevator select 0) + "_veh_charge", _veh];
	
	for "_i" from 0 to 1 step 0 do {
		sleep 1;
		if (_t > 30) exitWith {};
		if ((_garage animationSourcePhase (_elevator select 1)) > 0.05) exitWith {};
		_veh setPosATL [(getPosATL _veh select 0), (getPosATL _veh select 1), (getPosATL _veh select 2) + 0.03];
		_t = _t + 1;
	};
} else {
	_garage animateSource [(_elevator select 1), 0];

	_garage setVariable [(_elevator select 0) + "_veh_charge", objNull];
	_garage setVariable [(_elevator select 0) + "_in_repair", false];
	_garage setVariable [(_elevator select 0) + "_diag", 0];
	[_garage, (_elevator select 0) + "_diag", 0, false] remoteExec ["ALF_fnc_setVariable",_unit];

	waitUntil {((_garage animationSourcePhase (_elevator select 1)) < 0.50)};

	for "_i" from 0 to 1 step 0 do {
		sleep 1;
		if (_t > 30) exitWith {};
		_veh setPosATL [(getPosATL _veh select 0), (getPosATL _veh select 1), (getPosATL _veh select 2) + 0.03];
		if ((_garage animationSourcePhase (_elevator select 1)) < 0.45) exitWith {};
		_t = _t + 1;
	};
};

_veh allowDamage true;
*/

/*
    File: fn_startElevator.sqf
    Author: ALF TEAM
*/

params [
    ["_elevator", [], [[]]],  // ["Nom du point mémoire", "Nom de l'animation"]
    ["_mode", true, [true]],  // true = Monter, false = Descendre
    ["_unit", objNull, [objNull]] // Joueur ou unité qui déclenche l'action
];

private _garage = (nearestObjects [_unit, ["Land_ALF_AtelierMecanique"], 30]) select 0;
if (isNull _garage) exitWith {
    diag_log "Erreur : Aucun garage trouvé dans les 30m autour de l'unité.";
};

diag_log format ["Garage trouvé : %1", _garage];

if (((_garage animationSourcePhase (_elevator select 1)) != 0) && ((_garage animationSourcePhase (_elevator select 1)) < 0.5)) exitWith {
    diag_log "Erreur : Animation en cours ou bloquée.";
};

private _veh = objNull;
private _distance = 15;  // Distance de détection ajustée à 15m
private _pos = _garage modelToWorld (_garage selectionPosition [(_elevator select 0), "Memory"]);
diag_log format ["Position mémoire pour détection : %1", _pos];

{
    if ((_x distance _pos) < _distance) then {
        _distance = (_x distance _pos);
        _veh = _x;
    };
} forEach (nearestObjects [_unit, ["Car"], _distance]);

if (isNull _veh) exitWith {
    diag_log "Erreur : Aucun véhicule détecté sur l'ascenseur.";
};

diag_log format ["Véhicule détecté : %1", _veh];
_veh allowDamage false;

_garage setVariable [(_elevator select 0) + "_diag", 0];
[_garage, (_elevator select 0) + "_diag", 0, false] remoteExec ["ALF_fnc_setVariable", 0];

private _t = 0;

if (_mode) then {
    diag_log "Montée de l'ascenseur en cours...";
    _garage animateSource [(_elevator select 1), 1];

    _garage setVariable [(_elevator select 0) + "_veh_charge", _veh];

    for "_i" from 0 to 1 step 0 do {
        sleep 1;
        if (_t > 30) exitWith {
            diag_log "Timeout : L'ascenseur a mis trop de temps à monter.";
        };
        if ((_garage animationSourcePhase (_elevator select 1)) > 0.05) exitWith {
            diag_log "L'ascenseur est arrivé en position haute.";
        };
        _veh setPosATL [(getPosATL _veh select 0), (getPosATL _veh select 1), (getPosATL _veh select 2) + 0.03];
        _t = _t + 1;
    };
} else {
    diag_log "Descente de l'ascenseur en cours...";
    _garage animateSource [(_elevator select 1), 0];

    _garage setVariable [(_elevator select 0) + "_veh_charge", objNull];
    _garage setVariable [(_elevator select 0) + "_in_repair", false];
    _garage setVariable [(_elevator select 0) + "_diag", 0];
    [_garage, (_elevator select 0) + "_diag", 0, false] remoteExec ["ALF_fnc_setVariable", 0];

    waitUntil {sleep 0.5; ((_garage animationSourcePhase (_elevator select 1)) < 0.50)}; // PERF FIX: Ajout sleep pour éviter spin-lock CPU

    for "_i" from 0 to 1 step 0 do {
        sleep 1;
        if (_t > 30) exitWith {
            diag_log "Timeout : L'ascenseur a mis trop de temps à descendre.";
        };
        _veh setPosATL [(getPosATL _veh select 0), (getPosATL _veh select 1), (getPosATL _veh select 2) + 0.03];
        if ((_garage animationSourcePhase (_elevator select 1)) < 0.45) exitWith {
            diag_log "L'ascenseur est arrivé en position basse.";
        };
        _t = _t + 1;
    };
};

diag_log "Animation terminée.";
_veh allowDamage true;
