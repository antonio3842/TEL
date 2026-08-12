/*
	File: fn_updateDABDispo.sqf
	Author: ALF Dev Team
	Description: Met à jour la disponibilité du DAB (dépôt ou retrait)
*/

params [
	["_dab", objNull, [objNull]],
	["_amount", 0, [0]],
	["_unit", objNull, [objNull]]
];

if (isNull _dab) exitWith {};

private _dispo = _dab getVariable ["dispo", 100000];

// Dépôt (valeur positive avec _unit)
if (_amount > 0 && {!isNull _unit}) then {
	if (_dispo isEqualTo 100000) exitWith {
		["ATM", "Le distributeur est déjà plein.", "danger"] remoteExec ["ALF_fnc_doMsg", _unit];
		[] remoteExec ["ALF_fnc_moneyBagHandle", _unit];
	};
};

private _newDispo = _dispo + _amount;

// Bornes : min 0, max 100000
if (_newDispo < 0) then { _newDispo = 0; };
if (_newDispo > 100000) then { _newDispo = 100000; };

_dab setVariable ["dispo", _newDispo];
