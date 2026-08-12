/*
    File: fn_eboueur_viderCamion.sqf
    Author: MRP
    Description: Vide le camion à la déchetterie
*/

if (!alive player) exitWith {};

if (!(player getVariable ["MRP_Ambulancier_EnService", false])) exitWith {
    ["Ambulancier", "Vous n'êtes pas en service!", "danger"] spawn ALF_fnc_doMsg;
};

private _camion = player getVariable ["MRP_Ambulancier_Camion", objNull];

if (isNull _camion) exitWith {
    ["Ambulancier", "Camion introuvable!", "danger"] spawn ALF_fnc_doMsg;
};

if (player distance _camion > 20) exitWith {
    ["Ambulancier", "Camion trop loin!", "danger"] spawn ALF_fnc_doMsg;
};

private _nbOrdures = _camion getVariable ["MRP_Ambulancier", false];

// Vérifier si le camion est vraiment vide
if !(_nbOrdures) exitWith {
    ["Ambulancier", "Camion vide!", "warning"] spawn ALF_fnc_doMsg;
};


private _salaire = 1500;
_camion lock 2;


_camion setVariable ["MRP_Ambulancier", false, true];

life_cash = life_cash + _salaire;
[0] call SOCK_fnc_updatePartial;

private _msg = format ["Voici votre salaire : %1 €", _salaire];
["Ambulancier", _msg, "success"] spawn ALF_fnc_doMsg;
MRP_AmbulancierEnCours = false;

private _result = ["Voulez vous commencer une nouvelle mission ?", "Ambulancier", "OUI", "NON"] call BIS_fnc_guiMessage;

if (_result) then {
    [MRP_Ambulancier_Destination] call ALF_fnc_ambulancier_initMission;
} else {
    MRP_Ambulancier_Destination = "";
};