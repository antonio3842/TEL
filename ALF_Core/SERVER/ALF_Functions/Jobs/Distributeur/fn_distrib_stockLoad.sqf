/*
	File: fn_distrib_stockLoad.sqf
	Charge le stock depuis distributeur_alimentaire (crée la ligne si absente).
	Ne réécrit pas le stock si déjà chargé sur la machine (sauf _force).
*/
params [
	["_machine", objNull, [objNull]],
	["_force", false, [false]]
];

if (isNull _machine) exitWith { createHashMap };

if (!_force && {!isNil {_machine getVariable "MRP_Distrib_Stock"}}) exitWith {
	_machine getVariable "MRP_Distrib_Stock"
};

private _row = [_machine] call ALF_Server_fnc_distrib_bddFindRow;
private _stock = createHashMap;
private _bddId = -1;

if (_row isEqualTo []) then {
	_stock = [] call ALF_Server_fnc_distrib_stockBuildDefault;
	_bddId = [_machine, _stock] call ALF_Server_fnc_distrib_bddCreate;
} else {
	_bddId = _row # 0;
	_stock = [_row # 2] call ALF_Server_fnc_distrib_stockDecode;
};

if (_bddId >= 0) then {
	_machine setVariable ["MRP_Distrib_BDD_Id", _bddId, true];
};

_machine setVariable ["MRP_Distrib_Stock", _stock, true];
_stock
