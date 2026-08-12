/*
	File: fn_distrib_bddSave.sqf
	UPDATE stock en BDD depuis MRP_Distrib_Stock sur la machine.
	_stockOverride : HashMap ou string sérialisée (str array).
*/
params [
	["_machine", objNull, [objNull]],
	["_stockOverride", nil]
];

if (isNull _machine) exitWith {};

private _stock = _machine getVariable ["MRP_Distrib_Stock", createHashMap];

if (!isNil "_stockOverride") then {
	if (_stockOverride isEqualType createHashMap) then {
		_stock = _stockOverride;
	} else {
		if (_stockOverride isEqualType "") then {
			_stock = [_stockOverride] call ALF_Server_fnc_distrib_stockDecode;
		};
	};
	_machine setVariable ["MRP_Distrib_Stock", _stock, true];
};

if (_stock isEqualType []) then { _stock = createHashMap; };

private _id = _machine getVariable ["MRP_Distrib_BDD_Id", -1];

if (_id < 0) then {
	[_machine, true] call ALF_Server_fnc_distrib_stockLoad;
	_id = _machine getVariable ["MRP_Distrib_BDD_Id", -1];
};

if (_id < 0) exitWith {
	diag_log format ["[DISTRIB] bddSave ignoré — machine sans id BDD (%1).", getPosATL _machine];
};

private _stockStr = [_stock] call ALF_Server_fnc_distrib_stockEncode;
_stockStr = [_stockStr] call ALF_Server_fnc_distrib_sqlEscape;

[
	format [
		"UPDATE distributeur_alimentaire SET stock='%1' WHERE id='%2'",
		_stockStr,
		_id
	],
	1
] call ALF_Server_fnc_asyncCall;

_stock
