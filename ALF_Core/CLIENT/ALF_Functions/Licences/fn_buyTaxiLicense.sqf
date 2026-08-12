/*
    File: fn_buyTaxiLicense.sqf
*/
if (license_taxi) exitWith {["INFO","Vous avez déjà la licence Taxi.","warning"] spawn ALF_fnc_doMsg;};

private _action = ["Voulez-vous acheter la licence Taxi pour 5000€.","FRANCE TRAVAIL","OUI","NON"] call BIS_fnc_guiMessage;
if (_action) then {

    if (life_cash < 5000) exitWith {["INFO","Vous n'avez pas 5000€ sur vous.","warning"] spawn ALF_fnc_doMsg;};

    life_cash = life_cash - 5000;
    [0] call SOCK_fnc_updatePartial;

    license_taxi = true;
    [1] call SOCK_fnc_updatePartial;

    ["INFO","Vous avez acheté la licence Taxi pour 5000€.","success"] spawn ALF_fnc_doMsg;
};
