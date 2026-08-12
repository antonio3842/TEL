/*
	File: fn_distrib_stockEncode.sqf
	Sérialise un HashMap stock pour la colonne BDD stock (client).
*/
params [["_stock", createHashMap, [createHashMap]]];

private _arr = [];
{
	_arr pushBack [_x, _y];
} forEach _stock;

str _arr
