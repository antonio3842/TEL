/*
    File: fn_buyDistribLicense.sqf
*/
if (license_distrib) exitWith {["INFO", "Vous avez déjà la licence Distributeur.", "warning"] spawn ALF_fnc_doMsg;};

private _action = ["Voulez-vous acheter la licence Distributeur pour 7500€.", "FRANCE TRAVAIL", "OUI", "NON"] call BIS_fnc_guiMessage;
if (_action) then {

    if (life_cash < 7500) exitWith {["INFO", "Vous n'avez pas 7500€ sur vous.", "warning"] spawn ALF_fnc_doMsg;};

    life_cash = life_cash - 7500;
    [0] call SOCK_fnc_updatePartial;

    license_distrib = true;
    [1] call SOCK_fnc_updatePartial;

    ["INFO", "Vous avez acheté la licence Distributeur pour 7500€.", "success"] spawn ALF_fnc_doMsg;
};
