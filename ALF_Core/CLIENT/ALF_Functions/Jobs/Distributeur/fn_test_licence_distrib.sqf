/*
	File: fn_test_licence_distrib.sqf
	Debug/test — acheter ou supprimer la licence distributeur.
	Usage :
	  [] call ALF_fnc_test_licence_distrib;
	  ["buy"] call ALF_fnc_test_licence_distrib;
	  ["remove"] call ALF_fnc_test_licence_distrib;
*/
params [["_mode", "menu", [""]]];

private _price = 7500;

private _fnc_buy = {
	if (license_distrib) exitWith {
		["TEST", "Vous possédez déjà la licence distributeur.", "warning"] spawn ALF_fnc_doMsg;
	};

	private _confirm = [
		format ["Acheter la licence distributeur pour %1€ ?", _price],
		"TEST - Licence distributeur",
		"OUI",
		"NON"
	] call BIS_fnc_guiMessage;
	if (!_confirm) exitWith {};

	if (life_cash < _price) exitWith {
		["TEST", format ["Vous n'avez pas %1€ sur vous.", _price], "warning"] spawn ALF_fnc_doMsg;
	};

	life_cash = life_cash - _price;
	[0] call SOCK_fnc_updatePartial;
	license_distrib = true;
	[1] call SOCK_fnc_updatePartial;

	["TEST", format ["Licence distributeur achetée (%1€).", _price], "success"] spawn ALF_fnc_doMsg;
};

private _fnc_remove = {
	if (!license_distrib) exitWith {
		["TEST", "Vous n'avez pas la licence distributeur.", "warning"] spawn ALF_fnc_doMsg;
	};

	private _confirm = [
		"Supprimer la licence distributeur ?",
		"TEST - Licence distributeur",
		"OUI",
		"NON"
	] call BIS_fnc_guiMessage;
	if (!_confirm) exitWith {};

	license_distrib = false;
	[1] call SOCK_fnc_updatePartial;

	["TEST", "Licence distributeur supprimée.", "info"] spawn ALF_fnc_doMsg;
};

switch (toLowerANSI _mode) do {
	case "buy": { call _fnc_buy; };
	case "remove": { call _fnc_remove; };
	default {
		private _action = [
			"Que voulez-vous faire ?",
			"TEST - Licence distributeur",
			"Acheter",
			"Supprimer"
		] call BIS_fnc_guiMessage;

		if (_action) then {
			call _fnc_buy;
		} else {
			call _fnc_remove;
		};
	};
};
