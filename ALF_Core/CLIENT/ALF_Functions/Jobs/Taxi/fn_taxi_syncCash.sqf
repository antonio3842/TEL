/*
	File: fn_taxi_syncCash.sqf
	Sync liquide BDD avec debounce en service (évite SQL + logIt à chaque palier km).
	[_force] true = sync immédiat (fin de service / déco imminente).
*/
params [["_force", false, [false]]];

if (!hasInterface) exitWith {};

private _debounceSec = 45;

if (_force) exitWith {
	MRP_Taxi_CashSyncPending = false;
	MRP_Taxi_LastCashSyncTime = time;
	[0, true] call SOCK_fnc_updatePartial;
};

private _last = missionNamespace getVariable ["MRP_Taxi_LastCashSyncTime", -1e6];
if ((time - _last) >= _debounceSec) then {
	MRP_Taxi_CashSyncPending = false;
	MRP_Taxi_LastCashSyncTime = time;
	[0, true] call SOCK_fnc_updatePartial;
} else {
	MRP_Taxi_CashSyncPending = true;
};
