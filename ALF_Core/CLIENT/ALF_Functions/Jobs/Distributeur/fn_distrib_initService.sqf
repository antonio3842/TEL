/*
	File: fn_distrib_initService.sqf
	Client — demande sortie véhicule distributeur au serveur.
*/
if (!alive player) exitWith {};

if (MRP_Distrib_EnService) then {
	private _veh = player getVariable ["MRP_Distrib_Vehicle", objNull];
	if (isNull _veh || {!alive _veh}) then {
		MRP_Distrib_EnService = false;
		MRP_Distrib_Parked = false;
		player setVariable ["MRP_Distrib_EnService", false, true];
		player setVariable ["MRP_Distrib_Vehicle", nil, true];
		[] call ALF_fnc_distrib_clearMapMarkers;
	};
};

if (MRP_Distrib_EnService) exitWith {
	["Distributeur", "Terminez d'abord votre service distributeur en cours.", "warning"] spawn ALF_fnc_doMsg;
};

if (!license_distrib) exitWith {
	["Distributeur", "Pas de licence distributeur. Rendez-vous au PNJ licence distributeur.", "warning"] spawn ALF_fnc_doMsg;
};

[player] remoteExecCall ["ALF_Server_fnc_distribSpawnServiceVehicle", 2];
