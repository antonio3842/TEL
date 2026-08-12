#include "\ALF_Client\script_macros.hpp"
/*
	File: fn_buyLicense.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Called when purchasing a license. May need to be revised.
*/
private["_type","_varName","_displayName","_sideFlag","_price"];
_type = SEL(_this,3);

_returnClass = [["Licenses", _type]] call ALFTools_Client_Config_fnc_isClass;
if(!_returnClass) exitWith {}; //Bad entry?
_varName = ["STRING", ["Licenses", _type, "variable"]] call ALFTools_Client_Config_fnc_getConfig;
_displayName = ["STRING", ["Licenses", _type, "displayName"]] call ALFTools_Client_Config_fnc_getConfig;
_price = ["NUMBER", ["Licenses", _type, "price"]] call ALFTools_Client_Config_fnc_getConfig;
private _varnameConfig = ["STRING", ["Licenses", _varName, "variable"]] call ALFTools_Client_Config_fnc_getConfig;
_varName = format["license_%1",_varnameConfig];

if(CASH < _price) exitWith {hint format[localize "STR_NOTF_NE_1",[_price] call ALF_fnc_numberText,localize _displayName];};
SUB(CASH,_price);

titleText[format[localize "STR_NOTF_B_1", localize _displayName,[_price] call ALF_fnc_numberText],"PLAIN"];
SVAR_MNS [_varName,true];
