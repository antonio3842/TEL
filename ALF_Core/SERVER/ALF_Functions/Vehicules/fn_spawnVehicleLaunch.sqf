/*
	File: fn_spawnVehicleLaunch.sqf
	Author: ALF Team
*/
diag_log "================================== VEHICULE LOADING ==================================";
diag_log "================================== VEHICULE CIV LOADING ==================================";

[] call ALF_Server_fnc_spawnVehicleLaunch_CIV;

diag_log "================================== VEHICULE CIV FINISH ==================================";
diag_log "================================== CHARGEMENT VEHICULE GN ==================================";

[] call ALF_Server_fnc_spawnVehicleLaunch_GN;

diag_log "================================== VEHICULE COP FINISH ==================================";
diag_log "================================== VEHICULE SP LOADING ==================================";

[] call ALF_Server_fnc_spawnVehicleLaunch_SP;

diag_log "================================== VEHICULE SP FINISH ==================================";
diag_log "================================== VEHICULE Penit LOADING ==================================";

[] call ALF_Server_fnc_spawnVehicleLaunch_Penit;

diag_log "================================== VEHICULE Penit FINISH ==================================";
diag_log "================================== VEHICULE LOADING FINISH ==================================";