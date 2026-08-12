/*
    File: fn_buyEboueurLicense.sqf
    ALF Adam
*/
if(license_ambulancier) exitWith {["INFO","Vous avez deja la licence Ambulancier.","warning"] spawn ALF_fnc_doMsg;};

private _action = ["Voulez-vous acheter la licence Ambulancier pour 7500€.","PREFECTURE","OUI","NON"] call BIS_fnc_guiMessage;
if(_action) then {

    if(life_cash < 7500) exitWith {["INFO","Vous n'avez pas 7500€ sur vous.","warning"] spawn ALF_fnc_doMsg;};

    life_cash = life_cash - 7500;
    [0] call SOCK_fnc_updatePartial;

    license_ambulancier = true;
    [1] call SOCK_fnc_updatePartial;
    
    [getPlayerUID player] remoteExec ["ALF_Server_fnc_jobTime",2];

    ["INFO","Vous avez achete la licence ambulancier d'une valeur de 7500€ pour une durée d'une semaine.","success"] spawn ALF_fnc_doMsg;
};
