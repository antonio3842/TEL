/*
	File: fn_taxi_clientAfterSpawn.sqf
	Client — état après spawn serveur.
*/
params [["_vehicle", objNull, [objNull]]];

if (isNull _vehicle) exitWith {};

/* Clés côté serveur (keyManagement) ; côté client le bind vérifie life_vehicles (cf. permis). Le taxi reste exclu du garage PNJ via MRP_TaxiServiceVehicle. */
if (!(_vehicle in life_vehicles)) then {
	life_vehicles pushBack _vehicle;
};

if (!isNil "MRP_Taxi_payLoopHandle") then {
	terminate MRP_Taxi_payLoopHandle;
};

missionNamespace setVariable ["ALF_iPhone_TaxiListsCache", nil];
player setVariable ["MRP_Taxi_EnService", true, true];
player setVariable ["MRP_Taxi_Vehicle", _vehicle, true];

private _numTel = ALF_Phone_Number;
if (_numTel isEqualTo "") then {
	_numTel = player getVariable ["phoneNumber", ""];
};
if !(_numTel isEqualTo "") then {
	player setVariable ["phoneNumber", _numTel, true];
};
player setVariable ["MRP_Taxi_Parked", false, true];
MRP_Taxi_Parked = false;

[] call ALF_fnc_taxi_equipServiceUniform;

/* Paye km active dès la prise de service (mission ne bloque qu'après embarquement client) */
MRP_Taxi_Mission = nil;
MRP_Taxi_MissionActive = false;
player setVariable ["MRP_Taxi_MissionActive", false, true];
MRP_Taxi_PayNeedReset = true;
MRP_Taxi_LastCashSyncTime = -1e6;
MRP_Taxi_CashSyncPending = false;

MRP_Taxi_payLoopHandle = [] spawn ALF_fnc_taxi_payLoop;

if (!isNil "MRP_Taxi_MissionLoopHandle") then {
	terminate MRP_Taxi_MissionLoopHandle;
	MRP_Taxi_MissionLoopHandle = nil;
};
[] spawn ALF_fnc_taxi_missionLoop;
