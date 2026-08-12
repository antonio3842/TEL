/*
    File: fn_rebreatherRecharge.sqf
    Side: CLIENT
    Author: ALF Core Assistant (MRPV2)

    Recharge la bouteille à une borne via un bouton (pas hold-action).
    - Recharge CONTINUE sur 5 min par défaut (partiel conservé si interrompu).
    - Affiche une barre de progression + temps restant.
    - Sauvegarde serveur périodique et à la fin.

    Paramètres:
      0: <OBJECT>  station (ex: cursorObject)
      1: <NUMBER>  durée en secondes (def 300)
      2: <NUMBER>  rayon max depuis la borne (def 3.5)
*/

if (!hasInterface) exitWith {};

params [
    ["_station", objNull, [objNull]],
    ["_duration", 300, [0]],
    ["_radius",   3.5, [0]]
];

private _rebreatherClasses = ["V_RebreatherB_mrp","ALF_V_RebreatherB","V_RebreatherB"];
private _maxSeconds = missionNamespace getVariable ["MRP_rebreather_maxSeconds", 600];

if (isNull _station) exitWith { systemChat "Aucune borne."; };

//////////////////////////////////////////////////
// Préconditions
//////////////////////////////////////////////////
if (!alive player) exitWith { systemChat "Action impossible."; };
if (!((vest player) in _rebreatherClasses)) exitWith { systemChat "Tu dois porter un recycleur."; };
if (underwater player) exitWith { systemChat "Impossible sous l'eau."; };
if (vehicle player != player) exitWith { systemChat "Sors du véhicule."; };

private _synced = missionNamespace getVariable ["MRP_rebr_synced", false];
private _rem    = missionNamespace getVariable ["MRP_rebr_remaining", -1];

if (!_synced || {_rem < 0}) exitWith { systemChat "Oxygène non synchronisé."; };
if (_rem >= (_maxSeconds - 0.5)) exitWith { systemChat "La bouteille est déjà pleine."; };
if ((player distance _station) > _radius) exitWith { systemChat "Trop loin de la borne."; };

//////////////////////////////////////////////////
// UI locale (barre de progression)
//////////////////////////////////////////////////
disableSerialization;
private _grp = displayNull;
private _bg  = controlNull;
private _txt = controlNull;
private _bar = controlNull;

private _uiShow = {
    disableSerialization;
    private _d = findDisplay 46; if (isNull _d) exitWith {};
    _grp = _d ctrlCreate ["RscControlsGroupNoScrollbars", -1];
    _grp ctrlSetPosition [0.32 * safezoneW + safezoneX, 0.82 * safezoneH + safezoneY, 0.36 * safezoneW, 0.09 * safezoneH];
    _grp ctrlCommit 0;

    _bg = _d ctrlCreate ["RscText", -1, _grp];
    _bg ctrlSetPosition [0,0,0.36*safezoneW,0.09*safezoneH];
    _bg ctrlSetBackgroundColor [0,0,0,0.45];
    _bg ctrlCommit 0;

    _txt = _d ctrlCreate ["RscStructuredText", -1, _grp];
    _txt ctrlSetPosition [0.01*safezoneW, 0.006*safezoneH, 0.34*safezoneW, 0.04*safezoneH];
    _txt ctrlCommit 0;

    _bar = _d ctrlCreate ["RscProgress", -1, _grp];
    _bar ctrlSetPosition [0.01*safezoneW, 0.05*safezoneH, 0.34*safezoneW, 0.03*safezoneH];
    _bar ctrlCommit 0;
    _bar progressSetPosition 0;
};
private _uiHide = {
    disableSerialization;
    { if (!isNull _x) then { ctrlDelete _x; }; } forEach [_bar,_txt,_bg,_grp];
    _bar = controlNull; _txt = controlNull; _bg = controlNull; _grp = displayNull;
};
private _uiUpdate = {
    params ["_p","_tleft"]; // 0..1 , secondes restantes
    if (!isNull _bar) then { _bar progressSetPosition (_p max 0 min 1); };
    if (!isNull _txt) then {
        _txt ctrlSetStructuredText parseText format [
            "<t align='center' size='1.1'><t color='#50C8FF'>Recharge du recycleur</t> <t color='#B0B0B0'>|</t> %1%2 <t color='#B0B0B0'>|</t> Temps restant: %3 s</t>",
            round (_p*100), "%", round _tleft max 0
        ];
    };
};

//////////////////////////////////////////////////
// Boucle de recharge (progressive, avec sauvegarde périodique)
//////////////////////////////////////////////////
call _uiShow;

private _startTime = diag_tickTime;
private _startRem  = _rem;
private _nextSave  = _startTime + 5; // save serveur toutes les 5s

// petit son de départ
playSound "ClickSoft";

private _ok = true;
while {true} do {
    uiSleep 0.05;

    // conditions d'annulation
    if (!alive player) exitWith {_ok = false;};
    if ((player distance _station) > _radius) exitWith {_ok = false;};
    if (underwater player) exitWith {_ok = false;};
    if (vehicle player != player) exitWith {_ok = false;};
    if (!((vest player) in _rebreatherClasses)) exitWith {_ok = false;};

    // progression
    private _t    = diag_tickTime - _startTime;
    private _frac = (_t / _duration) max 0 min 1;

    private _newRem = _startRem + _frac * (_maxSeconds - _startRem);
    missionNamespace setVariable ["MRP_rebr_remaining", _newRem];

    // UI
    [_frac, (_duration - _t)] call _uiUpdate;

    // save serveur périodique
    if (diag_tickTime >= _nextSave) then {
        [getPlayerUID player, _newRem] remoteExecCall ["MRPV2_Server_fnc_rebreatherSave",2];
        _nextSave = diag_tickTime + 5;
    };

    if (_frac >= 1) exitWith {};
};

call _uiHide;

if (_ok) then {
    // fin réussie -> plein + save
    missionNamespace setVariable ["MRP_rebr_remaining", _maxSeconds];
    [getPlayerUID player, _maxSeconds] remoteExecCall ["MRPV2_Server_fnc_rebreatherSave",2];
    playSound "ClickSoft";
    cutText ["<t color='#50C8FF'>Bouteille rechargée — O2 plein</t>", "PLAIN DOWN", 0.25];
} else {
    // interrompu -> conserve la charge partielle déjà appliquée
    systemChat "Recharge interrompue.";
};
