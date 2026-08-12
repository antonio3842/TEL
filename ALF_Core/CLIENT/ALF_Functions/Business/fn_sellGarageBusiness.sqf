#include "\ALF_Client\script_macros.hpp"
/*
	File: fn_sellGarageBusiness.sqf
	Author: ALF TEAM
*/
private["_vehicle","_vehicleLife","_vid","_pid","_sellPrice","_multiplier","_price","_purchasePrice"];
disableSerialization;

if (EQUAL(lbCurSel 2802,-1)) exitWith {hint localize "STR_Global_NoSelection"};

private _vehicle = lbData [2802,lbCurSel 2802];
_vehicle = (call compile format["%1",_vehicle]) # 0;
private _vehicleLife = _vehicle;
private _vid = lbValue [2802,lbCurSel 2802];
private _pid = getPlayerUID player;

if (isNil {_vehicle}) exitWith {hint localize "STR_Garage_Selection_Error"};
if ((time - life_action_delay) < 1.5) exitWith {hint "Vous appuyez trop vite.";};

private _returnClass = [[CONFIG_LIFE_VEHICLES, _vehicleLife]] call ALFTools_Client_Config_fnc_isClass;
if !(_returnClass) then {_vehicleLife = "Default";};
private _price = ["NUMBER",[CONFIG_LIFE_VEHICLES, _vehicleLife, "vente"]] call ALFTools_Client_Config_fnc_getConfig;

private _action = [format["Voulez-vous vendre ce véhicule pour %1 €.",[_price] call ALF_fnc_numberText],"Entreprise","OUI","NON"] call BIS_fnc_guiMessage;
if !(_action) exitWith {};
closeDialog 0;

[_vid,_pid] remoteExecCall ["ALF_Server_fnc_vehicleDelete",2];

private _building = ((nearestTerrainObjects [player, [], 30]) select {typeof _x isequalto "Land_ALF_Entreprise"}) # 0;
private _var = _building getVariable ["business",[]];
private _capitalstr = _var # 3;
private _siretstr = _var # 2;

_capitalstr = _capitalstr + _price;
_var set[3,_capitalstr];
_building setVariable ["business",_var,true];
[_siretstr,_capitalstr] remoteExec ["ALF_Server_fnc_capitalBusiness",2];

life_action_delay = time;