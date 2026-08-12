/*
	File: fn_initClientDistrib.sqf
	Init client — métier distributeur automatique.
*/
if (!hasInterface) exitWith {};

MRP_Distrib_EnService = false;
MRP_Distrib_Parked = false;
MRP_Distrib_MarkerNames = [];

waitUntil { !isNull player };

player setVariable ["MRP_Distrib_EnService", false, true];
player setVariable ["MRP_Distrib_Vehicle", nil, true];
player setVariable ["MRP_Distrib_Parked", false, true];

diag_log "MRP_DISTRIB: Client init";
