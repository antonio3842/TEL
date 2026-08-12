/*
    File: fn_rebreatherLoop.sqf
    Side: CLIENT
    Author: ALF Core Assistant (MRPV2)

    Points clés:
      - HUD visible UNIQUEMENT sous l’eau + recycleur.
      - Fix: la barre se positionne dès la création ET se met à jour chaque tick.
      - Aucune remise à plein à la reco (on attend la sync serveur).
      - Recharge via item "MRP_O2Refill" (par défaut) hors de l’eau.
      - Compte à rebours asphyxie 120s quand O2=0 sous l’eau.
*/

if (!hasInterface) exitWith {};

//////////////////////////
// PARAMS
//////////////////////////
private _rebreatherClasses = ["V_RebreatherB_mrp","ALF_V_RebreatherB","V_RebreatherB"];

private _maxSeconds      = missionNamespace getVariable ["MRP_rebreather_maxSeconds", 1200];
private _deathGrace      = missionNamespace getVariable ["MRP_rebr_deathGrace", 30];
private _emptyTextDelay  = missionNamespace getVariable ["MRP_rebr_emptyTextDelay", 2];
private _useEngineDrown  = missionNamespace getVariable ["MRP_rebr_useEngineDrown", false];
private _dbgOn           = missionNamespace getVariable ["MRP_rebr_debug", false];
private _refillItem      = missionNamespace getVariable ["MRP_rebr_refillItem", "recharge"];

//////////////////////////
// ETAT (sync serveur)
//////////////////////////
if (isNil { missionNamespace getVariable "MRP_rebr_remaining" }) then {
    missionNamespace setVariable ["MRP_rebr_remaining", -1];
};
if (isNil { missionNamespace getVariable "MRP_rebr_synced" }) then {
    missionNamespace setVariable ["MRP_rebr_synced", false];
};
private _remaining  = missionNamespace getVariable ["MRP_rebr_remaining", -1];
private _synced     = missionNamespace getVariable ["MRP_rebr_synced", false];

if (isNil "MRPV2_fnc_rebreatherSetRemaining") then {
    MRPV2_fnc_rebreatherSetRemaining = {
        params ["_rem"];
        missionNamespace setVariable ["MRP_rebr_remaining", _rem max 0];
        missionNamespace setVariable ["MRP_rebr_synced", true];
    };
};
private _reqNext   = 0;
private _reqPeriod = 3;

//////////////////////////
// ETAT local
//////////////////////////
private _lastTick        = diag_tickTime;
private _hudOn           = false;   // HUD affiché ?
private _depletedAt      = -1;
private _deathRemaining  = -1;
private _lastSavedRem    = -9999;
private _nextSaveAt      = 0;
private _refillActionId  = -1;

//////////////////////////
// AUDIO
//////////////////////////
private _o2CritThreshold   = 0.20;
private _o2SevereThreshold = 0.10;
private _beepO2Period      = 3;
private _beepO2Severe      = 1.5;
private _beepDeath30       = 1.0;
private _beepDeath10       = 0.5;
private _beepO2Next        = 0;
private _beepDeathNext     = 0;

//////////////////////////
// HUD
//////////////////////////
disableSerialization;
private _uiGrp = controlNull;
private _uiBg  = controlNull;
private _uiTxt = controlNull;
private _uiBar = controlNull;

private _C_GREEN="#4CD964"; private _C_AMBER="#FFD426"; private _C_RED="#FF3B30"; private _C_CYAN="#50C8FF"; private _C_DIM="#B0B0B0";
private _TXT_ACTIVATED = "Respiration recycleur activée";
private _TXT_EMPTY     = "Oxygène épuisé ! Remontez à la surface.";
private _TXT_REFILLED  = "Bouteille rechargée — O2 plein";
private _TXT_SYNC      = "Synchronisation de l’oxygène…";

private _dbg = {
    params ["_m"];
    if (_dbgOn) then { systemChat format ["[Rebreather] %1",_m]; diag_log format ["[Rebreather] %1",_m]; };
};

