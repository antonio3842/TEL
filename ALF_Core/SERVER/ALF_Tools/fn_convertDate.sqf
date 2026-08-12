/*
    GET YOUR PATH
    Code written by Association law 1901 "GET YOUR PATH" (RNA W252007073)
    Statement from the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403
    @Copyright GET YOUR PATH (https://www.getyourpath.fr)
    YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
    More informations : https://www.bistudio.com/community/game-content-usage-rules
    Contact : kainnon@getyourpath.fr
*/

private _v = params[
	["_year", -1, [-1]],
	["_month", -1, [-1]],
	["_day", -1, [-1]],
	["_hours", -1, [-1]],
	["_minutes", -1, [-1]]
];

if !(_v) exitWith {};

[_month, _day, _hours, _minutes] apply {if (_x <= 9) then {format["0%1", _x]}};
private _returnDate = format["%1/%2/%3 - %4h%5", _day, _month, _year, _hours, _minutes];

_returnDate