/*
	File: fn_distrib_stockBuildDefault.sqf
	Stock initial plein (max par article).
*/
private _stock = createHashMap;
private _maxStock = call ALF_Server_fnc_distrib_getStockMax;

{
	_stock set [_x, _maxStock];
} forEach ([] call ALF_Server_fnc_distrib_stockItemClasses);

_stock
