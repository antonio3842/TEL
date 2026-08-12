/*
    File: fn_buyEboueurLicense.sqf
    ALF Adam
*/
if(license_enedis) exitWith {["INFO","Vous avez deja la licence Enedis.","warning"] spawn ALF_fnc_doMsg;};

private _action = ["Voulez-vous acheter la licence Enedis pour 7500€.","PREFECTURE","OUI","NON"] call BIS_fnc_guiMessage;
if(_action) then {

    if(life_cash < 7500) exitWith {["INFO","Vous n'avez pas 7500€ sur vous.","warning"] spawn ALF_fnc_doMsg;};

    life_cash = life_cash - 7500;
    [0] call SOCK_fnc_updatePartial;

    license_enedis = true;
    [1] call SOCK_fnc_updatePartial;

    ["INFO","Vous avez achete la licence Enedis d'une valeur de 7500€.","success"] spawn ALF_fnc_doMsg;
};
