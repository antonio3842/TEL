/*
	File: bieAllumer
	Author: ALF Team
*/
params[
	["_obj",objNull,[objNull]]
];
if(isNull _obj) exitWith {};

private _action = ["Etes-vous sur de vouloir allumer le courant?","ENGIE","OUI","NON"] call BIS_fnc_guiMessage;
if !(_action) exitWith {};

[_obj,player] remoteExecCall ["ALF_Server_fnc_bieAllumer",2];
