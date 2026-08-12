/*
	File: fn_distrib_stockTake.sqf
	Serveur — retire 1 unité après achat et sauvegarde BDD.
*/
params [
	["_machine", objNull, [objNull]],
	["_item", "", [""]]
];

if (isNull _machine || {_item isEqualTo ""}) exitWith { false };

[_machine] call ALF_Server_fnc_distrib_stockLoad;

private _stock = _machine getVariable ["MRP_Distrib_Stock", createHashMap];
private _qty = _stock getOrDefault [_item, 0];

if (_qty < 1) exitWith { false };

_stock set [_item, _qty - 1];
_machine setVariable ["MRP_Distrib_Stock", _stock, true];
[_machine] call ALF_Server_fnc_distrib_bddSave;

true