private _ratio = {
    params ["_rem","_max"];
    if (_rem <= 0) exitWith {0};
    (_rem / _max) max 0 min 1
};

private _showHUD = {
    disableSerialization;
    private _d = findDisplay 46; if (isNull _d) exitWith {};
    if (!isNull _uiBar) exitWith {};  // déjà affiché

    _uiGrp = _d ctrlCreate ["RscControlsGroupNoScrollbars", -1];
    _uiGrp ctrlSetPosition [0.36*safezoneW + safezoneX, 0.90*safezoneH + safezoneY, 0.28*safezoneW, 0.07*safezoneH];
    _uiGrp ctrlCommit 0;

    _uiBg = _d ctrlCreate ["RscText", -1, _uiGrp];
    _uiBg ctrlSetPosition [0,0,0.28*safezoneW,0.07*safezoneH];
    _uiBg ctrlSetBackgroundColor [0,0,0,0.35];
    _uiBg ctrlCommit 0;

    _uiTxt = _d ctrlCreate ["RscStructuredText", -1, _uiGrp];
    _uiTxt ctrlSetPosition [0.01*safezoneW, 0.005*safezoneH, 0.26*safezoneW, 0.03*safezoneH];
    _uiTxt ctrlCommit 0;

    _uiBar = _d ctrlCreate ["RscProgress", -1, _uiGrp];
    _uiBar ctrlSetPosition [0.01*safezoneW, 0.035*safezoneH, 0.26*safezoneW, 0.03*safezoneH];
    _uiBar ctrlCommit 0;

    // ⚠️ Init position de la barre dès la création
    private _rem = missionNamespace getVariable ["MRP_rebr_remaining", -1];
    private _syn = missionNamespace getVariable ["MRP_rebr_synced", false];
    private _pos = if (!_syn || {_rem < 0}) then {1} else { [_rem,_maxSeconds] call _ratio };
    _uiBar progressSetPosition _pos;

    cutText [_TXT_ACTIVATED, "PLAIN DOWN", 0.25];
};

private _hideHUD = {
    disableSerialization;
    { if (!isNull _x) then { ctrlDelete _x; }; } forEach [_uiBar,_uiTxt,_uiBg,_uiGrp];
    _uiBar=controlNull; _uiTxt=controlNull; _uiBg=controlNull; _uiGrp=controlNull;
};

//////////////////////////
// Utils: inventaire + action recharge
//////////////////////////
private _hasRebreather = { (vest player) in _rebreatherClasses };
private _countRefillOnPlayer = {
    private _cls = _refillItem;
    count ((items player + uniformItems player + vestItems player + backpackItems player) select { _x isEqualTo _cls })
};
private _ensureRefillAction = {
    // visible si: sync OK, recycleur porté, PAS sous l’eau, O2 pas plein, et au moins 1 item
    private _need = _synced && (call _hasRebreather) && {!underwater player} && {_remaining < (_maxSeconds - 0.5)} && { call _countRefillOnPlayer > 0 };
    if (_need) then {
        private _n = call _countRefillOnPlayer;
        if (_refillActionId < 0) then {
            _refillActionId = player addAction
            [
                format ["<t color='#50C8FF'>Recharger la bouteille</t> (%1 sur toi)", _n],
                {
                    params ["_tgt","_caller","_id","_args"];
                    _args params ["_maxSeconds","_refillItem"];
                    if (underwater player) exitWith { systemChat "Impossible sous l'eau."; };
                    private _syn = missionNamespace getVariable ["MRP_rebr_synced",false];
                    private _rem = missionNamespace getVariable ["MRP_rebr_remaining",-1];
                    if (!_syn || {_rem < 0}) exitWith { systemChat "Oxygène non synchronisé."; };
                    if (_rem >= (_maxSeconds - 0.5)) exitWith { systemChat "La bouteille est déjà pleine."; };
                    private _n = count ((items player + uniformItems player + vestItems player + backpackItems player) select { _x isEqualTo _refillItem });
                    if (_n <= 0) exitWith { systemChat "Aucune recharge sur toi."; };

                    player removeItem _refillItem;
                    missionNamespace setVariable ["MRP_rebr_remaining", _maxSeconds];
                    [getPlayerUID player, _maxSeconds] remoteExecCall ["MRPV2_Server_fnc_rebreatherSave",2];

                    playSound "ClickSoft";
                    cutText [_TXT_REFILLED, "PLAIN DOWN", 0.25];
                },
                [_maxSeconds,_refillItem], 1.5, false, true, "", "true"
            ];
        } else {
            player setUserActionText [_refillActionId, format ["<t color='#50C8FF'>Recharger la bouteille</t> (%1 sur toi)", _n]];
        };
    } else {
        if (_refillActionId >= 0) then { player removeAction _refillActionId; _refillActionId = -1; };
    };
};

