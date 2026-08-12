/*
	Formate une distance en mètres pour affichage (phrase naturelle).
*/
params [["_metres", 0, [0]]];

private _m = round (_metres max 0);

if (_m < 1000) then {
	format ["%1 mètres", _m]
} else {
	private _km = round ((_m / 1000) * 10) / 10;
	if (_km == floor _km) then {
		format ["%1 km", floor _km]
	} else {
		format ["%1 km", _km]
	};
};
