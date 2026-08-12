/*
	File: fn_dataQuery.sqf
	Author: ALF TEAM
*/
if(life_session_completed) exitWith {};

[getPlayerUID player,player] remoteExec ["ALF_Server_fnc_queryRequest",2];
