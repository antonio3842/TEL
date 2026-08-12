/*
    File: fn_retraitDAB.sqf
    Author: ALF Dev Team
    Executed on: HC3
    Description: Verifie dispo DAB en BDD et confirme le retrait au client
*/

params [
    ["_posKey", "", [""]],
    ["_montant", 0, [0]],
    ["_clientOwner", 0, [0]],
    ["_livret", 1, [0]]
];

if (_posKey isEqualTo "" || _montant <= 0 || _clientOwner == 0) exitWith {
    diag_log format ["[HC3-DAB] retraitDAB: params invalides - posKey=%1, montant=%2, owner=%3", _posKey, _montant, _clientOwner];
};

// Extraire pos_x et pos_y
private _parts = _posKey splitString "_";
if (count _parts < 2) exitWith {
    diag_log format ["[HC3-DAB] retraitDAB: posKey invalide: %1", _posKey];
};

private _posX = parseNumber (_parts # 0);
private _posY = parseNumber (_parts # 1);

// Recuperer la dispo actuelle depuis BDD
private _selectQuery = format ["SELECT cash_available FROM atm_dispo WHERE pos_x=%1 AND pos_y=%2", _posX, _posY];
private _result = [_selectQuery, 2, false] call ALF_Server_fnc_asyncCall;

private _dispo = 0;
private _exists = false;

if (!isNil "_result" && {count _result > 0}) then {
    private _row = _result select 0;
    // asyncCall retourne [[val]] ou [val] selon le cas
    if (_row isEqualType []) then {
        _dispo = _row select 0;
    } else {
        _dispo = _row;
    };
    _exists = true;
};

diag_log format ["[HC3-DAB] retraitDAB: posKey=%1, montant=%2, dispo=%3, exists=%4", _posKey, _montant, _dispo, _exists];

// Verifier si le DAB a assez
if (_montant > _dispo) exitWith {
    ["Distributeur", format ["Ce distributeur ne contient que %1€.", _dispo], "danger"] remoteExec ["ALF_fnc_doMsg", _clientOwner];
    diag_log format ["[HC3-DAB] Retrait REFUSE: demande=%1, dispo=%2, pos=%3", _montant, _dispo, _posKey];
};

// OK - Mettre a jour BDD
private _newDispo = _dispo - _montant;

private _query = "";
if (_exists) then {
    _query = format ["UPDATE atm_dispo SET cash_available=%1 WHERE pos_x=%2 AND pos_y=%3", _newDispo, _posX, _posY];
} else {
    _query = format ["INSERT INTO atm_dispo (pos_x, pos_y, cash_available) VALUES (%1, %2, %3)", _posX, _posY, _newDispo];
};
[_query, 1] call ALF_Server_fnc_asyncCall;

// Sync HashMap
ALF_DAB_Dispo set [_posKey, _newDispo];
publicVariable "ALF_DAB_Dispo";

// Envoyer confirmation au client pour modifier son argent
[_montant, _livret] remoteExec ["ALF_fnc_confirmRetrait", _clientOwner];

diag_log format ["[HC3-DAB] Retrait OK: %1€, livret=%2, dispo restant=%3", _montant, _livret, _newDispo];
