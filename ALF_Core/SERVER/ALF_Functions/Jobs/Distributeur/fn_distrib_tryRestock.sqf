/*
	File: fn_distrib_tryRestock.sqf
	Serveur — ajoute 1 article au stock depuis l'inventaire du joueur (gain = prix achat + 2€ côté client).
*/
params [
	["_machine", objNull, [objNull]],
	["_item", "", [""]],
	["_unit", objNull, [objNull]]
];

if (isNull _machine || {_item isEqualTo ""} || {isNull _unit}) exitWith {};

private _maxStock = call ALF_Server_fnc_distrib_getStockMax;

if !(_item in ([] call ALF_Server_fnc_distrib_stockItemClasses)) exitWith {
	["Distributeur", "Article non accepté par cette machine.", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
	[true] remoteExecCall ["ALF_fnc_distrib_restockMenu", _unit];
};

if (isNil {_machine getVariable "MRP_Distrib_Stock"}) then {
	[_machine] call ALF_Server_fnc_distrib_stockLoad;
};

private _stock = _machine getVariable ["MRP_Distrib_Stock", createHashMap];
private _current = _stock getOrDefault [_item, 0];

if (_current >= _maxStock) exitWith {
	["Distributeur", format ["Stock maximum atteint (%1).", _maxStock], "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
	[true] remoteExecCall ["ALF_fnc_distrib_restockMenu", _unit];
};

private _allItems = magazines _unit + items _unit;
_allItems append (uniformItems _unit);
_allItems append (vestItems _unit);
_allItems append (backpackItems _unit);

private _hasItem = { _x isEqualTo _item } count _allItems > 0;

if (!_hasItem) exitWith {
	["Distributeur", "Vous n'avez pas cet article sur vous.", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
	[true] remoteExecCall ["ALF_fnc_distrib_restockMenu", _unit];
};

if ({ _x isEqualTo _item } count (magazines _unit) > 0) then {
	_unit removeMagazine _item;
} else {
	_unit removeItem _item;
};

_stock set [_item, _current + 1];
_machine setVariable ["MRP_Distrib_Stock", _stock, true];
[_machine] call ALF_Server_fnc_distrib_bddSave;

[_machine] remoteExecCall ["ALF_fnc_distrib_updateMapMarker", 0];

private _label = getText (configFile >> "CfgWeapons" >> _item >> "displayName");
if (_label isEqualTo "") then {
	_label = getText (configFile >> "CfgMagazines" >> _item >> "displayName");
};
if (_label isEqualTo "") then { _label = _item; };

private _pay = [_item] call ALF_Server_fnc_distrib_getRestockPay;
[_pay, _label] remoteExecCall ["ALF_fnc_distrib_restockPay", _unit];
