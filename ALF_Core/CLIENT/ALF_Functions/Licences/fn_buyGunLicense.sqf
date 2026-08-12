#include "\ALF_Client\script_macros.hpp"
/*
    File: fn_buyHomeLicense.sqf
    ALF Nanou
*/
if(license_gun) exitWith {["INFO","Vous avez deja le permis de port d'armes.","warning"] spawn ALF_fnc_doMsg;};

private _action = ["Voulez-vous acheter un permis de port d'armes pour 150000€.","Port d'armes","OUI","NON"] call BIS_fnc_guiMessage;
if(_action) then {

    if(life_cash < 150000) exitWith {["INFO","Vous n'avez  pas 150000€ sur vous.","warning"] spawn ALF_fnc_doMsg;};

    life_cash = life_cash - 150000;
    [0] call SOCK_fnc_updatePartial;

    license_gun = true;
    [1] call SOCK_fnc_updatePartial;

    ["INFO","Vous avez achete le permis de port d'armes d'une valeur de 150000€.","success"] spawn ALF_fnc_doMsg;
};
