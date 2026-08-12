// /*
// 	File: fn_recupMeth.sqf
// 	Author: ALF TEAM
// */
params [
	["_obj", objNull, [objNull]],
	["_unit",objNull,[objNull]]
];

private _c = {_x getVariable ["CopService",false]} count playableUnits;
if(_c <= 4) exitWith {["INFO", "Il n'y a pas assez de Gendarme en service.", "warning"] remoteExec ["ALF_fnc_doMsg",_unit];};//4

if(isNull _obj) exitWith {};
if(!(_obj getVariable["process_finish_90", false]) && !(_obj getVariable["process_finish_50", false])) exitWith {};
if (!(_unit canAdd "ALF_Meth90")) exitWith {["Meth", "Vous n'avez pas assez de place.", "warning"] remoteExec ["ALF_fnc_doMsg",_unit];};

[_unit, "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon"] remoteExec ["playMove", _unit];

if (_obj getVariable["process_finish_90", false]) then {
	_obj setVariable["process_finish_90", false];
	["ALF_Meth50",true] remoteExec ["ALF_fnc_handleItem",_unit];
	[3,4] remoteExec ["ALF_fnc_addXP",_unit];
} else {
	_obj setVariable["process_finish_50", false];
	["ALF_Meth50",true] remoteExec ["ALF_fnc_handleItem",_unit];
	[3,4] remoteExec ["ALF_fnc_addXP",_unit];
};

[name _unit,getPlayerUID _unit,"METH","a recuperer de la methamphetamine."] spawn ALF_Server_fnc_logIt;

_obj setVariable["in_process", false];
_obj animate["Pilules", 0];