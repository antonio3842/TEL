/*
	File: fn_updateCashClient.sqf
	Author: ALF Dev Team
	
	Description:
	Met à jour le cash côté client et synchronise avec la BDD (comme dans fn_payEntreprise)
*/
params [
	["_amount", 0, [0]]
];

if (_amount == 0) exitWith {};

// Modifier le cash (positif = ajouter, négatif = retirer)
life_cash = life_cash + _amount;

// Synchroniser avec la BDD (comme dans fn_payEntreprise ligne 43)
[0] call SOCK_fnc_updatePartial;

