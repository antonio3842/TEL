/*
	File: fn_taxi_missionStart.sqf
	Client — nouvelle course aléatoire (remplace la précédente si existante).
*/
if !(player getVariable ["MRP_Taxi_EnService", false]) exitWith {};
if (player getVariable ["MRP_Taxi_Parked", false]) exitWith {};

if (!isNil "MRP_Taxi_Mission") then {
	[] call ALF_fnc_taxi_missionCleanup;
};

private _routes = [
	[[4112.32, 4460.59, 0], [3815.38, 9234.14, 0]],
	[[1184.08, 7282.87, 0], [6279.25, 7286.64, 0]],
	[[4134.77, 4577.86, 0], [8470.07, 1654.47, 0]],
	[[7666.43, 4593.5, 0], [2140.24, 5452.85, 0]],
	[[308.932, 9062.98, 0], [5258.89, 8569.82, 0]],
	[[4478.45, 5407.51, 0], [5218.49, 1809.83, 0]],
	[[5349.88, 4051.34, 0], [2590.05, 8515.33, 0]],
	[[5543.39, 4924.14, 0], [3754.82, 9164, 0]],
	[[520.914, 8123.2, 0], [4092.28, 5915.96, 0]],
	[[4413.06, 3327.97, 0], [284.822, 9145.63, 0]],
	[[4293.47, 7178.77, 0], [9098.74, 3405.71, 0]]
];

private _lastIdx = missionNamespace getVariable ["MRP_Taxi_LastRouteIndex", -1];
private _available = [];
for "_i" from 0 to (count _routes - 1) do {
	if (_i != _lastIdx) then {
		_available pushBack _i;
	};
};
if (_available isEqualTo []) then {
	_available = [0];
};
private _idx = selectRandom _available;
missionNamespace setVariable ["MRP_Taxi_LastRouteIndex", _idx];
private _route = _routes select _idx;
_route params ["_pickup", "_dropoff"];

MRP_Taxi_Mission = [0, _pickup, _dropoff];
[] call ALF_fnc_taxi_missionUpdateMarkers;
MRP_Taxi_MissionMonitorHandle = [] spawn ALF_fnc_taxi_missionMonitor;

["TAXI", "Nouvelle course disponible : rendez-vous au client.", "info"] spawn ALF_fnc_doMsg;
