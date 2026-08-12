/*
	File: fn_distrib_getMachineKey.sqf
	Serveur — clé unique machine (id BDD ou position).
*/
params [["_machine", objNull, [objNull]]];

if (isNull _machine) exitWith { "" };

private _id = _machine getVariable ["MRP_Distrib_BDD_Id", -1];
if (_id >= 0) exitWith { str _id };

str (getPosATL _machine)
