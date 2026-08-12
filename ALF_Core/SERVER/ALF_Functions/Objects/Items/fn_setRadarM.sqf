// /*
// 	File: fn_setRadarM.sqf
// 	Author: ALF TEAM
// */
// ALF_Server_fnc_setRadarM = {

private _radar = _this # 0;
private _speedlimit = _this # 1;
private _amende = _this # 2;
private _player = _this # 3;

if (_speedlimit isEqualTo 0 OR {_amende isEqualTo 0}) exitWith {["Radar Mobile", "Données incorrects.", "danger", false] remoteExec ["ALF_fnc_doMsg",_player];};

["Radar Mobile", format["Le radar est programmé sur %1Km/h.",_speedlimit], "success", false] remoteExec ["ALF_fnc_doMsg",_player];
_radar setVariable ["RadarM",[_speedlimit,_amende,[]],true];
[_radar] remoteExec ["ALF_fnc_radarMenu",_player];

waitUntil
{
	if (isNull _radar OR {_radar animationPhase "clic" > 0 OR {(_radar getVariable ["RadarM",[]] # 0) isEqualTo 0}}) exitWith {true};

	private _amendenow = _amende;
	private _nearVehicles = (getPos _radar) nearEntities [["Car"],30];

	if (count _nearVehicles > 0) then 
	{
		{
			private _vehicle = _x;
			private _vInfo = _vehicle getVariable ["dbInfo",[]];
			if (count _vInfo > 0) then 
			{
				private _speed = floor(speed _vehicle);
				private _bool = _vehicle getVariable ["Flashed",false];
				if (_speed > _speedlimit && {!_bool}) then 
				{
					private _plaque = getPlateNumber _vehicle;
					[_vehicle] spawn 
					{
						(_this # 0) setVariable ["Flashed",true];
						uiSleep 15;
						(_this # 0) setVariable ["Flashed",false];
					};

					[_radar, "flashRadarM"] remoteExecCall ["ALF_fnc_say3D",0];
					[_radar] remoteExec ["ALF_fnc_flashRadar",playableUnits select {(_x distance _radar) < 50}];
										
					if (typeOf(_vehicle) isEqualTo "V_ALF_Kx") then {_plaque = "Inconnue"};

					private _hour = date # 3;
					private _min = date # 4;
					if(_min >= 0 && _min <= 9) then {_min = format["0%1", _min];};
					private _time = format["%1:%2",_hour,_min];

					private _var = _radar getVariable ["RadarM",[]];
					private _data = _var # 2;
					_data pushBack [_time,_plaque,_speedlimit,_speed];

					if(_speed >= (_speedlimit+20) && {_speed < (_speedlimit+50)}) then {_amendenow = _amendenow * 2};
					if(_speed >= (_speedlimit+50)) then {_amendenow = _amendenow * 4};

					_var set[2,_data];
					_radar setVariable ["RadarM",_var,true];
					private _unit = driver _vehicle;
					if (!isNull _unit) then 
					{
						[_speedlimit,_speed,_amendenow] remoteExec ["ALF_fnc_getFlashed",_unit];
					};
				};
			};
		} forEach _nearVehicles;
	};
	uiSleep 0.5;

	FALSE
};
// };
