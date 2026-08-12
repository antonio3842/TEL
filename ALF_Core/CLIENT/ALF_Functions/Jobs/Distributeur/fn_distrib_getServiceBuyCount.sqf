/*
	File: fn_distrib_getServiceBuyCount.sqf
	Achats en service pour machine + item (sync serveur → client).
*/
params [
	["_machine", objNull, [objNull]],
	["_item", "", [""]]
];

if (isNull _machine || {_item isEqualTo ""}) exitWith { 0 };

private _machineKey = [_machine] call ALF_fnc_distrib_getMachineKey;
if (_machineKey isEqualTo "") exitWith { 0 };

private _counts = player getVariable ["MRP_Distrib_ServiceBuyCounts", createHashMap];
if (_counts isEqualType []) then { _counts = createHashMap; };

_counts getOrDefault [format ["%1|%2", _machineKey, _item], 0]
