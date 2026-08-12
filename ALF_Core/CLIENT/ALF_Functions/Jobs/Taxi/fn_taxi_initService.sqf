/*
	File: fn_taxi_initService.sqf
	Client — demande sortie taxi au serveur.
*/
if (!alive player) exitWith {};

if (player getVariable ["MRP_Taxi_EnService", false]) exitWith {
	["TAXI", "Terminez d'abord votre service taxi en cours (fin de service au PNJ).", "warning"] spawn ALF_fnc_doMsg;
};

if (!license_driver) exitWith {
	["TAXI", "Vous devez posséder le permis de conduire (permis B).", "warning"] spawn ALF_fnc_doMsg;
};

if (!license_taxi) exitWith {
	["TAXI", "Vous devez posséder la licence taxi pour utiliser ce service.", "warning"] spawn ALF_fnc_doMsg;
};

[player] remoteExecCall ["ALF_Server_fnc_taxiSpawnServiceVehicle", 2];
