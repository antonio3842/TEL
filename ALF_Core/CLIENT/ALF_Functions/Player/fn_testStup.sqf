// /*
// 	File: fn_testStup.sqf
// 	Author: ALF Adam
// */
// private _u = _this select 0;
// if(isNull _u) exitWith {};
// private _a = ["Quelqu'un vous présente un dépistage salivaire. Voulez-vous vous y soumettre ?","Question","OUI","NON"] call BIS_fnc_guiMessage;
// if(isNull _u) exitWith {};
// if (!_a) exitWith {
// 	["INFO","Cette personne refuse de se soumettre au dépistage.","warning"] remoteExec ["ALF_fnc_doMsg",_u];
// };

// if(!('ALF_TestStup' in (magazines _u))) exitWith {
// 	["INFO","Il vous faut un kit salivaire pour effectuer un dépistage.","warning"] remoteExec ["ALF_fnc_doMsg",_u];
// };
// ["ALF_TestStup",false] remoteExec ["ALF_fnc_handleItem",_u];

// ["INFO","La personne a accepté le dépistage salivaire. Patientez 20 secondes pour obtenir le résultat.","warning"] remoteExec ["ALF_fnc_doMsg",_u];
// if(alf_drug <= 0) then {
// 	uiSleep 20;
// 	["INFO","Le dépistage salivaire est négatif.","warning"] remoteExec ["ALF_fnc_doMsg",_u];
// } else {
// 	uiSleep 20;
// 	["INFO","Le dépistage salivaire est positif.","warning"] remoteExec ["ALF_fnc_doMsg",_u];
// };
//------------------------------------------
/*
    File: fn_testStup.sqf
    Author: ALF Adam
    Notes: version corrigée (lecture robuste de alf_drug)
*/

params ["_tester"];                       // unité du TESTEUR (celle qui reçoit les messages)
if (isNull _tester) exitWith {};

private _accepted = [
    "Quelqu'un vous présente un dépistage salivaire. Voulez-vous vous y soumettre ?",
    "Question","OUI","NON"
] call BIS_fnc_guiMessage;

if (!_accepted) exitWith {
    ["INFO","Cette personne refuse de se soumettre au dépistage.","warning"]
        remoteExec ["ALF_fnc_doMsg", _tester];
};

// Vérifie que le testeur possède le kit
if (!("ALF_TestStup" in (magazines _tester))) exitWith {
    ["INFO","Il vous faut un kit salivaire pour effectuer un dépistage.","warning"]
        remoteExec ["ALF_fnc_doMsg", _tester];
};

// Consomme le kit côté testeur
["ALF_TestStup", false] remoteExec ["ALF_fnc_handleItem", _tester];

// Informe le testeur et patiente 20s
["INFO","La personne a accepté le dépistage salivaire. Patientez 20 secondes pour obtenir le résultat.","warning"]
    remoteExec ["ALF_fnc_doMsg", _tester];

uiSleep 20;

// --- Lecture robuste du statut stupéfiants côté JOUEUR TESTÉ ---
// 1) on lit d'abord la variable sur le joueur local (testé)
// 2) fallback éventuel sur missionNamespace
// 3) on force en nombre pour éviter les cas "0" (string), false, nil, etc.
private _raw   = player getVariable ["alf_drug", missionNamespace getVariable ["alf_drug", 0]];
private _drug  = parseNumber str _raw;       // "0" -> 0 ; false -> 0 ; nil -> "any" -> parseNumber -> 0
private _pos   = (_drug >= 0.5);

// (Option debug)
// diag_log format ["[TEST_STUP] alf_drug brut=%1 type=%2 -> numeric=%3", _raw, typeName _raw, _drug];

if (_pos) then {
    ["INFO","Le dépistage salivaire est positif.","warning"]
        remoteExec ["ALF_fnc_doMsg", _tester];
} else {
    ["INFO","Le dépistage salivaire est négatif.","warning"]
        remoteExec ["ALF_fnc_doMsg", _tester];
};

