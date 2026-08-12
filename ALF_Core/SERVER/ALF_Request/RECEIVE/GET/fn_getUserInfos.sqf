/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/

if !(isServer) exitWith {};
if (hasInterface) exitWith {};

private _v = params[
	["_playerUID", "", [""]]
];

if !(_v) exitWith {
	[false, 'NO-ARGS']
};

/* -- Get player infos -- */
private _userRequest = format["SELECT name, cash, adminlevel, coplevel, mediclevel, publique, penit, gear, playtime, isValidate FROM players WHERE playerid = '%1' LIMIT 1", _playerUID];
private _userResult = [_userRequest,2] call ALF_Server_fnc_asyncCall;

if (_userResult isEqualTo []) exitWith {
	/* -- User not in DB -- */
	[true, "NO-USER"]
};

_userResult params [
	"_name",
	"_cash", 
	"_adminLevel",
	"_copLevel",
	"_medicLevel",
	"_publique",
	"_penit",
	"_gear",
	"_playTime",
	"_isValidate"
];

/* -- Format time -- */
private _numberMinutes = _playTime mod 60;
private _numberHours = ((_playTime - _numberMinutes)/60) mod 24;
private _numberDays = (((_playTime - _numberMinutes)/60) - _numberHours)/24;

private _formatedTime = "";

if (_numberDays isEqualTo 0) then {
	if (_numberHours isEqualTo 0) then {
		_formatedTime = format["%1 minutes", _numberMinutes];
	} else {
		_formatedTime = format["%1 heures et %2 minutes", _numberHours, _numberMinutes];
	};
} else {
	_formatedTime = format["%1 jours, %2 heures et %3 minutes", _numberDays, _numberHours, _numberMinutes];
};

private _isAdmin = if (_adminLevel > 0) then {true} else {false};

private _copGrades = [
	"Elève gendarme",
	"Gendarme",
	"Maréchal des logis chef",
	"Adjudant",
	"Adjudant-chef",
	"Major",
	"Sous-lieutenant",
	"Lieutenant",
	"Capitaine",
	"Commandant",
	"Lieutenant-colonel",
	"Colonel"
];

private _medicGrades = [
	"Sapeur",
	"Sapeur de 1ère Cl.",
	"Caporal",
	"Caporal-chef",
	"Sergent",
	"Sergent-chef",
	"Adjudant",
	"Adjudant-chef",
	"Lieutenant",
	"Capitaine",
	"ADD/SUP SAMU",
	"Lieutenant-colonel",
	"Colonel"
];

private _publicGrades = [
	"Grade 1",
	"Grade 2",
	"Grade 3",
	"Grade 4",
	"Grade 5",
	"Grade 6",
	"Grade 7",
	"Grade 8"
];

private _penitGrades = [
	"S. Stagiaire",
	"S. Titulaire",
	"S. Principal",
	"S. Brigadier",
	"S. Surveillant",
	"S. Major",
	"S. Lieutenant",
	"S. Capitaine",
	"S. Commandant",
	"S. Colonel"
];

private _faction = "Civil";
private _grade = "";

switch (true) do {
	case (_copLevel > 0): {_faction = "Gendarme - %1"; _grade = _copGrades#(_copLevel - 1)};
	case (_medicLevel > 0): {_faction = "Pompier - %1"; _grade = _medicGrades#(_medicLevel - 1)};
	case (_publique > 0): {_faction = "Service Public - %1"; _grade = _publicGrades#(_publique - 1)};
	case (_penit > 0): {_faction = "Service Pénitentiaire - %1"; _grade = _penitGrades#(_penit - 1)};
	default {};
};

/* -- Manage gear -- */
_gear = [_gear] call ALF_Server_fnc_mresToArray;
private _finalGear = [_gear] call ALFTools_Server_MD_fnc_unpackGear;
_finalGear = [_finalGear] call ALF_Server_fnc_mresArray;

/* -- Check if is ban -- */
private _banResult = [_playerUID] call ALFTools_Server_fnc_checkBan;

[true, format["[['name', '%1'], ['money', %2], ['isAdmin', %3], ['faction', '%4'], ['grade', '%8'], ['loadout', %5], ['playTime', '%6'], ['haveVisa', %7], ['isBan', %9]]", _name, _cash, _isAdmin, _faction, _finalGear, _formatedTime, _isValidate, _grade, _banResult#0], true]