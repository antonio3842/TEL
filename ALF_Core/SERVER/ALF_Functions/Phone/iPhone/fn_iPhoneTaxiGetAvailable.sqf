/*
	Chauffeurs taxi disponibles (serveur).
	[_requester, _excludeSelf, _returnBoth]
	  _returnBoth true  → [[enLigne...], [appelables...]] (un seul scan allPlayers)
	  _returnBoth false → [[joueur, numero, nom], ...] selon _excludeSelf
*/
params [
	["_requester", objNull, [objNull]],
	["_excludeSelf", true, [true]],
	["_returnBoth", false, [false]]
];

if (isNull _requester) exitWith { if (_returnBoth) then { [[], []] } else { [] } };

private _fnc_normPhone = {
	params ["_n"];
	if (!(_n isEqualType "")) then { _n = str _n; };
	_n regexReplace [" ", ""]
};

private _fnc_toEntry = {
	params ["_u"];
	[
		_u,
		[_u getVariable ["phoneNumber", ""]] call _fnc_normPhone,
		name _u
	]
};

private _etats_Occupe = [
	"Appel en cours",
	"Tentative appel expéditeur",
	"Tentative appel destinataire",
	"Appel CA en cours"
];

private _taxis = allPlayers select {
	alive _x &&
	{ _x getVariable ["MRP_Taxi_EnService", false] } &&
	{ ([_x getVariable ["phoneNumber", ""]] call _fnc_normPhone) != "" } &&
	{ !((_x getVariable ["MRP_Appel_Etat", ""]) in _etats_Occupe) }
};

if (_returnBoth) exitWith {
	[
		_taxis apply { [_x] call _fnc_toEntry },
		(_taxis select { !(_x isEqualTo _requester) }) apply { [_x] call _fnc_toEntry }
	]
};

(_taxis select { !(_excludeSelf && { _x isEqualTo _requester }) }) apply { [_x] call _fnc_toEntry }
