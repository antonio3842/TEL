/*
	File: fn_startDiagnostic.sqf
	Author: ALF TEAM
*/

/*
params [
	["_elevator", [], [[]]],
	["_unit", objNull, [objNull]]
];

private _garage = (nearestObjects [_unit,["Land_ALF_AtelierMecanique"],30]) select 0;
if (isNull (_garage getVariable [(_elevator select 0) + "_veh_charge", objNull])) exitWith {};

if ((_garage getVariable [(_elevator select 0) + "_diag", 0]) isEqualTo 2) exitWith {
	[_elevator, _unit] spawn ALF_Server_fnc_startRepair;
};

if ((_garage getVariable [(_elevator select 0) + "_diag", 0]) != 0) exitWith {
	private _time = time - (_garage getVariable [(_elevator select 0) + "_diagTime", 0]);
	_time = 120 - _time;
	["GARAGE", format["Un diagnostic est déjà en cours. Il reste %1 de diagnostic.",[_time] call BIS_fnc_secondsToString], "warning"] remoteExec ["ALF_fnc_doMsg",_unit];
};
if ((_garage animationSourcePhase (_elevator select 1)) < 0.5) exitWith {
	["GARAGE", "Merci d'attendre la lévée de l'élévateur.", "warning"] remoteExec ["ALF_fnc_doMsg",_unit];
};

private _veh = _garage getVariable [(_elevator select 0) + "_veh_charge", objNull];
if (isNull _veh) exitWith {};

_garage setVariable [(_elevator select 0) + "_diag", 1];
_garage setVariable [(_elevator select 0) + "_diagTime", time];

["GARAGE", "Vous avez lancé le diagnostic.", "warning"] remoteExec ["ALF_fnc_doMsg",_unit];

uisleep 30;//120

if (
	((_garage getVariable[(_elevator select 0) + "_veh_charge", objNull]) == _veh) && 
	((_garage animationSourcePhase (_elevator select 1)) > 0.5)
	) then {

	playSound3D ["ALF_Client2\sounds\bip.ogg", _garage, false, _garage modelToWorld (_garage selectionPosition [(_elevator select 0), "Memory"]), 2, 1, 20];
	_garage setVariable [(_elevator select 0) + "_diag", 2];
};

*/
/*
    File: fn_startDiagnostic.sqf
    Author: ALF TEAM
*/

params [
    ["_elevator", [], [[]]],
    ["_unit", objNull, [objNull]]
];

private _garage = (nearestObjects [_unit, ["Land_ALF_AtelierMecanique"], 30]) select 0;

diag_log format ["[DEBUG] Garage détecté : %1", _garage];

if (isNull (_garage getVariable [(_elevator select 0) + "_veh_charge", objNull])) exitWith {
    diag_log "[ERREUR] Aucun véhicule chargé sur l'ascenseur.";
};

if ((_garage getVariable [(_elevator select 0) + "_diag", 0]) isEqualTo 2) exitWith {
    diag_log "[INFO] Diagnostic terminé, lancement de la réparation.";
    [_elevator, _unit] spawn ALF_Server_fnc_startRepair;
};

if ((_garage getVariable [(_elevator select 0) + "_diag", 0]) != 0) exitWith {
    private _time = time - (_garage getVariable [(_elevator select 0) + "_diagTime", 0]);
    _time = 120 - _time;
    diag_log format ["[INFO] Un diagnostic est déjà en cours. Temps restant : %1 secondes.", _time];
    ["GARAGE", format["Un diagnostic est déjà en cours. Il reste %1 de diagnostic.", [_time] call BIS_fnc_secondsToString], "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

if ((_garage animationSourcePhase (_elevator select 1)) < 0.5) exitWith {
    diag_log "[ERREUR] L'élévateur n'est pas en position haute.";
    ["GARAGE", "Merci d'attendre la levée de l'élévateur.", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

private _veh = _garage getVariable [(_elevator select 0) + "_veh_charge", objNull];
if (isNull _veh) exitWith {
    diag_log "[ERREUR] Aucun véhicule détecté sur l'ascenseur pour le diagnostic.";
};

diag_log format ["[INFO] Diagnostic lancé pour le véhicule : %1", _veh];
_garage setVariable [(_elevator select 0) + "_diag", 1];
_garage setVariable [(_elevator select 0) + "_diagTime", time];

["GARAGE", "Vous avez lancé le diagnostic.", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];

uisleep 120; // 120 secondes dans la version finale

diag_log "[DEBUG] Temps de diagnostic écoulé, vérification de l'état du véhicule et de l'élévateur...";

if (
    ((_garage getVariable [(_elevator select 0) + "_veh_charge", objNull]) == _veh) &&
    ((_garage animationSourcePhase (_elevator select 1)) > 0.5)
) then {
    diag_log "[INFO] Véhicule toujours présent sur l'ascenseur et ascenseur en position haute.";
    playSound3D ["ALF_Client2\sounds\bip.ogg", _garage, false, _garage modelToWorld (_garage selectionPosition [(_elevator select 0), "Memory"]), 2, 1, 20];
    _garage setVariable [(_elevator select 0) + "_diag", 2];
} else {
    diag_log "[ERREUR] Véhicule déplacé ou ascenseur descendu avant la fin du diagnostic.";
};
