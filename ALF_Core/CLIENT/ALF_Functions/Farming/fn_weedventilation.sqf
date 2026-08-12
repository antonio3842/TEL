#include "\ALF_Client\script_macros.hpp"
/*
  File: fn_weedventilation.sqf
  ALF Team
*/


params [
	["_obj",objNull,[objNull]],
	["_mode",0,[0]]
];
if(isNull _obj) exitWith {};


[_obj,_mode,player] remoteExec ["ALF_Server_fnc_WeedVentilation",2];


/*
params [
	["_object",objNull,[objNull]]
];
if (isNull _object) exitWith {};

private _active = _object getVariable ["ventilation",false];
if(_active) then {
	_object setVariable ["ventilation",false];
} else {
	_object setVariable ["ventilation",true];
	private _first = false;
	for "_i" from 0 to 1 step 0 do {
		_active = _object getVariable ["ventilation",false];
		if(!_active) exitWith {};
		if(!_first) then {
			playSound3D ["ALF_Client2\sounds\ventil1.ogg",_object];
			//playSound3D ["ALF_Client2\sounds\banque_alarm.ogg", player, false,position player, 3, 1, 150];
			_first = true;
		} else {
			playSound3D ["ALF_Client2\sounds\ventil2.ogg",_object];
		};
		uiSleep 12;
	};
};	
*/