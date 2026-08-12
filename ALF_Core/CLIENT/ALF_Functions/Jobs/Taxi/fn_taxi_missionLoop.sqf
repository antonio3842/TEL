/*
	File: fn_taxi_missionLoop.sqf
	Client — 1re mission 1 min après prise de service, puis toutes les 10 min.
*/
if (!canSuspend) exitWith {};

if (!isNil "MRP_Taxi_MissionLoopHandle") then {
	terminate MRP_Taxi_MissionLoopHandle;
	MRP_Taxi_MissionLoopHandle = nil;
};

MRP_Taxi_MissionLoopHandle = [] spawn {
	waitUntil {
		sleep 1;
		(player getVariable ["MRP_Taxi_EnService", false]) &&
		{!(player getVariable ["MRP_Taxi_Parked", false])}
	};

	private _firstMission = true;

	while {
		(player getVariable ["MRP_Taxi_EnService", false]) &&
		{!(player getVariable ["MRP_Taxi_Parked", false])}
	} do {
		if (_firstMission) then {
			private _deadline = time + 60;
			waitUntil {
				sleep 1;
				time >= _deadline ||
				{!(player getVariable ["MRP_Taxi_EnService", false])} ||
				{player getVariable ["MRP_Taxi_Parked", false]}
			};
			if (!(player getVariable ["MRP_Taxi_EnService", false]) || {player getVariable ["MRP_Taxi_Parked", false]}) exitWith {};
			_firstMission = false;
		} else {
			waitUntil {
				sleep 2;
				isNil "MRP_Taxi_Mission" ||
				{!(player getVariable ["MRP_Taxi_EnService", false])} ||
				{player getVariable ["MRP_Taxi_Parked", false]}
			};
			if (!(player getVariable ["MRP_Taxi_EnService", false]) || {player getVariable ["MRP_Taxi_Parked", false]}) exitWith {};
			sleep 600;
		};

		if (
			(player getVariable ["MRP_Taxi_EnService", false]) &&
			{!(player getVariable ["MRP_Taxi_Parked", false])}
		) then {
			[] call ALF_fnc_taxi_missionStart;
		};
	};

	[] call ALF_fnc_taxi_missionCleanup;
	MRP_Taxi_MissionLoopHandle = nil;
};
