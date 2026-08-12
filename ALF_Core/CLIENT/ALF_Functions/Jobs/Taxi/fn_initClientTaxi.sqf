/*
	Init variables taxi client (pas de recompile — fonctions via PBO / DLL).
*/
if (!hasInterface) exitWith {};

MRP_Taxi_Parked = false;
MRP_Taxi_SavedUniform = nil;
MRP_Taxi_SavedHeadgear = nil;
MRP_Taxi_SavedUniformItems = nil;
MRP_Taxi_Mission = nil;
MRP_Taxi_MissionActive = false;
MRP_Taxi_PayNeedReset = false;
MRP_Taxi_LastCashSyncTime = -1e6;
MRP_Taxi_CashSyncPending = false;

if (!isNil "MRP_Taxi_MissionLoopHandle") then {
	terminate MRP_Taxi_MissionLoopHandle;
	MRP_Taxi_MissionLoopHandle = nil;
};

waitUntil { !isNull player };

player setVariable ["MRP_Taxi_EnService", false, true];
player setVariable ["MRP_Taxi_Vehicle", nil, true];
player setVariable ["MRP_Taxi_Parked", false, true];
player setVariable ["MRP_Taxi_MissionActive", false, true];
missionNamespace setVariable ["MRP_Taxi_LastRouteIndex", -1];
missionNamespace setVariable ["ALF_iPhone_TaxiListsCache", nil];
missionNamespace setVariable ["MRP_Taxi_RewardsCache", nil];
