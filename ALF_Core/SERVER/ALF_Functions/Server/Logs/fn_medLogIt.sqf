/*
	File: fn_medLogIt.sqf
*/
params[
	["_name","",[""]],
	["_text","",[""]]
];
if(_name isEqualTo "" OR {_text isEqualTo ""}) exitWith {};

[format["INSERT INTO medservice (name, text) VALUES ('%1', '%2')",_name,_text],1] call ALF_Server_fnc_asyncCall;
