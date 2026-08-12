/*
  File: fn_farmingXxX.sqf
  ALF Dev Team
*/
params[
	["_obj",objNull,[objNull]]
];
if(isNull _obj) exitWith {};

[_obj,player] remoteExec ["ALF_Server_fnc_farmingXxX",2];

/*
 RETEST Chris
*/