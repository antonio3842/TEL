/*
	Author: ALF Nanou
*/
params [
	["_obj",objNull,[objNull]],
	["_unit",objNull,[objNull]]
];
if(isNull _unit OR {isNull _obj}) exitWith {};

private _c = {_x isEqualTo "ALF_Fraise"} count (magazines _unit);
if(_c < 4) exitWith {["INFO","Vous n'avez pas au moins 4 fraises.","warning"] remoteExec ["ALF_fnc_doMsg",_unit];};
if(_obj getVariable ["wip",false]) exitWith {["INFO","La pompe est en marche.","warning"] remoteExec ["ALF_fnc_doMsg",_unit];};

if(_obj getVariable ["jus",false]) exitWith {
	["INFO","Vous avez récupéré le jus de fraise.","success"] remoteExec ["ALF_fnc_doMsg",_unit];
	["ALF_Jus_Fraise",true] remoteExec ["ALF_fnc_handleItem",_unit];
	_obj setVariable ["jus",false];
};

_obj setVariable ["wip",true];

for "_i" from 1 to 4 step 1 do {
	["ALF_Fraise",false] remoteExec ["ALF_fnc_handleItem",_unit];
	uiSleep 0.25;
};

[_obj,"pompe_wip"] remoteExec ["ALF_fnc_say3D",playableUnits];

uiSleep 30;

if(isNull _unit) exitWith {
	_obj setVariable ["jus",true];
	_obj setVariable ["wip",false];
};

if(_unit distance _obj < 8) then {
	["ALF_Jus_Fraise",true] remoteExec ["ALF_fnc_handleItem",_unit];
	_obj setVariable ["jus",false];
	["INFO","Vous avez récupéré la brique de jus de fraise.","success"] remoteExec ["ALF_fnc_doMsg",_unit];
} else {
	_obj setVariable ["jus",true];
};

_obj setVariable ["wip",false];
//[2] remoteExec ["ALF_fnc_addXP",_unit];
