/*
    File: fn_updateDABDispo.sqf
    Author: ALF Dev Team
    Executed on: HC3
    Description: Met a jour la dispo du DAB directement en BDD
*/

params [
    ["_posKey", "", [""]],
    ["_amount", 0, [0]],
    ["_unit", objNull, [objNull]]
];

if (_posKey isEqualTo "") exitWith {
    diag_log "[HC3-DAB] updateDABDispo: posKey vide";
};

// Extraire pos_x et pos_y depuis la cle
private _parts = _posKey splitString "_";
if (count _parts < 2) exitWith {
    diag_log format ["[HC3-DAB] updateDABDispo: posKey invalide: %1", _posKey];
};

private _posX = parseNumber (_parts # 0);
private _posY = parseNumber (_parts # 1);

// Recuperer la valeur actuelle depuis la BDD
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

// Depot (valeur positive avec _unit) - verifier si plein
if (_amount > 0 && {!isNull _unit}) then {
    if (_dispo >= 200000) exitWith {
        ["ATM", "Le distributeur est deja plein.", "danger"] remoteExec ["ALF_fnc_doMsg", _unit];
        [] remoteExec ["ALF_fnc_moneyBagHandle", _unit];
    };
};

private _newDispo = _dispo + _amount;

// Bornes : min 0, max 100000
if (_newDispo < 0) then { _newDispo = 0; };
if (_newDispo > 200000) then { _newDispo = 200000; };

// Mettre a jour ou inserer en BDD
private _query = "";
if (_exists) then {
    _query = format [
        "UPDATE atm_dispo SET cash_available=%1 WHERE pos_x=%2 AND pos_y=%3",
        _newDispo, _posX, _posY
    ];
} else {
    _query = format [
        "INSERT INTO atm_dispo (pos_x, pos_y, cash_available) VALUES (%1, %2, %3)",
        _posX, _posY, _newDispo
    ];
};
[_query, 1] call ALF_Server_fnc_asyncCall;

// Mettre a jour HashMap pour sync clients
ALF_DAB_Dispo set [_posKey, _newDispo];
publicVariable "ALF_DAB_Dispo";

diag_log format ["[HC3-DAB] Update: %1 -> %2 (delta: %3, existed: %4)", _posKey, _newDispo, _amount, _exists];
