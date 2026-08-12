/*
	File: fn_distrib_restockAdd.sqf
	Client — demande au serveur d'ajouter un article au stock.
*/
params [
	["_machine", objNull, [objNull]],
	["_item", "", [""]]
];

if (isNull _machine || {_item isEqualTo ""}) exitWith {};

[_machine, _item, player] remoteExecCall ["ALF_Server_fnc_distrib_tryRestock", 2];
