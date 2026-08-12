/*
  File: fn_farmingVin.sqf
  ALF Nanou
*/
params[
	["_obj",objNull,[objNull]]
];
if(isNull _obj) exitWith {};

[_obj,player] remoteExec ["ALF_Server_fnc_farmingVin",2];
