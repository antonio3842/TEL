#include "\ALF_Client\script_macros.hpp"
/*
File: fn_onAirRadioReleased.sqf
Author: ALF Team
*/
if !(airradio_speaking) exitWith {};

private _freq  = (vehicle player) getVariable ["helicofreq",0];
private _radio = call TFAR_fnc_activeLrRadio;

[
	format[localize "STR_transmit_end",format ["%1<img size='1.5' image='%2'/>",[_radio select 0, "displayName"] call TFAR_fnc_getLrRadioProperty,
	getText(configFile >> "CfgVehicles"  >> typeof (_radio select 0) >> "picture")], 4, 888],
	format [
		"TANGENT_LR	RELEASED	%1%2	%3	%4",
		_freq,
		"_bluefor",
		10000 * (call TFAR_fnc_getTransmittingDistanceMultiplicator), 
		"airborne"
	]
] call TFAR_fnc_processTangent;

airradio_speaking = false;
