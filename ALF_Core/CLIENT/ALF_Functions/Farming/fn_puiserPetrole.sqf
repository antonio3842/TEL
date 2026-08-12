#include "\ALF_Client\script_macros.hpp"
/*
  File: fn_puiserPetrole.sqf
  ALF Team
*/
params[
	["_obj",objNull,[objNull]]
];
if(isNull _obj) exitWith {};
private _uid = getPlayerUID player;

[_obj,_uid,player] remoteExec ["ALF_Server_fnc_petroleSystem",2];