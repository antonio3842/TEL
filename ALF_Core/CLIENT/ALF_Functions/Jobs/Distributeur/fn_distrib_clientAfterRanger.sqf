/*
	File: fn_distrib_clientAfterRanger.sqf
	Client — après rangement serveur (véhicule supprimé).
*/
private _v = player getVariable ["MRP_Distrib_Vehicle", objNull];

if (!isNull _v) then {
	life_vehicles = life_vehicles - [_v];
};

player setVariable ["MRP_Distrib_Vehicle", nil, true];
MRP_Distrib_Parked = true;
player setVariable ["MRP_Distrib_Parked", true, true];
