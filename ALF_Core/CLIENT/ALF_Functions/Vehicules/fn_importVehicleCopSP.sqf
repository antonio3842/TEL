#include "\ALF_Client\script_macros.hpp"
params [
	["_type",-1,[-1]]
];

disableSerialization;

if ((lbCurSel 2802) isEqualTo -1) exitWith {hint localize "STR_Global_NoSelection";};

private _vehicle = lbData[2802,(lbCurSel 2802)];
_vehicle = (call compile format["%1",_vehicle]) select 0;
private _vehicleLife = _vehicle;
private _vid = lbValue[2802,(lbCurSel 2802)];

if(isNil "_vehicle") exitWith {hint localize "STR_Garage_Selection_Error"};
_returnClass = [[CONFIG_LIFE_VEHICLES, _vehicleLife]] call ALFTools_Client_Config_fnc_isClass;
if(!_returnClass) then {
	_vehicleLife = "Default"; //Use Default class if it doesn't exist
	diag_log format["%1: LifeCfgVehicles class doesn't exist",_vehicle];
};
private _priceC = ["NUMBER", [CONFIG_LIFE_VEHICLES,_vehicleLife,"achat"]] call ALFTools_Client_Config_fnc_getConfig;
private _price = _priceC * 0.01;

private _action = [format["Êtes-vous sûr de vouloir importer ce véhicule pour <t color='#74DF00'>%1 €</t>",_price],"Validation","Importer","Annuler"] call BIS_fnc_guiMessage;
private _exit = false;
if (_action) then {
	if(_type isEqualTo -1) then {
		private _value = missionNamespace getVariable ["CNG",0];
		if(_value < _price) exitWith {["INFO","Il n'y a pas assez dans les caisses.","warning"] spawn ALF_fnc_doMsg; _exit = true;};

		_value = _value - _price;
		missionNamespace setVariable ["CNG",_value,true];
		[getPlayerUID player,name player,_price] remoteExec ["ALF_Server_fnc_retirerCNG",2];
	} else {
		private _value = missionNamespace getVariable ["CNP",0];
		if(_value < _price) exitWith {["INFO","Il n'y a pas assez dans les caisses.","warning"] spawn ALF_fnc_doMsg; _exit = true;};

		_value = _value - _price;
		missionNamespace setVariable ["CNP",_value,true];
		[getPlayerUID player,name player,_price] remoteExec ["ALF_Server_fnc_retirerCNP",2];
	};
	if (_exit) exitWith {};

    [_vid,player,life_garage_id,_type] remoteExec ["ALF_Server_fnc_importVehicleHCCopSP",2];
    closeDialog 0;
};