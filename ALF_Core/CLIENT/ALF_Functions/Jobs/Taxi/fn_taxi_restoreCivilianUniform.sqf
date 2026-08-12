/*
	File: fn_taxi_restoreCivilianUniform.sqf
	Remet la tenue civile — handleItem conserve le contenu des poches (pas de transfert sac).
*/
private _uClass = "ALF_Taxi";
private _hClass = "H_Hat_brown";

private _savedU = MRP_Taxi_SavedUniform;
private _savedH = MRP_Taxi_SavedHeadgear;
private _savedUItems = MRP_Taxi_SavedUniformItems;

MRP_Taxi_SavedUniform = nil;
MRP_Taxi_SavedHeadgear = nil;
MRP_Taxi_SavedUniformItems = nil;

if (isNil "_savedU") exitWith {};

if (_savedU isNotEqualTo "") then {
	[_savedU, true, nil, nil, nil, nil, nil, false] call ALF_fnc_handleItem;
} else {
	if (uniform player == _uClass) then {
		[_uClass, false, nil, nil, nil, nil, nil, false] call ALF_fnc_handleItem;
	};
};

if (_savedH isNotEqualTo "") then {
	[_savedH, true, nil, nil, nil, nil, nil, false] call ALF_fnc_handleItem;
} else {
	if (headgear player == _hClass) then {
		[_hClass, false, nil, nil, nil, nil, nil, false] call ALF_fnc_handleItem;
	};
};

private _onPlayer = items player + uniformItems player + vestItems player + backpackItems player;

if (!isNil "_savedUItems" && {_savedU isNotEqualTo ""}) then {
	{
		if !(_x in _onPlayer) then {
			[_x, true, false, false, true] call ALF_fnc_handleItem;
			_onPlayer pushBack _x;
		};
	} forEach _savedUItems;
};
