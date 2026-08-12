/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
// ['vehiclegaragre obso'] remoteExec ['systemchat',0]; // PERF FIX: Debug désactivé
// params [
// 	["_house",objNull,[objNull]],
// 	["_type","",[""]]
// ];


// _returnClass = [["ALF_GARAGES", (typeOf _house)]]call ALFTools_Client_Config_fnc_isClass;
// if (!_returnClass) exitWith {
// 	diag_log format["%1: ALF_GARAGES class doesn't exist", typeOf _house];
// };

// private _garagePos = ["ARRAY", ["ALF_GARAGES", (typeOf _house), "garageSpawnPos"]]call ALFTools_Client_Config_fnc_getConfig;
// private _garageDir = ["NUMBER", ["ALF_GARAGES", (typeOf _house), "garageSpawnDir"]]call ALFTools_Client_Config_fnc_getConfig;
// life_garage_sp = [(_house modelToWorld _garagePos),(getDir _house) - _garageDir];
// life_garage_id = 0; 

// [getPlayerUID player,_type,player] remoteExec ["ALF_Server_fnc_getVehicles",2];

// createDialog "Life_impound_menu";
// disableSerialization;
// ctrlSetText[2802,(localize "STR_ANOTF_QueryGarage")];
