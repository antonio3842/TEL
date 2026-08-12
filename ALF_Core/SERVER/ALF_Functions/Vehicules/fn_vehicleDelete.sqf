/*
    File: fn_vehicleDelete.sqf
    Author: ALF Core Assistant (patch sécurité "désassurance auto")
    Scope: SERVER
*/

params [
    ["_vid",-1,[0]],
    ["_pid","",[""]]
];

if (_vid isEqualTo -1 || {_pid isEqualTo ""}) exitWith {
    diag_log format ["[ALF][vehicleDelete] Paramètres invalides. _vid=%1 _pid=%2",_vid,_pid];
    false
};

private _t0 = diag_tickTime;

// 1) Lire l'état d'assurance du véhicule AVANT toute modif
private _qInsure = format ["SELECT insure FROM vehicles WHERE id='%1'", _vid];
private _resInsure = [_qInsure, 2] call ALF_Server_fnc_asyncCall;
// _resInsure est généralement un array de lignes ; on prend la 1ère valeur, défaut 0
private _insure = 0;
if !(_resInsure isEqualTo [] || {isNil "_resInsure"}) then {
    // Tolérance: _resInsure peut être [[val]] ou [val] selon l'implémentation de asyncCall
    _insure = (_resInsure param [0, _resInsure]) param [0, 0, [0]];
};

// 2) Marquer le véhicule comme "non vivant"
private _qAlive = format [
    "UPDATE vehicles SET alive='0' WHERE pid='%1' AND id='%2'",
    _pid, _vid
];
[_qAlive, 1] call ALF_Server_fnc_asyncCall;

// 3) Nettoyer les clés temporaires liées au véhicule
private _qKeys = format [
    "DELETE FROM keysTime WHERE mode='0' AND idobj='%1'",
    _vid
];
[_qKeys, 1] call ALF_Server_fnc_asyncCall;

// 4) Si assuré, ajuster les compteurs et retirer l'assurance
//    insure: 0 = non assuré, 1 = perso (axacount), 2 = pro (axaprocount)
switch (_insure) do {
    case 1: {
        private _qDecAxa = format [
            "UPDATE players SET axacount = GREATEST(axacount - 1, 0) WHERE playerid='%1'",
            _pid
        ];
        [_qDecAxa, 1] call ALF_Server_fnc_asyncCall;
    };
    case 2: {
        private _qDecAxaPro = format [
            "UPDATE players SET axaprocount = GREATEST(axaprocount - 1, 0) WHERE playerid='%1'",
            _pid
        ];
        [_qDecAxaPro, 1] call ALF_Server_fnc_asyncCall;
    };
    default { /* rien à faire */ };
};

// 5) Dans tous les cas, forcer l'état "désassuré" du véhicule côté DB
private _qUninsure = format [
    "UPDATE vehicles SET insure='0' WHERE id='%1'",
    _vid
];
[_qUninsure, 1] call ALF_Server_fnc_asyncCall;

// (Optionnel) Log serveur pour debug/traçabilité
diag_log format [
    "[ALF][vehicleDelete] pid=%1 vid=%2 insure=%3 -> alive=0, insure=0, AXA ajusté. (%.3f s)",
    _pid, _vid, _insure, (diag_tickTime - _t0)
];

true
