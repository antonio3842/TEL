/*
	File: fn_checkScore.sqf
	Author: ALF Team

	Calcule le score blackjack d'une main.
	Paramètre : _cards - array de cartes [[valeur, couleur], ...]
	Valeurs : 2-10 = face value, 11(V)/12(R)/13(K) = 10, 14(As) = 11 ou 1
	Retourne : score total (nombre entier)
*/
params [
	["_cards",[],[[]]]
];

private _score = 0;
private _aces = 0;

{
	private _val = _x select 0;

	if (_val isEqualTo 14) then {
		_score = _score + 11;
		_aces = _aces + 1;
	} else {
		if (_val >= 11) then {
			_score = _score + 10;
		} else {
			_score = _score + _val;
		};
	};
} forEach _cards;

while {_score > 21 && {_aces > 0}} do {
	_score = _score - 10;
	_aces = _aces - 1;
};

_score
