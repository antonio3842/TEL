/*
	File: fn_distrib_bddCreate.sqf
	INSERT distributeur_alimentaire pour une machine. Retourne l'id BDD.
*/
params [
	["_machine", objNull, [objNull]],
	["_stock", createHashMap, [createHashMap]]
];

if (isNull _machine) exitWith { -1 };

private _pos = getPosATL _machine;
private _stockStr = [_stock] call ALF_Server_fnc_distrib_stockEncode;
_stockStr = [_stockStr] call ALF_Server_fnc_distrib_sqlEscape;

[
	format [
		"INSERT INTO distributeur_alimentaire (pos, stock) VALUES ('%1','%2')",
		_pos,
		_stockStr
	],
	1
] call ALF_Server_fnc_asyncCall;

private _row = [_machine] call ALF_Server_fnc_distrib_bddFindRow;
if (_row isEqualTo []) exitWith { -1 };

_row # 0
