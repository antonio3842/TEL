/*
	File: fn_distrib_registerServiceBuy.sqf
	Incrémente le compteur achat en service (par item / machine / reboot).
*/
params [
	["_machine", objNull, [objNull]],
	["_item", "", [""]]
];

if (!MRP_Distrib_EnService) exitWith {};
if (isNull _machine || {_item isEqualTo ""}) exitWith {};

private _machineKey = [_machine] call ALF_fnc_distrib_getMachineKey;
if (_machineKey isEqualTo "") exitWith {};

private _counts = player getVariable ["MRP_Distrib_ServiceBuyCounts", createHashMap];
if (_counts isEqualType []) then { _counts = createHashMap; };

private _key = format ["%1|%2", _machineKey, _item];
_counts set [_key, (_counts getOrDefault [_key, 0]) + 1];
player setVariable ["MRP_Distrib_ServiceBuyCounts", _counts, false];
