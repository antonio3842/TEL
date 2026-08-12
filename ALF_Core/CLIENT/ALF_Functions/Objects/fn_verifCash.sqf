#include "\ALF_Client\script_macros.hpp"
/*
	File: fn_verifCash.sqf
	Author: NANOU
*/
private["_cop"];
_cop = _this select 0;

["INFO", format["Cette personne a %1€ dans ses poches.",[life_cash] call ALF_fnc_numberText], "warning"] remoteExec ["ALF_fnc_doMsg",_cop];
