private _annee = param [0,0];
private _mois = param [1,0];
private _jour = param [2,0];
private _mots_Entier = param [3,FALSE];

_annee = parsenumber _annee;
_mois = parsenumber _mois;
_jour = parsenumber _jour;

private _dayOfWeek = 0;
private _year2Digits = 0;
private _century2Digits = 0;

if (_mois <= 2) then
{
	_annee = _annee - 1;
	_mois = _mois + 12;
};

_year2Digits = _annee mod 100;
_century2Digits = (_annee - _year2Digits) / 100;

_dayOfWeek =
(
	_jour +
	(floor (2.6 * (_mois + 1))) +
	_year2Digits +
	(floor (0.25 * _year2Digits)) +
	(floor (0.25 * _century2Digits)) +
	(5 * _century2Digits)
) mod 7;

if (_mots_Entier) then
{
	_jour = ["Samedi", "Dimanche", "Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi"] # _dayOfWeek;
} else
{
	_jour = ["Sam.", "Dim.", "Lun.", "Mar.", "Mer.", "Jeu.", "Ven."] # _dayOfWeek;
};

_jour