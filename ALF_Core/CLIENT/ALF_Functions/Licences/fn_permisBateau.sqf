if(license_boat) exitWith {["INFO","Vous avez deja le Permis bateau.","warning"] spawn ALF_fnc_doMsg;};

private _action = ["Voulez-vous acheter un Permis bateau pour 25000€.","Le Permis bateau","OUI","NON"] call BIS_fnc_guiMessage;
if(_action) then {

    if(life_cash < 25000) exitWith {["INFO","Vous n'avez pas 25000€ sur vous.","warning"] spawn ALF_fnc_doMsg;};

    life_cash = life_cash - 25000;
    [0] call SOCK_fnc_updatePartial;

    license_boat = true;
    [1] call SOCK_fnc_updatePartial;

    ["INFO","Vous avez acheté le Permis bateau d'une valeur de 25000€.","success"] spawn ALF_fnc_doMsg;
};
