/*
	File: fn_distrib_getMarkerColor.sqf
	Couleur marqueur selon le stock machine.
	Vert : tout >= 30 | Orange : un article entre 11 et 29 | Rouge : un article <= 10
*/
params [["_stock", createHashMap, [createHashMap]]];

private _hasRed = false;
private _hasOrange = false;

{
	private _qty = _y;
	if (_qty <= 10) then {
		_hasRed = true;
	} else {
		if (_qty < 30) then {
			_hasOrange = true;
		};
	};
} forEach _stock;

if (_hasRed) exitWith { "ColorRed" };
if (_hasOrange) exitWith { "ColorOrange" };

"ColorGreen"
