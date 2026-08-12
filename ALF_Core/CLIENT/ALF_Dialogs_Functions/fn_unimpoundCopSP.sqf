/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
// #include "\ALF_Client\script_macros.hpp"









params [
["_mode",-1,[-1]]
];

disableSerialization;

if((lbCurSel 2802) isEqualTo -1) exitWith {hint localize "STR_Global_NoSelection"};
_vehicle = lbData[2802,(lbCurSel 2802)];
_vehicle = (call compile format["%1",_vehicle]) select 0;
_vehicleLife = _vehicle;
_vid = lbValue[2802,(lbCurSel 2802)];
_unit = player;

if(isNil "_vehicle") exitWith {hint localize "STR_Garage_Selection_Error"};
_returnClass = [["LifeCfgVehicles", _vehicleLife]]call ALFTools_Client_Config_fnc_isClass;
if(!_returnClass) then {
_vehicleLife = "Default";
diag_log format["%1: LifeCfgVehicles class doesn't exist",_vehicle];
};

private _prix_Sortie = ["NUMBER",["LifeCfgVehicles", _vehicleLife,"sortie"]]call ALFTools_Client_Config_fnc_getConfig;
private _prix_Achat = ["NUMBER",["LifeCfgVehicles", _vehicleLife,"achat"]]call ALFTools_Client_Config_fnc_getConfig;
if (_prix_Achat > 50000) then {_prix_Sortie = round(_prix_Achat * 0.0001);};

if(_mode isEqualTo -1) then {
private _valeur = missionNamespace getVariable ["CNG",0];
if(_valeur < _prix_Sortie) exitWith {["INFO","Il n'y a pas assez dans les caisses.","warning"] spawn ALF_fnc_doMsg;};

_valeur = _valeur - _prix_Sortie;
missionNamespace setVariable ["CNG",_valeur,true];
[getPlayerUID player,name player,_prix_Sortie] remoteExec ["ALF_Server_fnc_retirerCNG",2];
} else {
private _valeur = missionNamespace getVariable ["CNP",0];
if(_valeur < _prix_Sortie) exitWith {["INFO","Il n'y a pas assez dans les caisses.","warning"] spawn ALF_fnc_doMsg;};

_valeur = _valeur - _prix_Sortie;
missionNamespace setVariable ["CNP",_valeur,true];
[getPlayerUID player,name player,_prix_Sortie] remoteExec ["ALF_Server_fnc_retirerCNP",2];
};

if(life_garage_sp isEqualType []) then {
[_vid,_mode,life_garage_sp select 0,_unit,life_garage_sp select 1] remoteExec ["ALF_Server_fnc_spawnVehicleCopSP",2];
} else {
if(life_garage_sp in ["med_heli_1","cop_heli_1","cop_heli_2","cop_heli_3"]) then {
[_vid,_mode,life_garage_sp,_unit,0] remoteExec ["ALF_Server_fnc_spawnVehicleCopSP",2];
} else {
[_vid,_mode,(getMarkerPos life_garage_sp),_unit,markerDir life_garage_sp] remoteExec ["ALF_Server_fnc_spawnVehicleCopSP",2];
};
};

closeDialog 0;