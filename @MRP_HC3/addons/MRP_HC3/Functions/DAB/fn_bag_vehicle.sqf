/*
	File: fn_bag_vehicle.sqf
	Author: ALF Dev Team
	Executed on: HC3
*/

params [
	["_type", 0, [0]],
	["_veh", objNull, [objNull]],
	["_clientOwner", 0, [0]]
];
diag_log format ["[HC3-DAB] bag_vehicle: type=%1, veh=%2, clientOwner=%3", _type, _veh, _clientOwner];

if (_type isEqualTo 0) then {
	private _actual = _veh getVariable ["valise_stock", 0];
	if (_actual >= 10) exitWith {
		["CAMION", "Ce camion est plein.", "danger"] remoteExec ["ALF_fnc_doMsg", _clientOwner];
	};

	_actual = _actual + 1;
	_veh setVariable ["valise_stock", _actual, true];

	[_veh, 1] remoteExecCall ["ALF_fnc_bag_stock", _clientOwner];
	["CAMION", format ["Valise déposée. Stock: %1/10", _actual], "success"] remoteExec ["ALF_fnc_doMsg", _clientOwner];
	diag_log format ["[HC3-DAB] bag_vehicle: stock OK, valise_stock=%1", _actual];
} else {
	private _actual = _veh getVariable ["valise_stock", 0];
	if (_actual <= 0) exitWith {
		["CAMION", "Ce camion est vide.", "danger"] remoteExec ["ALF_fnc_doMsg", _clientOwner];
	};

	_actual = _actual - 1;
	_veh setVariable ["valise_stock", _actual, true];

	[_veh, 1] remoteExecCall ["ALF_fnc_bag_unstock", _clientOwner];
	["CAMION", format ["Valise retirée. Stock: %1/10", _actual], "success"] remoteExec ["ALF_fnc_doMsg", _clientOwner];
	diag_log format ["[HC3-DAB] bag_vehicle: unstock OK, valise_stock=%1", _actual];
};
