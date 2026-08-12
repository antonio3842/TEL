#include "\ALF_Client\script_macros.hpp"
/*
  File: fn_recupererPetrole.sqf
  ALF Team
*/
params [
	["_obj",objNull,[objNull]]
];
if(isNull _obj) exitWith {};

[_obj,player] remoteExec ["ALF_Server_fnc_recupererPetrole",2];
