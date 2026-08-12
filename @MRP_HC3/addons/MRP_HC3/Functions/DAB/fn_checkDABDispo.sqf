/*
	File: fn_checkDABDispo.sqf
	Author: ALF Dev Team
	Executed on: HC3
	Description: Vérifie la disponibilité du DAB en BDD et retourne le résultat au client
*/

params [
	["_posKey", "", [""]],
	["_unit", objNull, [objNull]]
];

if (_posKey isEqualTo "" OR {isNull _unit}) exitWith {
	diag_log "[HC3-DAB] checkDABDispo: paramètres invalides";
};

// Extraire pos_x et pos_y depuis la clé
private _parts = _posKey splitString "_";
if (count _parts < 2) exitWith {
	diag_log format ["[HC3-DAB] checkDABDispo: posKey invalide: %1", _posKey];
	0 remoteExec ["ALF_fnc_setDABCheckResult", _unit];
};

private _posX = parseNumber (_parts # 0);
private _posY = parseNumber (_parts # 1);

// Récupérer la valeur actuelle depuis la BDD
private _selectQuery = format ["SELECT cash_available FROM atm_dispo WHERE pos_x=%1 AND pos_y=%2", _posX, _posY];
private _result = [_selectQuery, 2, false] call ALF_Server_fnc_asyncCall;

private _dispo = 0;

if (!isNil "_result" && {count _result > 0}) then {
	private _row = _result select 0;
	if (_row isEqualType []) then {
		_dispo = _row select 0;
	} else {
		_dispo = _row;
	};
};

diag_log format ["[HC3-DAB] checkDABDispo: %1 -> %2", _posKey, _dispo];

// Envoyer le résultat au client
[_dispo] remoteExec ["ALF_fnc_receiveDABCheck", _unit];
