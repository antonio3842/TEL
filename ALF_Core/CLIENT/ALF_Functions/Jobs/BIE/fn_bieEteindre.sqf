/*
	File: bieEteindre
	Author: ALF Team
*/
params[
	["_obj",objNull,[objNull]]
];
if(isNull _obj) exitWith {};

private _action = ["Etes-vous sur de vouloir eteindre le courant ? RISQUE D'ELECTROCUTION !!!!","ENGIE","OUI","NON"] call BIS_fnc_guiMessage;

_random = random 100;

if !(_action) exitWith {};

[_obj, "electricity_loop"] remoteExec ["say3D"];

if (!MRP_Bie_EnService) then {
	if (_random > 90) then {
		["ENGIE","Vous avez été électrocuter .","warning"] remoteExec ["ALF_fnc_doMsg",player];
		player setDamage 1;
	} else {
		if (_random >= 50) then {
			["ENGIE","Vous avez été électrocuter .","warning"] remoteExec ["ALF_fnc_doMsg",player];
			player setDamage 0.8;
		};
	};
};
[_obj,player] remoteExecCall ["ALF_Server_fnc_bieEteindre",2];
