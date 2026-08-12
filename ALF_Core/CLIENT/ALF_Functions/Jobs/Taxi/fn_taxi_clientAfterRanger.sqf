/*
	File: fn_taxi_clientAfterRanger.sqf
	Client — après rangement serveur (véhicule supprimé, en attente fin de service).
*/
[true] call ALF_fnc_taxi_syncCash;

private _v = player getVariable ["MRP_Taxi_Vehicle", objNull];
if (!isNull _v) then {
	life_vehicles = life_vehicles - [_v];
};

player setVariable ["MRP_Taxi_Vehicle", nil, true];
player setVariable ["MRP_Taxi_Parked", true, true];
MRP_Taxi_Parked = true;

if (!isNil "MRP_Taxi_payLoopHandle") then {
	terminate MRP_Taxi_payLoopHandle;
	MRP_Taxi_payLoopHandle = nil;
};

[] call ALF_fnc_taxi_missionStop;
