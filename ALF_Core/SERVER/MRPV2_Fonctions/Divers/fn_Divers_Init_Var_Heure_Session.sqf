// Code recup de MRP V1 pour configurer l'heure serveur pr l'état batterie téléphone NorX

private["_hour", "_min", "_time", "_calc", "_best", "_bestTime"];
_time = systemtimeutc;
_hour = _time # 3 + 1;
_min = _time # 4;

{
	_calc = _x - _hour;
	if (_calc > 0) then
	{
		if (isNil "_best") then
		{
			_best = _x;
			_bestTime = _calc;
		} else {
			if ((_calc < _bestTime) && (_x > _hour)) then
			{
				_best = _x;
				_bestTime = _calc;
			};
		};
	};

} forEach [14,19,3];

if (isNil "_best") then
{
	{
		if (isNil "_best") then 
		{
			_best = _x;
		} else 
		{
			if (_x < _best) then {_best = _x;};
		};
	} forEach [14,19,3];

	SERVER_TotalSessionTime = (((_best + 24) - _hour) * 60) - _min;
} else 
{
	SERVER_TotalSessionTime = ((_best - _hour) * 60) - _min;
};

SERVER_TotalSessionTime = SERVER_TotalSessionTime * 60; // Convert to seconds

systemchat format["Prochain redémarrage à %1:00 (in %2 sec)", _best, SERVER_TotalSessionTime];
systemchat format["Il est %1:%2", _hour, _min];
systemchat format["SERVER DATE : %1", str(_time)];

publicVariable "SERVER_TotalSessionTime";

_timeDiffH = (systemTime#3) - (systemTimeUTC#3);
if (_timeDiffH < -12) then{_timeDiffH = _timeDiffH + 24;};
if (_timeDiffH > 12) then
{_timeDiffH = _timeDiffH - 24;};
UTC_DIFF = _timeDiffH; 
publicVariable "UTC_DIFF";