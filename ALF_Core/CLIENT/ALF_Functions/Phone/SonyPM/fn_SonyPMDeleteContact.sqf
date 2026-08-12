#include "\ALF_Client\script_macros.hpp"
/*
File: fn_SonyDeleteContact.sqf
Author: ALF Team
*/
disableSerialization;
private _contact = lbValue[39113,lbCurSel (39113)];
life_contacts deleteAt _contact;

if !(isNull (findDisplay 20520)) then {
	uiNamespace setVariable ['sonypm',3];
	[] call ALF_fnc_menuSonyPM;
};

[life_contacts, getPlayerUID player] remoteExecCall ["ALF_Server_fnc_updateContactsPhone", 2];
