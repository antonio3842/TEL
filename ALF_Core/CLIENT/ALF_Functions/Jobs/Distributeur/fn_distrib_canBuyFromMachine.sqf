/*
	File: fn_distrib_canBuyFromMachine.sqf
	Vérif client (pré-contrôle) — limite livreur en service.
*/
params [
	["_machine", objNull, [objNull]],
	["_item", "", [""]]
];

if (!MRP_Distrib_EnService) exitWith { true };
if (isNull _machine || {_item isEqualTo ""}) exitWith { false };

([_machine, _item] call ALF_fnc_distrib_getServiceBuyCount) < ([] call ALF_fnc_distrib_getServiceBuyLimit)
