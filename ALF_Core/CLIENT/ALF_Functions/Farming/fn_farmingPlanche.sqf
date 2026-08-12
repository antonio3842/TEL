/*
	Author: ALF Nanou
*/
params[
	["_obj",objNull,[objNull]]
];
if(isNull _obj) exitWith {};

["INFO","La machine demarre.","success"] remoteExec ["ALF_fnc_doMsg",player];
[_obj,player] remoteExec ["ALF_Server_fnc_farmingPlanche",2];
