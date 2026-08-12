/*
	Liste chauffeurs (via cache partagé ALF_fnc_iPhoneTaxiFetchLists).
	[_excludeSelf] true = appelables (sans soi), false = tous en ligne.
*/
params [["_excludeSelf", true, [true]]];

private _lists = [] call ALF_fnc_iPhoneTaxiFetchLists;
if (_excludeSelf) then { _lists # 1 } else { _lists # 0 }
