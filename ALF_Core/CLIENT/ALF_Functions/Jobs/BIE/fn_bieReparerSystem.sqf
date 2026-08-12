/*
	File: bieDehacking
	Author: ALF Team
*/
params[
	["_obj",objNull,[objNull]]
];
if(isNull _obj) exitWith {};

private _action = ["Etes-vous sur de vouloir reparer le système?","ENGIE","OUI","NON"] call BIS_fnc_guiMessage;
if !(_action) exitWith {};

[_obj,player] remoteExec ["ALF_Server_fnc_bieReparerSystem",2];
