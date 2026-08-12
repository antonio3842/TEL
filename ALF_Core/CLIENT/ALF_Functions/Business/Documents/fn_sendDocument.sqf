/* Copyright 2023 - Association Get Your Path. All rights reserved */
if ((lbCurSel 5547) isEqualTo -1) exitWith {["Erreur",format["Type de document invalide !"],"danger"] spawn ALF_fnc_doMsg; false;};
if ((lbCurSel 5543) isEqualTo -1) exitWith {["Erreur",format["Joueur invalide !"],"danger"] spawn ALF_fnc_doMsg; false;};
if ((ctrlText 5544) isEqualTo "") exitWith {["Erreur",format["Vous devez entrer un nombre de jours pour la validité du document !"],"warning"] spawn ALF_fnc_doMsg; false;};

_curConfig = lbData [5547,(lbCurSel 5547)];
_config = ["CLASS",["The_Programmer_Advanced_Documents", "types_documents", _curConfig]] call ALFTools_Client_Config_fnc_getConfig;

_to = lbData [5543,(lbCurSel 5543)];
_to = call compile format ["%1",_to];
if (isNull _to) exitWith {};

private _date = parseNumber (ctrlText 5544);
private _text = ctrlText 5542;

_exit = false;

if (_date <= 0) then {
    _date = 0;

    private _action = [
        "Vous avez spécifié une durée inférieure ou égale à 0, cela signifie que la durée est illimitée. Voulez-vous continuer ?",
        "Confirmation de la durée",
        true,
        true
    ] call BIS_fnc_guiMessage;

    if !(_action) exitWith {_exit = true;};
};

_forcedDuration = ["NUMBER",["force_duration"], _config] call ALFTools_Client_Config_fnc_getConfig;

if (_forcedDuration <= 0) then {
    _minimumDuration = ["NUMBER",["min_duration"], _config] call ALFTools_Client_Config_fnc_getConfig;
    _maximumDuration = ["NUMBER",["max_duration"], _config] call ALFTools_Client_Config_fnc_getConfig;

    if (_date < _minimumDuration) exitWith {
        _exit = true;
        ["Erreur",format["Vous ne pouvez pas entrer une durée aussi courte ! Le minimum pour ce document est de %1 jours.",_minimumDuration],"warning"] spawn ALF_fnc_doMsg;
    };

    if (_maximumDuration > 0) then {
        if (_date > _maximumDuration) then {
            _exit = true;
            ["Erreur",format["Vous ne pouvez pas entrer une durée aussi longue ! Le maximum pour ce document est de %1 jours.",_maximumDuration],"warning"] spawn ALF_fnc_doMsg;
        };
    } else {
        if (_date >= 999) then {
            _exit = true;
            ["Erreur",format["Vous ne pouvez pas entrer une durée aussi longue ! Entrez 0 pour une durée infinie."],"warning"] spawn ALF_fnc_doMsg;
        };
    };
};

if (_exit) exitWith {};

player setVariable ["advanced_document_create",[_curConfig,_date,_text,_to]];

closeDialog 0;
[0,true] spawn ALF_fnc_createDocumentConfirm;
