/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
#include "\ALF_Client\script_macros.hpp"

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
_returnClass = [[CONFIG_LIFE_VEHICLES, _vehicleLife]]call ALFTools_Client_Config_fnc_isClass;
if(!_returnClass) then {
	_vehicleLife = "Default";
	diag_log format["%1: LifeCfgVehicles class doesn't exist",_vehicle];
};

private _price = ["NUMBER",[CONFIG_LIFE_VEHICLES, _vehicleLife,"sortie"]]call ALFTools_Client_Config_fnc_getConfig;
private _purchasePrice = ["NUMBER",[CONFIG_LIFE_VEHICLES, _vehicleLife,"achat"]]call ALFTools_Client_Config_fnc_getConfig;
if (_purchasePrice > 50000) then {
	_price = round(_purchasePrice * 0.0001);
};

private _value = missionNamespace getVariable ["CNPM",0];
if(_value < _price) exitWith {["INFO","Il n'y a pas assez dans les caisses.","warning"] spawn ALF_fnc_doMsg;};

_value = _value - _price;
missionNamespace setVariable ["CNPM",_value,true];
[getPlayerUID player,name player,_price] remoteExec ["ALF_Server_fnc_retirerCNPM",2];

if(life_garage_sp isEqualType []) then {
	[_vid,life_garage_sp select 0,_unit,life_garage_sp select 1] remoteExec ["ALF_Server_fnc_spawnVehiclePenit",2];
} else {
	[_vid,(getMarkerPos life_garage_sp),_unit,markerDir life_garage_sp] remoteExec ["ALF_Server_fnc_spawnVehiclePenit",2];
};

closeDialog 0;
