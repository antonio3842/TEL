/*
	File: fn_distrib_stockTake.sqf
	Retire 1 unité du stock machine (après achat validé) + sauvegarde BDD.
*/
params [
	["_machine", objNull, [objNull]],
	["_item", "", [""]]
];

if (isNull _machine || {_item isEqualTo ""}) exitWith { false };

private _stock = [_machine] call ALF_fnc_distrib_stockEnsure;
private _qty = _stock getOrDefault [_item, 0];

if (_qty < 1) exitWith { false };

_stock set [_item, _qty - 1];
_machine setVariable ["MRP_Distrib_Stock", _stock, true];

private _stockSerialized = [_stock] call ALF_fnc_distrib_stockEncode;
[_machine, _stockSerialized] remoteExecCall ["ALF_Server_fnc_distrib_bddSave", 2];

true
