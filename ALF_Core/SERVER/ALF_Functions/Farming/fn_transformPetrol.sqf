/*
Author: ALF NiiRoZz
*/

params [
	["_ct", objNull, [objNull]],
	["_unit", objNull, [objNull]]
];

private _c = {_x isEqualTo "ALF_Barile_P_F"} count (magazines _unit);
if(_c < 1) exitWith {["INFO","Vous n'avez pas au moins un barile plein sur vous.","warning"] remoteExec ["ALF_fnc_doMsg",_unit];};
if(_ct getVariable ["wip",false]) exitWith {["INFO","Le concentrateur est en marche.","warning"] remoteExec ["ALF_fnc_doMsg",_unit];};

if(_ct getVariable ["petrole",false]) exitWith {
	["INFO","Vous avez récupéré un bidon d'essence traité.","success"] remoteExec ["ALF_fnc_doMsg",_unit];
	["ALF_Barile_Station",true] remoteExec ["ALF_fnc_handleItem",_unit];
	_ct setVariable ["petrole",false];
	//[5] remoteExec ["ALF_fnc_addXP",_unit];
};

_ct setVariable ["wip",true];

["ALF_Barile_P_F",false] remoteExec ["ALF_fnc_handleItem",_unit];

[_ct,"pompe_wip"] remoteExec ["ALF_fnc_say3D",playableUnits];

uiSleep 30;

if(isNull _unit) exitWith {
	_ct setVariable ["wip",false];
	_ct setVariable ["petrole",true];
};

if(_unit distance _ct < 8) then {
	["ALF_Barile_Station",true] remoteExec ["ALF_fnc_handleItem",_unit];
	_ct setVariable ["petrole",false];
	["INFO","Vous avez récupéré un bidon d'essence traité.","success"] remoteExec ["ALF_fnc_doMsg",_unit];
	//[5] remoteExec ["ALF_fnc_addXP",_unit];
} else {
	_ct setVariable ["petrole",true];
};

_ct setVariable ["wip",false];
