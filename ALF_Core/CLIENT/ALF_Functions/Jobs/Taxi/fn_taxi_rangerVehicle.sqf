/*
	File: fn_taxi_rangerVehicle.sqf
	Client — demande rangement taxi près du PNJ (life_pInact_curObject).
	En service : même logique qu'avant.
	Hors service (ex. après déco/reco) : licence taxi requise — rangement au PNJ, sans supprimer le véhicule ailleurs.
*/
if (!alive player) exitWith {};

private _enService = player getVariable ["MRP_Taxi_EnService", false];
private _orphanHorsService = !_enService;

if (_orphanHorsService) then {
	if (!license_taxi) exitWith {
		["TAXI", "Vous devez posséder la licence taxi pour ranger ce véhicule.", "warning"] spawn ALF_fnc_doMsg;
	};
} else {
	if (player getVariable ["MRP_Taxi_Parked", false]) exitWith {
		["TAXI", "Véhicule déjà rangé. Terminez votre service.", "info"] spawn ALF_fnc_doMsg;
	};
};

private _pnj = missionNamespace getVariable ["life_pInact_curObject", objNull];
if (isNull _pnj) then {
	_pnj = cursorObject;
};

[player, _pnj, _orphanHorsService] remoteExecCall ["ALF_Server_fnc_taxiRangerVehicle", 2];
