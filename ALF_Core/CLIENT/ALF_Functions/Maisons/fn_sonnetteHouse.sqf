#include "\ALF_Client\script_macros.hpp"
/*
	File: fn_sonnetteHouse.sqf
*/
if((time - life_action_delay) < 15) exitWith {};
life_action_delay = time;

private _h = _this select 0;
if(isNull _h) exitWith {};

private _nh = FETCH_CONFIG2(getText,CONFIG_VEHICLES,(typeOf _h), "displayName");

private _on = false;
private _radio = tolower (call TFAR_fnc_activeSwRadio);

if ("alf_iphone" in _radio) then {
	[format["%1",_nh],"La sonnette de votre maison vient de s'activer."] spawn ALF_fnc_doSms;
	_on = true;
};
if ("alf_neogend" in _radio) then {
	[format["%1",_nh],"La sonnette de votre maison vient de s'activer."] spawn ALF_fnc_doSms;
	_on = true;
};
if("alf_SonyPo" in _radio) then {
	[format["%1",_nh],"La sonnette de votre maison vient de s'activer."] spawn ALF_fnc_doSms;
	_on = true;
};
if("alf_sonypm" in _radio) then {
	[format["%1",_nh],"La sonnette de votre maison vient de s'activer."] spawn ALF_fnc_doSms;
	_on = true;
};

if !(_on) exitWith {};

playSound "sonnettemaison";
private _posHouse = getPos _h;
private _marker = createMarkerLocal ["house_sonnette",_posHouse];
_marker setMarkerTextLocal "Sonnette..";
_marker setMarkerColorLocal "ColorRed";
_marker setMarkerTypeLocal "loc_Lighthouse";

[_marker] spawn {
	_marker = _this select 0;
	sleep 30;
	deleteMarkerLocal _marker;	
};