//////////////////////////
// Hooks mort/respawn
//////////////////////////
player addEventHandler ["Killed", {
    [getPlayerUID player, missionNamespace getVariable ["MRP_rebr_remaining",-1] max 0] remoteExecCall ["MRPV2_Server_fnc_rebreatherSave",2];
}];
player addEventHandler ["Respawn", {
    [getPlayerUID player, missionNamespace getVariable ["MRP_rebr_remaining",-1] max 0] remoteExecCall ["MRPV2_Server_fnc_rebreatherSave",2];
}];

//////////////////////////
// LOOP
//////////////////////////
while {true} do {
    // OPTIMISÉ: 0.25s (4Hz) au lieu de 0.05s (20Hz) - suffisant pour HUD fluide et consommation précise
    uiSleep 0.25;

    private _now = diag_tickTime;

    // sync serveur tant qu’on n’a pas la valeur
    if (!_synced && {_now >= _reqNext}) then {
        _reqNext = _now + _reqPeriod;
        [player] remoteExecCall ["MRPV2_Server_fnc_rebreatherRequest", 2];
    };

    if (isNull player || {!alive player}) then {
        if (_hudOn) then { call _hideHUD; _hudOn = false; };
        if (_refillActionId >= 0) then { player removeAction _refillActionId; _refillActionId = -1; };
        _depletedAt = -1; _deathRemaining = -1; _beepO2Next=0; _beepDeathNext=0;
        _lastTick = _now; continue;
    };

    private _dt = _now - _lastTick; _lastTick = _now;

    // updates variables mission (serveur → client)
    private _extSyn = missionNamespace getVariable ["MRP_rebr_synced", _synced];
    private _extRem = missionNamespace getVariable ["MRP_rebr_remaining", _remaining];
    if (_extSyn != _synced) then { _synced = _extSyn; };
    if (_extRem != _remaining) then { _remaining = _extRem max -1; };

    private _under = underwater player;
    private _has   = call _hasRebreather;

    // action recharge (hors de l’eau)
    call _ensureRefillAction;

    // HUD : uniquement sous l’eau + recycleur
    if (_under && _has && !_hudOn) then { _hudOn = true; call _showHUD; cutText [_TXT_ACTIVATED, "PLAIN DOWN", 0.25]; };
    if (_hudOn && {(!_under) || {!_has}}) then { _hudOn = false; call _hideHUD; };

    // pas sync → si HUD affiché, contenu "sync"
    if (!_synced || {_remaining < 0}) then {
        if (_hudOn && !isNull _uiTxt) then {
            _uiTxt ctrlSetStructuredText parseText format ["<t align='center' size='1.05'>%1</t>", _TXT_SYNC];
            if (!isNull _uiBar) then { _uiBar progressSetPosition 1; };
        };
        continue;
    };

    // consommation & timer uniquement sous l’eau
    if (_under && _has) then {
        if (_remaining > 0) then {
            _remaining = _remaining - _dt; if (_remaining < 0) then { _remaining = 0; };
            missionNamespace setVariable ["MRP_rebr_remaining", _remaining];

            if (_remaining == 0) then {
                _depletedAt     = _now;
                _deathRemaining = _deathGrace;
                cutText [_TXT_EMPTY, "PLAIN DOWN", 0.25];
                [getPlayerUID player, 0] remoteExecCall ["MRPV2_Server_fnc_rebreatherSave",2];
                _beepDeathNext = _now + 0.5;
            };
        } else {
            if (_deathRemaining < 0) then { _depletedAt = _now; _deathRemaining = _deathGrace; };
            if (_useEngineDrown) then { player setOxygenRemaining 0; };
            _deathRemaining = _deathRemaining - _dt; if (_deathRemaining < 0) then { _deathRemaining = 0; };
            if (_deathRemaining <= 0) then { player setDamage 1; };
        };

        // Bips
        if (_remaining > 0) then {
            private _r = (_remaining / _maxSeconds) max 0 min 1;
            if (_r > 0 && {_r < _o2CritThreshold}) then {
                if (_now >= _beepO2Next) then {
                    playSound "ClickSoft";
                    _beepO2Next = _now + (if (_r < _o2SevereThreshold) then {_beepO2Severe} else {_beepO2Period});
                };
            } else { _beepO2Next = _now + 0.5; };
        };
        if (_remaining == 0 && {_deathRemaining >= 0}) then {
            if (_now >= _beepDeathNext) then {
                private _period = if (_deathRemaining <= 10) then {_beepDeath10} else { if (_deathRemaining <= 30) then {_beepDeath30} else {999} };
                if (_period < 999) then { playSound "ClickSoft"; _beepDeathNext = _now + _period; } else { _beepDeathNext = _now + 0.5; };
            };
        } else { _beepDeathNext = _now + 0.5; };

        // ===== HUD UPDATE (fix barre) =====
        if (_hudOn) then {
            if (!isNull _uiBar) then { _uiBar progressSetPosition ([_remaining,_maxSeconds] call _ratio); };
            if (!isNull _uiTxt) then {
                if (_remaining <= 0) then {
                    private _sinceEmpty = if (_depletedAt >= 0) then { _now - _depletedAt } else { 0 };
                    if (_sinceEmpty >= _emptyTextDelay) then {
                        _uiTxt ctrlSetStructuredText parseText format [
                            "<t align='center' size='1.05'><t color='%1'>Recycleur O2</t> <t color='%2'>|</t> <t color='%3'>Bouteille vide</t> <t color='%2'>|</t> Asphyxie dans <t color='%3'>%4 s</t></t>",
                            _C_CYAN, _C_DIM, _C_RED, round _deathRemaining max 0
                        ];
                    } else {
                        _uiTxt ctrlSetStructuredText parseText format [
                            "<t align='center' size='1.05'><t color='%1'>Recycleur O2</t> <t color='%2'>|</t> 0 s <t color='%2'>(transition)</t></t>",
                            _C_CYAN, _C_DIM
                        ];
                    };
                } else {
                    private _secs = round (_remaining max 0);
                    private _pct  = round (((_remaining / _maxSeconds) max 0 min 1) * 100);
                    private _stateTxt = if (_pct >= 50) then { format["<t color='%1'>OK</t>",_C_GREEN] } else { if (_pct >= 20) then { format["<t color='%1'>Bas</t>",_C_AMBER] } else { format["<t color='%1'>Critique</t>",_C_RED] } };
                    _uiTxt ctrlSetStructuredText parseText format [
                        "<t align='center' size='1.05'><t color='%1'>Recycleur Oxygène</t> <t color='%2'>|</t> %3 s <t color='%2'>|</t> %4%5 <t color='%2'>|</t> Etat: %6</t>",
                        _C_CYAN, _C_DIM, _secs, _pct, "%", _stateTxt
                    ];
                };
            };
        };
        // ===== fin update HUD =====

    } else {
        // On respire → annule le timer (O2 reste)
        _depletedAt = -1; _deathRemaining = -1;
    };

    // Sauvegarde périodique (throttle) si variation significative
    if (_synced && {_now >= _nextSaveAt}) then {
        private _delta = abs (_remaining - _lastSavedRem);
        if (_delta >= 3) then {
            [getPlayerUID player, _remaining] remoteExecCall ["MRPV2_Server_fnc_rebreatherSave",2];
            _lastSavedRem = _remaining;
            _nextSaveAt = _now + 5;
        };
    };
};
