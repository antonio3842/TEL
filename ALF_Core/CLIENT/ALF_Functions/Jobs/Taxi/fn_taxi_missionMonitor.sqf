/*
	File: fn_taxi_missionMonitor.sqf
	Client — zones larges, arrêt 3 s au pickup puis au dropoff.
*/
if (!canSuspend) exitWith {};

private _zoneRadius = 25;
private _stopRequired = 3;
private _stopAcc = 0;

private _fnc_stopped = {
	params ["_veh"];
	(vectorMagnitude (velocity _veh)) < 1
};

while {
	alive player &&
	{ player getVariable ["MRP_Taxi_EnService", false] } &&
	{ !(player getVariable ["MRP_Taxi_Parked", false]) } &&
	{ !isNil "MRP_Taxi_Mission" }
} do {
	uiSleep 0.25;

	if (isNil "MRP_Taxi_Mission") exitWith {};

	MRP_Taxi_Mission params ["_phase", "_pickup", "_dropoff"];
	private _veh = [] call ALF_fnc_taxi_resolveVehicle;

	if (!isNull _veh) then {
		private _targetPos = if (_phase isEqualTo 0) then { _pickup } else { _dropoff };
		private _inZone = (_veh distance2D _targetPos) <= _zoneRadius;
		private _stopped = [_veh] call _fnc_stopped;

		if (_inZone && _stopped) then {
			_stopAcc = _stopAcc + 0.25;

			if (_stopAcc >= _stopRequired) then {
				if (_phase isEqualTo 0) then {
					MRP_Taxi_Mission set [0, 1];
					_stopAcc = 0;
					MRP_Taxi_MissionActive = true;
					player setVariable ["MRP_Taxi_MissionActive", true, true];
					[] call ALF_fnc_taxi_missionUpdateMarkers;
					["TAXI", "Client monté à bord du véhicule.", "success"] spawn ALF_fnc_doMsg;
				} else {
					private _payMission = (call ALF_fnc_taxi_getRewards) select 0;
					life_cash = life_cash + _payMission;
					[] call ALF_fnc_taxi_syncCash;
					["TAXI", format ["Course terminée. Vous gagnez %1 €.", [_payMission] call ALF_fnc_numberText], "success"] spawn ALF_fnc_doMsg;
					[] call ALF_fnc_taxi_missionCleanup;
				};
			};
		} else {
			_stopAcc = 0;
		};
	} else {
		_stopAcc = 0;
	};
};
