#include "\ALF_Client\script_macros.hpp"
/*
  File: fn_takeWeed.sqf
  ALF Nanou
*/
params[
	["_obj",objNull,[objNull]]
];

[_obj,player] remoteExec ["ALF_Server_fnc_takeWeed",2];
