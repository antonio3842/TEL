/*
	File : fn_drapMort.sqf
	Author: ALF Dev Team
*/
params [
	["_player",objNull,[objNull]],
	["_obj",objNull,[objNull]]
];

if (isNull _player) exitWith {};
if (isNull _obj) exitWith {};

waitUntil {sleep 0.5; (isNull _player) || (isNull _obj)}; // PERF FIX: Ajout sleep pour éviter spin-lock CPU

if (!(isNull _obj)) exitWith {
	deleteVehicle _obj;
};