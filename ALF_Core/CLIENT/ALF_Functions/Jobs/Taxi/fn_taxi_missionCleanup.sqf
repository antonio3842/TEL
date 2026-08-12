/*
	File: fn_taxi_missionCleanup.sqf
	Client — supprime mission en cours (marqueurs, script, variables).
*/
MRP_Taxi_Mission = nil;
MRP_Taxi_MissionActive = false;
player setVariable ["MRP_Taxi_MissionActive", false, true];

{
	deleteMarkerLocal _x;
} forEach (missionNamespace getVariable ["MRP_Taxi_MissionMarkerNames", []]);
missionNamespace setVariable ["MRP_Taxi_MissionMarkerNames", []];

private _handle = MRP_Taxi_MissionMonitorHandle;
MRP_Taxi_MissionMonitorHandle = nil;

if (!isNil "_handle" && {!scriptDone _handle}) then {
	terminate _handle;
};
