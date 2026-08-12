/*
	File: fn_distrib_getItemBuyPrice.sqf
	Prix d'achat marché d'un article distributeur_auto (Config_Shops).
*/
params [["_className", "", [""]]];

if (_className isEqualTo "") exitWith { 0 };

private _cfg = missionConfigFile >> "WeaponShops" >> "distributeur_auto" >> "items";
private _price = 0;

if (isArray _cfg) then {
	{
		if ((_x param [0, ""]) isEqualTo _className) exitWith {
			_price = _x param [2, 0];
		};
	} forEach (getArray _cfg);
};

_price
