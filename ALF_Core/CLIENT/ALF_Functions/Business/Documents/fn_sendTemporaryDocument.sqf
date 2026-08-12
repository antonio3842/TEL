/* Copyright 2023 - Association Get Your Path. All rights reserved */
if ((lbCurSel 4515) isEqualTo -1) exitWith {["Erreur",format["Vous devez sélectionner un document pour continuer !"],"danger"] spawn ALF_fnc_doMsg;};

private _data = lbData [4515,(lbCurSel 4515)];
if (_data isEqualTo "NULL") exitWith ["Erreur",format["Vous devez sélectionner un document pour continuer !"],"danger"] spawn ALF_fnc_doMsg;};
_data = call compile format["%1",_data];

private _unit = cursorObject;

if (isNil "_unit") exitWith {hint localize "STR_NOTF_notWithinRange";};
if (isNull _unit) exitWith {hint localize "STR_NOTF_notWithinRange";};
if !(isPlayer _unit) exitWith { hint localize "STR_NOTF_notWithinRange"; };

private _action = true;

private _allowCopy = ["NUMBER",["The_Programmer_Advanced_Documents", "allow_to_create_copy_of_copy"]] call ALFTools_Client_Config_fnc_getConfig;

if (((_data select 8) isEqualTo 0) || (_allowCopy isEqualTo 1)) then {
    _action = [
        "Voulez vous donner une copie ou seulement montrer le document à la personne en face de vous ?",
        "Que voulez vous faire ?",
        "Montrer",
        "Copier"
    ] call BIS_fnc_guiMessage;
};

if (_action) then {
    _unit setVariable ["advanced_documents_temporary",_data,true];

    ["Document",format["Vous avez montré le document à quelqu'un"],"success"] spawn ALF_fnc_doMsg;
    [1,"Quelqu'un vous a donné un document"] remoteExecCall ["life_fnc_broadcast",_unit];
} else {
    [(_data select 3),(_data select 4),(_data select 5),(_data select 6),(_data select 7),(_data select 0),(_data select 9),(getPlayerUID _unit)] remoteExec ["advanced_documents_tpfn_copyDocuments",2];

     ["Document",format["Vous avez envoyé une copie du document à quelqu'un"],"success"] spawn ALF_fnc_doMsg;
    [1,"Quelqu'un vous a donné une copie d'un document"] remoteExecCall ["life_fnc_broadcast",_unit];
};
