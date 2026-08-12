#include "\ALF_Client\script_macros.hpp"
/*
	File: fn_putInCarsp.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Finds the nearest vehicle and loads the target into the vehicle.
*/
params [
	["_unit",objNull,[objNull]],
	["_classname","",[""]]
];
if(isNull _unit OR !isPlayer _unit) exitWith {};

private "_nearestVehicle";
if !(_classname isEqualTo "") then {
	private _types = if (_classname isEqualType []) then {_classname} else {[_classname]};
	_nearestVehicle = (player nearEntities [_types,10]) select 0;
} else {
	_nearestVehicle = (nearestObjects [player, ["Car","Ship","Submarine","Air"], 10]) select 0;
};
if(isNil "_nearestVehicle") exitWith {["INFO", "Aucun vehicule proche.", "danger"] spawn ALF_fnc_doMsg;};

detach _unit;
[_nearestVehicle] remoteExecCall ["ALF_fnc_moveIn",_unit];

