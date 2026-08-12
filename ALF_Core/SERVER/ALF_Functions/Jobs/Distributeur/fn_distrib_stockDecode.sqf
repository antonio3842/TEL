/*
	File: fn_distrib_stockDecode.sqf
	Désérialise la colonne BDD stock vers HashMap.
*/
params [["_raw", "", [""]]];

private _classes = [] call ALF_Server_fnc_distrib_stockItemClasses;
private _stock = createHashMap;

if (_raw isNotEqualTo "") then {
	private _parsed = parseSimpleArray _raw;

	if (_parsed isEqualType [] && {count _parsed > 0}) then {
		_stock = createHashMapFromArray _parsed;
	};
};

{
	if (isNil {_stock get _x}) then {
		_stock set [_x, 0];
	};
} forEach _classes;

_stock
