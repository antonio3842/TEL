/*
	File: fn_taxi_equipServiceUniform.sqf
	Change uniforme + chapeau (handleItem conserve le contenu des poches).
*/
private _uClass = "ALF_Taxi";
private _hClass = "H_Hat_brown";

if (isNil "MRP_Taxi_SavedUniform") then {
	MRP_Taxi_SavedUniform = uniform player;
	MRP_Taxi_SavedHeadgear = headgear player;
	MRP_Taxi_SavedUniformItems = + uniformItems player;
};

if (uniform player != _uClass) then {
	[_uClass, true, nil, nil, nil, nil, nil, false] call ALF_fnc_handleItem;
};

if (headgear player != _hClass) then {
	[_hClass, true, nil, nil, nil, nil, nil, false] call ALF_fnc_handleItem;
};
