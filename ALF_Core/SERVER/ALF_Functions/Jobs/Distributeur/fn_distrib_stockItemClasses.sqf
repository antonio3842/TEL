/*
	File: fn_distrib_stockItemClasses.sqf
	Serveur — classnames autorisés en stock distributeur (Config_Shops).
*/
private _cfg = missionConfigFile >> "WeaponShops" >> "distributeur_auto" >> "items";
private _list = [];

if (isArray _cfg) then {
	{
		private _className = _x param [0, ""];
		if (_className isNotEqualTo "") then {
			_list pushBack _className;
		};
	} forEach (getArray _cfg);
};

if (_list isEqualTo []) then {
	_list = [
		"ALF_Banane", "ALF_Pain", "ALF_Kebab", "ALF_snickers", "ALF_BakedBeans", "ALF_BaconT",
		"ALF_WaterB_P", "ALF_WaterB_G", "ALF_coca", "ALF_Jus", "ALF_1664", "ALF_Vodka",
		"ALF_Rome", "ALF_Malibu", "ALF_Luxe2", "ALF_Luxe1", "ALF_Jock", "ALF_Jager", "ALF_Horse",
		"ALF_51", "ALF_Sky", "ALF_Vazisi", "ALF_Smirnoff", "ALF_Saucisse_Crue_M", "ALF_Bacon_Crue_M",
		"ALF_CotePorc_Crue_M", "ALF_Poulet_Crue_M"
	];
};

_list
