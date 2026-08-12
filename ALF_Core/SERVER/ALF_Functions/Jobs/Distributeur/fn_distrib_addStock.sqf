/*
	File: fn_distrib_addStock.sqf
	Serveur — incrémente le stock machine (+1) et sauvegarde BDD.
	_stockSerialized : stock client sérialisé (str array) après +1 local.
*/
params [
	["_machine", objNull, [objNull]],
	["_item", "", [""]],
	["_unit", objNull, [objNull]],
	["_stockSerialized", "", [""]]
];

if (isNull _machine || {_item isEqualTo ""} || {isNull _unit}) exitWith {};

private _maxStock = call ALF_Server_fnc_distrib_getStockMax;

if !(_item in ([] call ALF_Server_fnc_distrib_stockItemClasses)) exitWith {
	["Distributeur", "Article non accepté par cette machine.", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

private _stock = createHashMap;

if (_stockSerialized isNotEqualTo "") then {
	_stock = [_stockSerialized] call ALF_Server_fnc_distrib_stockDecode;
} else {
	if (isNil {_machine getVariable "MRP_Distrib_Stock"}) then {
		_stock = [_machine] call ALF_Server_fnc_distrib_stockLoad;
	} else {
		_stock = _machine getVariable ["MRP_Distrib_Stock", createHashMap];
		if (_stock isEqualType []) then { _stock = createHashMap; };
	};
};

private _current = _stock getOrDefault [_item, 0];

if (_current > _maxStock) then {
	_stock set [_item, _maxStock];
	_current = _maxStock;
};

if (_current >= _maxStock) exitWith {
	["Distributeur", format ["Stock maximum atteint (%1).", _maxStock], "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
	_machine setVariable ["MRP_Distrib_Stock", _stock, true];
};

_machine setVariable ["MRP_Distrib_Stock", _stock, true];
[_machine, _stock] call ALF_Server_fnc_distrib_bddSave;

[_machine] remoteExecCall ["ALF_fnc_distrib_updateMapMarker", 0];

private _label = getText (configFile >> "CfgWeapons" >> _item >> "displayName");
if (_label isEqualTo "") then {
	_label = getText (configFile >> "CfgMagazines" >> _item >> "displayName");
};
if (_label isEqualTo "") then { _label = _item; };

private _pay = [_item] call ALF_Server_fnc_distrib_getRestockPay;
[_pay, _label] remoteExecCall ["ALF_fnc_distrib_restockPay", _unit];
