/*
	[gain mission, gain / 2 km] selon joueurs connectés — cache 30 s.
*/
private _cache = missionNamespace getVariable ["MRP_Taxi_RewardsCache", []];
if (
	_cache isEqualType [] && { count _cache >= 2 } &&
	{ (time - (_cache # 0)) < 30 }
) exitWith {
	_cache # 1
};

private _n = count allPlayers;
private _tranche = if (_n <= 10) then {
	0
} else {
	1 + floor ((_n - 11) / 15)
};

private _missionPays = [7000, 8000, 9000, 10000, 11000, 12000, 13000];
private _kmPays = [550, 640, 720, 800, 880, 960, 1040];

private _rewards = if (_tranche < count _missionPays) then {
	[_missionPays select _tranche, _kmPays select _tranche]
} else {
	private _extra = _tranche - (count _missionPays - 1);
	[
		(_missionPays select -1) + (_extra * 1000),
		(_kmPays select -1) + (_extra * 80)
	]
};

missionNamespace setVariable ["MRP_Taxi_RewardsCache", [time, _rewards]];
_rewards
