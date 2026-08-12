#include "\ALF_Client\script_macros.hpp"
/*
    File: fn_createCompoteBanane.sqf
    Auteur: MRP Carter
*/

private _bananeCount = { _x isEqualTo "ALF_Banane" } count magazines player;

// Quantité de compote possible (4 bananes = 1 compote)
private _nbCompotePossible = floor (_bananeCount / 4);

if (_nbCompotePossible < 1) exitWith {
    ["Info", "Il vous faut au moins 4 bananes par compote.", "danger"] spawn ALF_fnc_doMsg;
};

// Enregistrer position initiale
private _startPos = getPosATL player;

// Supprimer les bananes dès le départ
for "_i" from 1 to (_nbCompotePossible * 4) do {
    ["ALF_Banane", false] call ALF_fnc_handleItem;
};

// Début fabrication
disableSerialization;
5 cutRsc ["life_progress","PLAIN"];
private _ui = uiNamespace getVariable "life_progress";
private _progress = _ui displayCtrl 38201;
private _pgText = _ui displayCtrl 38202;

private _upp = "Préparation de la compote";
_pgText ctrlSetText format["%2 (%1%3)...", 0, _upp, "%"];
_progress progressSetPosition 0.01;

private _cP = 0.01;
private _duration = _nbCompotePossible * 15; // 15 secondes par compote
private _step = 0.035;

// Progression
for "_i" from 0 to 1 step 0 do {
    sleep _step;
    _cP = _cP + (_step / _duration);
    _progress progressSetPosition _cP;
    _pgText ctrlSetText format["%3 (%1%2)...", round(_cP * 100), "%", _upp];

    if (_cP >= 1) exitWith {};
    if (!alive player) exitWith {};
    if (life_interrupted) exitWith {};

    // Vérifie distance 30m
    if ((player distance2D _startPos) > 30) exitWith {
        life_interrupted = true;
    };
};

// Fin
5 cutText ["", "PLAIN"];

if (!alive player) exitWith {};

if (life_interrupted) exitWith {
    life_interrupted = false;
    titleText["Action annulée : vous vous êtes éloigné. Bananes restituées.", "PLAIN"];

    // Remboursement
    for "_i" from 1 to (_nbCompotePossible * 4) do {
        player addItem "ALF_Banane";
    };
};

// Ajouter la compote
for "_i" from 1 to _nbCompotePossible do {
    player addItem "TAG_Compote_F_F";
};

["Info", format["Vous avez fabriqué %1 compote(s) de banane.", _nbCompotePossible], "success"] spawn ALF_fnc_doMsg;