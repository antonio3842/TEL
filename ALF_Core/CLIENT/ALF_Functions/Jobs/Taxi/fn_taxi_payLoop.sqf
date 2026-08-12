/*
	File: fn_taxi_payLoop.sqf
	Client — rémunération liquide tous les 2 km conduits.
*/
if (!canSuspend) exitWith {};

private _distancePalier = 2000;
private _acc = 0;
private _lastPos = [];
private _cachedVeh = objNull;
private _vehCheckCooldown = 0;

while { alive player && { player getVariable ["MRP_Taxi_EnService", false] } } do {
	sleep 1;

	if !(player getVariable ["MRP_Taxi_EnService", false]) exitWith {};

	if (!isNil "MRP_Taxi_PayNeedReset" && { MRP_Taxi_PayNeedReset }) then {
		MRP_Taxi_PayNeedReset = false;
		_acc = 0;
		_lastPos = [];
		_cachedVeh = objNull;
	};

	if (missionNamespace getVariable ["MRP_Taxi_CashSyncPending", false]) then {
		[] call ALF_fnc_taxi_syncCash;
	};

	if !(player getVariable ["MRP_Taxi_Parked", false]) then {
		if (isNull _cachedVeh || {!alive _cachedVeh} || {time > _vehCheckCooldown}) then {
			_cachedVeh = [] call ALF_fnc_taxi_resolveVehicle;
			_vehCheckCooldown = time + 5;
		};

		if (!isNull _cachedVeh) then {
			private _pos = getPosATL _cachedVeh;
			if (_lastPos isEqualTo []) then {
				_lastPos = _pos;
			} else {
				private _d = (_lastPos distance2D _pos) min 85;
				_lastPos = _pos;
				_acc = _acc + _d;
				while { _acc >= _distancePalier } do {
					_acc = _acc - _distancePalier;
					private _pay = (call ALF_fnc_taxi_getRewards) select 1;
					life_cash = life_cash + _pay;
					[] call ALF_fnc_taxi_syncCash;
					["TAXI", format ["Vous gagnez %1 € pour 2 km parcourus.", [_pay] call ALF_fnc_numberText], "success"] spawn ALF_fnc_doMsg;
				};
			};
		} else {
			_lastPos = [];
			_cachedVeh = objNull;
		};
	} else {
		_lastPos = [];
		_cachedVeh = objNull;
	};
};
