/*
  File: fn_recupererPetrole.sqf
  Author: ALF Team
*/
params [
	["_obj",objNull,[objNull]],
	["_unit",objNull,[objNull]]
];
if(isNull _obj OR {isNull _unit}) exitWith {};

if !(_obj getVariable ["stuff",false]) exitWith {["INFO","Il n'y a pas de pétrole dans la machine.","warning"] remoteExec ["ALF_fnc_doMsg",_unit];};
if !(_unit canAdd "ALF_Barile_P_F") exitWith {["INFO", "Vous n'avez pas assez de place.", "warning"] remoteExec ["ALF_fnc_doMsg",_unit];};

_obj setVariable ["stuff",false];
playSound3D ["ALF_Client2\sounds\drive.ogg",_obj, false, getPos _obj, 1, 1, 100];
_obj animateSource ["axe_1_source",1];

["ALF_Barile_P_F",true] remoteExec ["ALF_fnc_handleItem",_unit];
["INFO","Vous venez de récupérer le pétrole.","success"] remoteExec ["ALF_fnc_doMsg",_unit];

[_obj] spawn {
	params [
		["_obj",objNull,[objNull]]
	];
	uiSleep random(5);
	private _var = _obj getVariable ["take",false];
	if(_var) then {
		[name _unit,getPlayerUID _unit,"DUPLICATION","A tenté de dupliquer du petrole."] spawn ALF_Server_fnc_logIt;
		["ALF_Barile_P_F",false] remoteExec ["ALF_fnc_handleItem",_unit];
	} else {
		[_obj] spawn {
			params [
				["_obj",objNull,[objNull]]
			];
			_obj setVariable ["take",true];
			uiSleep 6;
			_obj setVariable ["take",false];
		};
	};
};

//[5] remoteExec ["ALF_fnc_addXP",_unit];

uiSleep 5;

_obj animateSource ["axe_1_source",0];
