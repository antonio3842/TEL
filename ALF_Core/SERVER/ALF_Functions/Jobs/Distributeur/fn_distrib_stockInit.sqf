/*
	File: fn_distrib_stockInit.sqf
	Serveur — charge le stock machine depuis la BDD (alias stockLoad).
*/
params [["_machine", objNull, [objNull]]];

if (isNull _machine) exitWith {};

[_machine] call ALF_Server_fnc_distrib_stockLoad;
