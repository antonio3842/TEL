/*
	File: fn_taxi_missionStop.sqf
	Client — arrête la boucle de missions (fin de service / rangement).
*/
if (!isNil "MRP_Taxi_MissionLoopHandle") then {
	terminate MRP_Taxi_MissionLoopHandle;
	MRP_Taxi_MissionLoopHandle = nil;
};

[] call ALF_fnc_taxi_missionCleanup;
