/*
	File: fn_distrib_getShopItems.sqf
	Liste [classname, label] du shop distributeur_auto (Config_Shops).
*/
private _config = ["ARRAY", ["WeaponShops", "distributeur_auto", "items"]] call ALFTools_Client_Config_fnc_getConfig;
private _items = [];

{
	private _className = _x param [0, ""];
	if (_className isEqualTo "") then { continue; };

	private _label = _x param [1, ""];
	if (_label isEqualTo "") then {
		private _itemInfo = [_className] call ALF_fnc_fetchCfgDetails;
		if (count _itemInfo > 1) then {
			_label = _itemInfo select 1;
		} else {
			_label = _className;
		};
	};

	_items pushBack [_className, _label];
} forEach _config;

_items
