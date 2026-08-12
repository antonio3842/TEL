#include "\ALF_Client\script_macros.hpp"
/*
	File: fn_unrestrain.sqf
	Author:

	Description:

*/
private _unit = param [0,objNull,[objNull]];
if (isNull _unit || {!([_unit] call ALF_fnc_checkMenotter)}) exitWith {};

["ALF_cle_M",false] spawn ALF_fnc_handleItem;
["ALF_Menottes",true] spawn ALF_fnc_handleItem;

_array = _unit getVariable ["ALF_MenotterSurrender",[false,false]];
_array set [0,false];
_unit setVariable ["ALF_MenotterSurrender",_array,true];
_unit setVariable ["tf_unable_to_use_radio",false,true];
_unit setVariable ["tf_unable_to_use_radio",false,false];

[_unit,"gestureNod"] remoteExecCall ["playActionNow",_unit];
["INFO", "Cette personne est démenottée.", "success"] spawn ALF_fnc_doMsg;
["INFO", "Vous êtes démenotté.", "success"] remoteExec ["ALF_fnc_doMsg",_unit];
