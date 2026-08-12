/*
	File: biePoserC4
	Author: ALF Team
*/
params[
	["_obj",objNull,[objNull]]
];
if(isNull _obj) exitWith {};

private _action = ["Etes-vous sur de vouloir hacker le system?","ENGIE","OUI","NON"] call BIS_fnc_guiMessage;
if !(_action) exitWith {};

["ALF_Pc",false] call ALF_fnc_handleItem;

[_obj,player] remoteExec ["ALF_Server_fnc_biePoserPC",2];
