#include "\ALF_Client\script_macros.hpp"
/*
	File: fn_licenseCheck.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Returns the licenses to the cop.
*/
private["_cop","_licenses","_licensesConfigs"];
_cop = param [0,objNull,[objNull]];
if(isNull _cop) exitWith {}; //Bad entry

_licenses = "";

//Config entries for licenses that are civilian
_licensesConfigs = ["CLASSES", ["Licenses"]] call ALFTools_Client_Config_fnc_getConfig;

{
	private _varnameConfig = ["STRING", ["Licenses", _x, "variable"]] call ALFTools_Client_Config_fnc_getConfig;
	private _levelConfigValue = missionNamespace getVariable [format["license_%1",_varnameConfig], false];

	if(_levelConfigValue) then {
		private _displayName = ["STRING", ["displayName"], _y] call ALFTools_Client_Config_fnc_getConfig;
		ADD(_licenses,localize _displayName + "<br/>");
	};
} forEach _licensesConfigs;

if(EQUAL(_licenses,"")) then {_licenses = (localize "STR_Cop_NoLicensesFound");};
[profileName,_licenses] remoteExecCall ["life_fnc_licensesRead",_cop];