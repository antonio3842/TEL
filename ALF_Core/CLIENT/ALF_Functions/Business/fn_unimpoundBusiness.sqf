#include "\ALF_Client\script_macros.hpp"
/*
	File: fn_unimpoundBusiness.sqf
	Author: Nanou
*/
private["_vehicle","_vehicleLife","_vid","_pid","_unit","_price"];
disableSerialization;
if(lbCurSel 2802 isEqualTo -1) exitWith {hint localize "STR_Global_NoSelection"};
_vehicle = lbData[2802,(lbCurSel 2802)];
_vehicle = (call compile format["%1",_vehicle]) # 0;
_vehicleLife = _vehicle;
_vid = lbValue[2802,(lbCurSel 2802)];
_unit = player;
if (isNil {_vehicle}) exitWith {hint localize "STR_Garage_Selection_Error"};

_returnClass = [[CONFIG_LIFE_VEHICLES, _vehicleLife]] call ALFTools_Client_Config_fnc_isClass;
if !(_returnClass) then {_vehicleLife = "Default";};
_price = ["NUMBER",[CONFIG_LIFE_VEHICLES, _vehicleLife, "sortie"]] call ALFTools_Client_Config_fnc_getConfig;

private _business = life_garage_sp # 2;
private _var = _business getVariable ["business",[]];
private _capitalstr = _var # 3;
private _siretstr = _var # 2;
private _pid = _var # 0;
private _membres = _var # 5;

if(_capitalstr < _price) exitWith {hint format[(localize "STR_Garage_CashError"),[_price] call ALF_fnc_numberText];};
[_vid,life_garage_sp # 0,life_garage_sp # 1,_unit,_siretstr,_membres] remoteExec ["ALF_Server_fnc_spawnVehicleBusiness",2];

private _newvalue = _capitalstr - _price;
_var set[3,_newvalue];
_business setVariable ["business",_var,true];
[_siretstr,_newvalue] remoteExec ["ALF_Server_fnc_capitalBusiness",2];

closeDialog 0;