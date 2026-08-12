/*
	File: fn_bieEteindre.sqf
	Author: ALF TEAM
*/
params [
	["_object",objNull,[objNull]],
	["_unit",objNull,[objNull]]
];
if (isNull _object || {isNull _unit}) exitWith {};

if (_object getVariable ["broken",false]) exitWith {["ENGIE","La réparation du système est impossible pour le moment, revenez dans 5min","warning"] remoteExec ["ALF_fnc_doMsg",_unit];};
if (_object getVariable ["wip",false]) exitWith {["ENGIE","La réparation du système est déjà en cours..","warning"] remoteExec ["ALF_fnc_doMsg",_unit];};

_object setVariable ["wip",true,true];

["ENGIE","La réparation du système est en cours... (3min)","success"] remoteExec ["ALF_fnc_doMsg",_unit];

//uiSleep 180;
uisleep 60;
["ENGIE","La réparation du compteur est terminée, vous pouvez relancer le courant...","success"] remoteExec ["ALF_fnc_doMsg",_unit];


_object setVariable ["wip",false,true];

_object animateSource ["pc_source",0,true];
