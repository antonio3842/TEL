/*
	File: fn_distrib_getItemBuyPrice.sqf
	Prix d'achat marché d'un article distributeur_auto (Config_Shops).
*/
params [["_className", "", [""]]];

if (_className isEqualTo "") exitWith { 0 };

private _config = ["ARRAY", ["WeaponShops", "distributeur_auto", "items"]] call ALFTools_Client_Config_fnc_getConfig;
private _price = 0;

{
	if ((_x param [0, ""]) isEqualTo _className) exitWith {
		_price = _x param [2, 0];
	};
} forEach _config;

_price
