/*
	File: fn_taxi_clientAfterEnd.sqf
	Client — nettoyage après fin de service serveur.
*/
[true] call ALF_fnc_taxi_syncCash;

if (!isNil "MRP_Taxi_payLoopHandle") then {
	terminate MRP_Taxi_payLoopHandle;
	MRP_Taxi_payLoopHandle = nil;
};

[] call ALF_fnc_taxi_missionStop;

[] call ALF_fnc_taxi_restoreCivilianUniform;

private _v = player getVariable ["MRP_Taxi_Vehicle", objNull];
if (!isNull _v) then {
	life_vehicles = life_vehicles - [_v];
};

missionNamespace setVariable ["ALF_iPhone_TaxiListsCache", nil];
player setVariable ["MRP_Taxi_EnService", false, true];
MRP_Taxi_Parked = false;
player setVariable ["MRP_Taxi_Vehicle", nil, true];
player setVariable ["MRP_Taxi_Parked", false, true];
missionNamespace setVariable ["MRP_Taxi_LastRouteIndex", -1];
