/*
	Author: ALF NiiRoZz
*/
params [
	["_ct", objNull, [objNull]]
];
if(isNull _ct) exitWith {};

[_ct,player] remoteExec ["ALF_Server_fnc_transformPetrol",2];
