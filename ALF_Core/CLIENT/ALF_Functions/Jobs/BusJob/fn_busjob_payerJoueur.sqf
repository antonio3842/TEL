/*
    Fichier : fn_busjob_payerJoueur.sqf
    Auteur  : MRP
    Desc    : Payer le joueur — identique au pattern éboueur (life_cash + SOCK_fnc_updatePartial)
*/

params [["_salaire", 0, [0]]];

if (_salaire <= 0) exitWith {};

life_cash = life_cash + _salaire;
[0] call SOCK_fnc_updatePartial;

if (isNil "MRP_BusJob_SalaireTotal") then { MRP_BusJob_SalaireTotal = 0; };
MRP_BusJob_SalaireTotal = MRP_BusJob_SalaireTotal + _salaire;
