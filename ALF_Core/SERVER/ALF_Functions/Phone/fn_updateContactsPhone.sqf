/*
	File: fn_updateContactsPhone.sqf
	Author: ALF Team
	Description:

*/
params [
	["_contacts",[],[[]]],
	["_uid","",[""]]
];
if (_uid isEqualTo "") exitWith {};

_contacts = [_contacts] call ALF_Server_fnc_mresArray;

[format["UPDATE phone SET contacts='%1' WHERE playerid='%2'",_contacts,_uid],1] call ALF_Server_fnc_asyncCall;
