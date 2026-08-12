/*
	File: fn_distrib_clientAfterEnd.sqf
	Client — nettoyage après fin de service.
*/
private _v = player getVariable ["MRP_Distrib_Vehicle", objNull];

if (!isNull _v && {_v in life_vehicles}) then {
	life_vehicles = life_vehicles - [_v];
};

[] call ALF_fnc_distrib_clearMapMarkers;

MRP_Distrib_EnService = false;
MRP_Distrib_Parked = false;
player setVariable ["MRP_Distrib_EnService", false, true];
player setVariable ["MRP_Distrib_Vehicle", nil, true];
player setVariable ["MRP_Distrib_Parked", false, true];
