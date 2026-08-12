/*
	File: fn_distrib_clientAfterSpawn.sqf
	Client — état après spawn serveur.
*/
params [["_vehicle", objNull, [objNull]]];

if (isNull _vehicle) exitWith {};

if (!(_vehicle in life_vehicles)) then {
	life_vehicles pushBack _vehicle;
};

MRP_Distrib_EnService = true;
MRP_Distrib_Parked = false;
player setVariable ["MRP_Distrib_EnService", true, true];
player setVariable ["MRP_Distrib_Vehicle", _vehicle, true];
player setVariable ["MRP_Distrib_Parked", false, true];

[] spawn {
	[] call ALF_fnc_distrib_showMapMarkers;
	["Distributeur", "Prise de service OK ! Les distributeurs sont visibles sur la carte.", "success"] spawn ALF_fnc_doMsg;
};
