/*
	File: fn_bieEteindre.sqf
	Author: ALF TEAM
*/
params [
	["_object",objNull,[objNull]],
	["_unit",objNull,[objNull]]
];
if (isNull _object || {isNull _unit}) exitWith {};

if (_object getVariable ["broken",false]) exitWith {["ENGIE","La réparation du système est impossible pour le moment, revenez dans 10min","warning"] remoteExec ["ALF_fnc_doMsg",_unit];};
if (_object getVariable ["wip",false]) exitWith {["ENGIE","La réparation du compteur est déjà en cours..","warning"] remoteExec ["ALF_fnc_doMsg",_unit];};

_object setVariable ["wip",true,true];

["ENGIE","La réparation du compteur est en cours... (5min)","success"] remoteExec ["ALF_fnc_doMsg",_unit];
uisleep 300;
["ENGIE","La réparation du compteurs est terminée, vous pouvez relancer le courant...","success"] remoteExec ["ALF_fnc_doMsg",_unit];

_object setVariable ["wip",false,true];

_object animateSource ["damage_source",0,true];