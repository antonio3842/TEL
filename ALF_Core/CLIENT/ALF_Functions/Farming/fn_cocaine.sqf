#include "\ALF_Client\script_macros.hpp"
/*
  File: fn_cocaine.sqf
  ALF Team
*/
params [
	["_obj",objNull,[objNull]],
	["_mode",0,[0]]
];
if(isNull _obj) exitWith {};

[_obj,_mode,player] remoteExec ["ALF_Server_fnc_cocaine",2];
