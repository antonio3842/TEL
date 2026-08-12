/*
	File: fn_checkScore.sqf
	Author: ALF Team

	Évalue la meilleure main de 5 cartes parmi N cartes (typiquement 7 au Texas Hold'em).
	Retourne un array triable : [rang, kicker1, kicker2, ...] où rang = 0-9.

	Rangs :
	0 = Hauteur
	1 = Paire
	2 = Double paire
	3 = Brelan
	4 = Quinte (suite)
	5 = Couleur (flush)
	6 = Full
	7 = Carré
	8 = Quinte flush
	9 = Quinte flush royale
*/
params [
	["_cards",[],[[]]]
];

if (count _cards < 5) exitWith {[0,0,0,0,0,0]};

// Extraire valeurs et couleurs
private _values = _cards apply {_x select 0};
private _suits = _cards apply {_x select 1};

// Compter les occurrences de chaque valeur (indices 0-14)
private _valCount = [];
for "_i" from 0 to 14 do { _valCount pushBack 0; };
{ _valCount set [_x, (_valCount select _x) + 1]; } forEach _values;

// Compter les occurrences de chaque couleur
private _suitCount = createHashMap;
{ private _c = _suitCount getOrDefault [_x, 0]; _suitCount set [_x, _c + 1]; } forEach _suits;

// === FLUSH : trouver une couleur avec >= 5 cartes ===
private _flushSuit = "";
private _flushCards = [];
{
	if (_y >= 5) exitWith {
		_flushSuit = _x;
	};
} forEach _suitCount;

if (_flushSuit != "") then {
	{
		if ((_x select 1) isEqualTo _flushSuit) then {
			_flushCards pushBack (_x select 0);
		};
	} forEach _cards;
	_flushCards sort false;
};

// === STRAIGHT : trouver 5 valeurs consécutives ===
private _uniqueVals = [];
for "_i" from 2 to 14 do {
	if ((_valCount select _i) > 0) then { _uniqueVals pushBack _i; };
};
_uniqueVals sort false;

private _fnc_findStraight = {
	params ["_vals"];
	private _best = -1;
	if (count _vals < 5) exitWith {_best};

	for "_i" from 0 to (count _vals - 5) do {
		private _top = _vals select _i;
		private _ok = true;
		for "_j" from 1 to 4 do {
			if !((_top - _j) in _vals) exitWith { _ok = false; };
		};
		if (_ok) exitWith { _best = _top; };
	};

	// Roue (A-2-3-4-5)
	if (_best == -1 && {14 in _vals} && {5 in _vals} && {4 in _vals} && {3 in _vals} && {2 in _vals}) then {
		_best = 5;
	};
	_best
};

private _straightHigh = [_uniqueVals] call _fnc_findStraight;

// === STRAIGHT FLUSH ===
private _straightFlushHigh = -1;
if (_flushSuit != "" && {count _flushCards >= 5}) then {
	private _uniqueFlush = [];
	{ if !(_x in _uniqueFlush) then { _uniqueFlush pushBack _x; }; } forEach _flushCards;
	_uniqueFlush sort false;
	_straightFlushHigh = [_uniqueFlush] call _fnc_findStraight;
};

// === Identifier les groupes ===
private _quads = [];
private _trips = [];
private _pairs = [];
private _singles = [];
for "_i" from 14 to 2 step -1 do {
	private _c = _valCount select _i;
	switch (_c) do {
		case 4: { _quads pushBack _i; };
		case 3: { _trips pushBack _i; };
		case 2: { _pairs pushBack _i; };
		case 1: { _singles pushBack _i; };
	};
};

// === Déterminer la meilleure main ===

// 9 - Quinte flush royale
if (_straightFlushHigh == 14) exitWith {[9, 14, 13, 12, 11, 10]};

// 8 - Quinte flush
if (_straightFlushHigh > -1) exitWith {
	if (_straightFlushHigh == 5) then {
		[8, 5, 4, 3, 2, 1]
	} else {
		[8, _straightFlushHigh, _straightFlushHigh - 1, _straightFlushHigh - 2, _straightFlushHigh - 3, _straightFlushHigh - 4]
	}
};

// 7 - Carré
if (count _quads > 0) exitWith {
	private _quadVal = _quads select 0;
	private _allKickers = (_trips + _pairs + _singles) select {_x != _quadVal};
	_allKickers sort false;
	private _k1 = if (count _allKickers > 0) then {_allKickers select 0} else {0};
	[7, _quadVal, _k1, 0, 0, 0]
};

// 6 - Full (brelan + paire)
if (count _trips > 0 && {(count _trips > 1) || {count _pairs > 0}}) exitWith {
	private _tripVal = _trips select 0;
	private _pairVal = 0;
	if (count _trips > 1) then {
		_pairVal = _trips select 1;
	};
	if (count _pairs > 0 && {(_pairs select 0) > _pairVal}) then {
		_pairVal = _pairs select 0;
	};
	[6, _tripVal, _pairVal, 0, 0, 0]
};

// 5 - Couleur (flush)
if (_flushSuit != "") exitWith {
	[5, _flushCards select 0, _flushCards select 1, _flushCards select 2, _flushCards select 3, _flushCards select 4]
};

// 4 - Quinte (straight)
if (_straightHigh > -1) exitWith {
	if (_straightHigh == 5) then {
		[4, 5, 4, 3, 2, 1]
	} else {
		[4, _straightHigh, _straightHigh - 1, _straightHigh - 2, _straightHigh - 3, _straightHigh - 4]
	}
};

// 3 - Brelan
if (count _trips > 0) exitWith {
	private _tripVal = _trips select 0;
	private _allKickers = (_pairs + _singles) select {_x != _tripVal};
	_allKickers sort false;
	private _k1 = if (count _allKickers > 0) then {_allKickers select 0} else {0};
	private _k2 = if (count _allKickers > 1) then {_allKickers select 1} else {0};
	[3, _tripVal, _k1, _k2, 0, 0]
};

// 2 - Double paire
if (count _pairs >= 2) exitWith {
	private _p1 = _pairs select 0;
	private _p2 = _pairs select 1;
	private _allKickers = +_singles;
	if (count _pairs > 2) then { _allKickers pushBack (_pairs select 2); };
	_allKickers sort false;
	private _k1 = if (count _allKickers > 0) then {_allKickers select 0} else {0};
	[2, _p1, _p2, _k1, 0, 0]
};

// 1 - Paire
if (count _pairs == 1) exitWith {
	private _pairVal = _pairs select 0;
	private _allKickers = +_singles;
	_allKickers sort false;
	private _k1 = if (count _allKickers > 0) then {_allKickers select 0} else {0};
	private _k2 = if (count _allKickers > 1) then {_allKickers select 1} else {0};
	private _k3 = if (count _allKickers > 2) then {_allKickers select 2} else {0};
	[1, _pairVal, _k1, _k2, _k3, 0]
};

// 0 - Hauteur
_singles sort false;
private _k1 = if (count _singles > 0) then {_singles select 0} else {0};
private _k2 = if (count _singles > 1) then {_singles select 1} else {0};
private _k3 = if (count _singles > 2) then {_singles select 2} else {0};
private _k4 = if (count _singles > 3) then {_singles select 3} else {0};
private _k5 = if (count _singles > 4) then {_singles select 4} else {0};
[0, _k1, _k2, _k3, _k4, _k5]
