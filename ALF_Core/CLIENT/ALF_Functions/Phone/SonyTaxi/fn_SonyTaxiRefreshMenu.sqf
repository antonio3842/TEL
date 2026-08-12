/*
	Rafraîchit l'écran taxi Sony (équivalent ALF_fnc_iPhoneTaxiMenu sur tablette).
*/
private _configs = [
	[20520, "sonypm", 14, "ALF_fnc_menuSonyPM"],
	[38999, "sonyp", 14, "ALF_fnc_menuSonyP"],
	[32999, "sony", 19, "ALF_fnc_menuSony"]
];

{
	_x params ["_idd", "_var", "_idx", "_fn"];
	private _d = findDisplay _idd;
	if (!isNull _d) exitWith {
		uiNamespace setVariable [_var, _idx];
		[_d, "menu"] call ALF_fnc_SonyTaxi;
	};
} forEach _configs;

TRUE
