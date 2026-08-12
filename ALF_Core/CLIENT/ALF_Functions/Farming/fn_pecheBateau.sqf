/*
    File: ALF_fishingNet.sqf (optimisé — 5 points ciblés + stop soute pleine + ANCRE)
    Applique uniquement :
      1) Tirage de loot précompilé
      2) Moins de variables publiques
      3) Stop auto sur événements
      4) Hold-action pour Déployer & Remonter (filet)
      5) Messages unifiés via ALF_fnc_doMsg
      + Arrêt si soute pleine
      + Hold-actions Ancre (Jeter / Remonter) — visible seulement si MRP_Ancre en soute
      + Déploiement du filet visible seulement si MRP_Carton_Fillet (magazine) en soute
      + Remontée auto après chaque cycle + cooldown 10 s

      ++ MODIF: Interdiction de pêcher avec VEH_MRP_BM_Yatch (actions filet masquées + message si tentative)
*/

params [
    ["_mode", "start", [""]],
    ["_vehFromEH", objNull, [objNull]]
];

if (!hasInterface) exitWith {};

private _isStop = (_mode isEqualTo "stop");

/* =============================================================================
   CONFIG
   ========================================================================== */
private _CFG_INTERVAL     = 60;    // durée d'un cycle complet (s)
private _CFG_LOOT_MIN     = 8;     // minimum d'items par cycle
private _CFG_LOOT_MAX     = 12;    // maximum d'items par cycle
private _CFG_DEBUG        = false; // true pour afficher la surface détectée au lancement
private _CFG_COOLDOWN_S   = 10;    // cooldown après remontée (s)

// Bateaux interdits de pêche (extensible)
private _CFG_FORBIDDEN_BOATS = ["VEH_MRP_BM_Yatch"];

private _CFG_RARITY_WEIGHTS = [
    ["commun",70], ["peu_commun",35], ["vide",15], ["rare",10], ["tres_rare",0.5]
];

private _CFG_LOOT = [
    ["ALF_Maquereau_Crue_M","commun"],
    ["Algues","commun"],
    ["ALF_Sardine","commun"],
    ["ALF_Thon","peu_commun"],
    ["ALF_Barbeau","peu_commun"],
    ["bouteille_vide","peu_commun"],
    ["ALF_Brochet","rare"],
    ["ALF_Anguille","rare"],
    ["ALF_Saumon","peu_commun"],
    ["ALF_Squale","tres_rare"],
    ["","vide"]
];

/* =============================================================================
   HELPERS (local functions)
   ========================================================================== */

// Détermine le bateau cible selon le mode
private _fnGetBoat = {
    params ["_isStop","_vehFromEH"];
    if (_isStop) exitWith {
        if (!isNull _vehFromEH) exitWith { _vehFromEH };
        player getVariable ["ALF_fishingNet_lastBoat", objNull]
    };
    vehicle player
};

// === ANCRE === présent uniquement dans la soute bateau ?
private _fnHasAnchor = {
    params ["_boat"];
    private _mc = getMagazineCargo _boat;               // [[classes],[counts]]
    private _idx = (_mc#0) find "MRP_Ancre";
    _idx >= 0 && { (_mc#1)#_idx > 0 }
};

// === ANCRE === appliquer (true = jeter / false = remonter)
private _fnSetAnchored = {
    params ["_boat","_state"];
    _boat setVariable ["ALF_anchor_deployed", _state, false];
    if (_state) then {
        _boat forceSpeed 0;                 // immobilise
        _boat setVelocityModelSpace [0,0,0];
        ["Info","Ancre jetée. Le bateau est immobilisé.","success"] spawn ALF_fnc_doMsg;
    } else {
        _boat forceSpeed -1;                // libère
        ["Info","Ancre remontée. Tu peux repartir.","info"] spawn ALF_fnc_doMsg;
    };
};

// Supprime/retire les actions existantes et reset flags
private _fnCleanupActions = {
    params ["_boat"];
    {
        private _id = _boat getVariable [_x,-1];
        if (_id != -1) then {
            _boat removeAction _id;
            [_boat, _id] call BIS_fnc_holdActionRemove;
            _boat setVariable [_x,-1,false];
        };
    } forEach [
        "ALF_net_act_launch",
        "ALF_net_act_retract",
        // === ANCRE ===
        "ALF_anchor_act_drop",
        "ALF_anchor_act_raise"
    ];
};

// ------------------- Tirage précompilé (1) -------------------
private _wMap = createHashMapFromArray _CFG_RARITY_WEIGHTS;

// Distribution cumulative précompilée: [[class,cumWeight], ...], _totalW
private _DIST = [];
private _totalW = 0;
{
    private _cls = _x#0;
    private _rar = _x#1;
    private _w = _wMap getOrDefault [_rar,0];
    if (_w > 0 && {_cls != ""}) then {
        _totalW = _totalW + _w;
        _DIST pushBack [_cls, _totalW];
    };
} forEach _CFG_LOOT;

// Tirage amorti (balayage court) — robuste
private _fnPickWeighted = {
    params ["_DIST","_totalW"];
    if (_totalW <= 0) exitWith { "" };
    private _r = random _totalW;
    private _sel = (_DIST select (count _DIST - 1))#0;
    {
        if (_r <= (_x#1)) exitWith { _sel = _x#0 };
    } forEach _DIST;
    _sel
};

// Boucle de pêche — un seul cycle, puis remontée auto + cooldown
private _fnLoopStart = {
    params ["_boat","_DIST","_totalW","_interval","_pick","_min","_max","_fnLoopStop","_cooldown"];

    call _fnLoopStop; // sécurité : stop toute boucle précédente
    player setVariable ["ALF_fishingNet_running", true, false];

    private _handle = [_boat,_DIST,_totalW,_interval,_pick,_min,_max,_fnLoopStop,_cooldown] spawn {
        params ["_b","_DIST","_totalW","_itv","_pick","_min","_max","_fnStop","_cd"];

        private _isOk = {
            alive player
            && {!isNull _b}
            && {_b isKindOf "Ship"}
            && {driver _b isEqualTo player}
            && {player getVariable ["ALF_fishingNet_running", false]}
        };

        if (call _isOk) then {
            uiSleep (_itv max 1);
            if !(call _isOk) exitWith {};

            private _count = _min + floor (random (_max - _min + 1));

            // Agrégation par classe pour ajout groupé
            private _bag = createHashMap;
            for "_i" from 1 to _count do {
                private _cls = [_DIST,_totalW] call _pick;
                if (_cls != "") then {
                    _bag set [_cls, (_bag getOrDefault [_cls,0]) + 1];
                };
            };

            private _keys = keys _bag;
            if (_keys isEqualTo []) then {
                ["Info","Le filet était vide.","warning"] spawn ALF_fnc_doMsg;
            } else {
                // Ajout item par item (respect capacité)
                private _added = 0;
                {
                    private _cls = _x;
                    private _qty = _bag get _cls;
                    for "_i" from 1 to _qty do {
                        if (_b canAdd [_cls,1]) then {
                            _b addMagazineCargoGlobal [_cls,1];
                            _added = _added + 1;
                        };
                    };
                } forEach _keys;

                if (_added == 0) then {
                    ["Info","La soute du bateau est pleine. Le filet s’arrête.","danger"] spawn ALF_fnc_doMsg;
                } else {
                    ["Info", format["Filet remonté : %1 article(s) ajouté(s) en soute.", _added], "success"] spawn ALF_fnc_doMsg;
                };
            };

            // --- Remontée automatique + cooldown
            _b setVariable ["ALF_net_cd_t", diag_tickTime + _cd, false];
            ["Info","Remontage automatique du filet. (Patienter 10 s)","info"] spawn ALF_fnc_doMsg;
            call _fnStop;   // tue ce handle + reset flags
        };
    };

    player setVariable ["ALF_fishingNet_handle", _handle, false];
};

// Arrêt propre (kill spawn + flags)
private _fnLoopStop = {
    private _h = player getVariable ["ALF_fishingNet_handle", scriptNull];
    if (!isNull _h) then { terminate _h; };
    player setVariable ["ALF_fishingNet_handle", scriptNull, false];
    player setVariable ["ALF_fishingNet_running", false, false];
};

// Création des actions interactives sur le bateau
private _fnInitActions = {
    params ["_boat"];

    // Expose helpers pour les conditions string (si tu utilises ailleurs)
    missionNamespace setVariable ["ALF_fishingNet_fncHasAnchor", _fnHasAnchor];
    missionNamespace setVariable ["ALF_fishingNet_fncSetAnchored", _fnSetAnchored];

    // --- _condLaunch : exige magazine + pas en cours + cooldown OK + NOT forbidden boat
    private _condLaunch =
        "driver _target isEqualTo player"
        +" && { _target isKindOf 'Ship' }"
        +" && { !(_target isKindOf 'VEH_MRP_BM_Yatch') }"
        +" && { !(player getVariable ['ALF_fishingNet_running', false]) }"
        +" && { diag_tickTime >= (_target getVariable ['ALF_net_cd_t',0]) }"
        +" && { private _mc = getMagazineCargo _target; private _i = (_mc select 0) find 'MRP_Carton_Fillet'; _i >= 0 && { ((_mc select 1) select _i) > 0 } }";

    private _condRetract =
        "driver _target isEqualTo player && { _target isKindOf 'Ship' } && { !(_target isKindOf 'VEH_MRP_BM_Yatch') } && { (player getVariable ['ALF_fishingNet_running', false]) }";

    /* ===================== FILET ===================== */

    // ------------------- Hold-action : Déployer le filet -------------------
    private _holdIdL = [
        _boat,
        "Déployer le filet",
        "\A3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloaddevice_ca.paa",
        "\A3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloaddevice_ca.paa",
        _condLaunch,                             // condition d’affichage
        "driver _target isEqualTo player",       // condition de progression
        {},                                      // onStart
        {},                                      // onProgress
        {
            // onCompleted
            params ["_target","_caller","_actionId","_args"];
            _args params ["_DIST","_totalW","_CFG_INTERVAL","_fnLoopStop","_fnLoopStart","_fnPickWeighted","_CFG_LOOT_MIN","_CFG_LOOT_MAX","_CFG_DEBUG","_CFG_COOLDOWN_S"];

            // Interdiction spécifique bateau
            if (_target isKindOf "VEH_MRP_BM_Yatch") exitWith {
                ["Info","La pêche n'est pas possible avec ce bateau.","danger"] spawn ALF_fnc_doMsg;
            };

            // Sécurité: re-vérif magazine requis
            private _mc = getMagazineCargo _target;
            private _i  = (_mc select 0) find "MRP_Carton_Fillet";
            if !(_i >= 0 && { ((_mc select 1) select _i) > 0 }) exitWith {
                ["Info","Il te faut Filet de pêche dans la soute pour déployer le filet.","danger"] spawn ALF_fnc_doMsg;
            };

            // Vérif fond marin
            private _pASL = getPosASL _target;
            private _pATL = ASLToATL [_pASL#0,_pASL#1, getTerrainHeightASL [_pASL#0, _pASL#1]];
            private _raw = surfaceType _pATL;
            private _norm = toLower _raw;
            if (_norm != "" && { _norm select [0,1] isEqualTo "#" }) then {
                _norm = _norm select [1, (count _norm) - 1];
            };
            private _okSeabed = (_norm find "mrp") >= 0 && { (_norm find "seabed") >= 0 };
            if (_CFG_DEBUG) then { hintSilent format ["[DEBUG] seabed raw=%1 | norm=%2", _raw, _norm]; };
            if (!_okSeabed) exitWith {
                ["Info", "Tu dois être en eau profonde pour lancer le filet.", "danger"] spawn ALF_fnc_doMsg;
            };

            // Démarre un cycle (remontée auto + cooldown gérés dans la boucle)
            call _fnLoopStop;
            [_target,_DIST,_totalW,_CFG_INTERVAL,_fnPickWeighted,_CFG_LOOT_MIN,_CFG_LOOT_MAX,_fnLoopStop,_CFG_COOLDOWN_S] call _fnLoopStart;
            ["Info", "Déploiement du filet. Remontée automatique après le relevé.", "success"] spawn ALF_fnc_doMsg;
        },
        {
            // onInterrupted
            ["Info","Déploiement interrompu.","warning"] spawn ALF_fnc_doMsg;
        },
        [_DIST,_totalW,_CFG_INTERVAL,_fnLoopStop,_fnLoopStart,_fnPickWeighted,_CFG_LOOT_MIN,_CFG_LOOT_MAX,_CFG_DEBUG,_CFG_COOLDOWN_S],
        3,   // durée de maintien
        0,   // priorité
        false, // remove on complete
        false  // show on unconscious
    ] call BIS_fnc_holdActionAdd;
    _boat setVariable ["ALF_net_act_launch", _holdIdL, false];

    // ------------------- Hold-action : Remonter le filet (manuel) -------------------
    private _holdIdR = [
        _boat,
        "Remonter le filet",
        "\A3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloaddevice_ca.paa",
        "\A3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloaddevice_ca.paa",
        _condRetract,
        "driver _target isEqualTo player",
        {}, // onStart
        {}, // onProgress
        {
            // onCompleted (manuel) -> stop + cooldown
            params ["_target","_caller","_actionId","_args"];
            _args params ["_fnLoopStop","_CD"];

            // Interdiction spécifique bateau (au cas où)
            if (_target isKindOf "VEH_MRP_BM_Yatch") exitWith {
                ["Info","La pêche n'est pas possible avec ce bateau.","danger"] spawn ALF_fnc_doMsg;
            };

            _target setVariable ["ALF_net_cd_t", diag_tickTime + _CD, false];
            call _fnLoopStop;
            ["Info","Remontage du filet.","success"] spawn ALF_fnc_doMsg;
        },
        {
            // onInterrupted
            ["Info","Remontage interrompu.","warning"] spawn ALF_fnc_doMsg;
        },
        [_fnLoopStop,_CFG_COOLDOWN_S],
        3,   // durée de maintien
        0,   // priorité
        false, // remove on complete
        false  // show on unconscious
    ] call BIS_fnc_holdActionAdd;
    _boat setVariable ["ALF_net_act_retract", _holdIdR, false];

    /* ===================== ANCRE ===================== */

    private _condAnchorDrop =
        "driver _target isEqualTo player"
        +" && { _target isKindOf 'Ship' }"
        +" && { !(_target getVariable ['ALF_anchor_deployed', false]) }"
        +" && { [_target] call (missionNamespace getVariable 'ALF_fishingNet_fncHasAnchor') }"
        +" && { speed _target < 3 }";  // éviter de jeter l’ancre à pleine vitesse

    private _condAnchorRaise =
        "driver _target isEqualTo player"
        +" && { _target isKindOf 'Ship' }"
        +" && { (_target getVariable ['ALF_anchor_deployed', false]) }";

    // --- Jeter l’ancre (hold) ---
    private _holdIdA1 = [
        _boat,
        "Jeter l’ancre",
        "\A3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reload_ca.paa",
        "\A3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reload_ca.paa",
        _condAnchorDrop,
        "driver _target isEqualTo player",
        { ["Info","Préparation de l’ancre...","info"] spawn ALF_fnc_doMsg; },
        {},
        {
            params ["_target","","","_args"]; _args params ["_fnSetAnchored"];
            [_target,true] call _fnSetAnchored;
        },
        { ["Info","Jet d’ancre interrompu.","warning"] spawn ALF_fnc_doMsg; },
        [_fnSetAnchored],
        2.5, 0, false, false
    ] call BIS_fnc_holdActionAdd;
    _boat setVariable ["ALF_anchor_act_drop", _holdIdA1, false];

    // --- Remonter l’ancre (hold) ---
    private _holdIdA2 = [
        _boat,
        "Remonter l’ancre",
        "\A3\ui_f\data\IGUI\Cfg\holdactions\holdAction_repair_ca.paa",
        "\A3\ui_f\data\IGUI\Cfg\holdactions\holdAction_repair_ca.paa",
        _condAnchorRaise,
        "driver _target isEqualTo player",
        { ["Info","Remontée de l’ancre...","info"] spawn ALF_fnc_doMsg; },
        {},
        {
            params ["_target","","","_args"]; _args params ["_fnSetAnchored"];
            [_target,false] call _fnSetAnchored;
        },
        { ["Info","Remontée interrompue.","warning"] spawn ALF_fnc_doMsg; },
        [_fnSetAnchored],
        2.5, 0, false, false
    ] call BIS_fnc_holdActionAdd;
    _boat setVariable ["ALF_anchor_act_raise", _holdIdA2, false];

    _boat setVariable ["ALF_net_actions_init", true, false];
};

/* =============================================================================
   LOGIQUE PRINCIPALE
   ========================================================================== */

private _veh = [_isStop, _vehFromEH] call _fnGetBoat;
if (isNull _veh) exitWith {};
if (!(_veh isKindOf "Ship")) exitWith {};
if !(driver _veh isEqualTo player) exitWith { ["Info", "Tu dois être le conducteur du bateau.", "danger"] spawn ALF_fnc_doMsg; };

// STOP MODE
if (_isStop) exitWith {
    call _fnLoopStop;
    [_veh] call _fnCleanupActions;
    _veh setVariable ["ALF_net_actions_init", false, false];

    // Sécurité : si ancre restée posée, on libère le bateau
    if (_veh getVariable ["ALF_anchor_deployed", false]) then {
        _veh forceSpeed -1;
        _veh setVariable ["ALF_anchor_deployed", false, false];
    };

    // ------------------- Stop auto: cleanup EH (3) -------------------
    private _ehs = _veh getVariable ["ALF_net_ehs", []];
    {
        _x params ["_type","_owner","_id"];
        switch (_type) do {
            case "vehKilled": { _owner removeEventHandler ["Killed", _id]; };
            case "vehGetOut": { _owner removeEventHandler ["GetOut", _id]; };
            case "plyKilled": { _owner removeEventHandler ["Killed", _id]; };
        };
    } forEach _ehs;
    _veh setVariable ["ALF_net_ehs", nil, false];

    if ((_veh isEqualTo (player getVariable ["ALF_fishingNet_lastBoat", objNull]))) then {
        player setVariable ["ALF_fishingNet_lastBoat", objNull, false];
    };
};

// START MODE
if (_veh getVariable ["ALF_net_actions_init", false]) exitWith {};
player setVariable ["ALF_fishingNet_lastBoat", _veh, false];
[_veh] call _fnCleanupActions;
[_veh] call _fnInitActions;

// ------------------- Stop auto sur événements (3) -------------------
if (isNil { _veh getVariable "ALF_net_ehs" }) then {
    private _ehs = [];

    // Le bateau est détruit
    private _idVKilled = _veh addEventHandler ["Killed", { ["stop", _this#0] spawn ALF_fnc_fishingNet; }];
    _ehs pushBack ["vehKilled", _veh, _idVKilled];

    // Le joueur quitte le siège conducteur
    private _idVGetOut = _veh addEventHandler ["GetOut", {
        params ["_veh", "_pos", "_unit", "_turret"];
        if (_unit isEqualTo player && {_pos isEqualTo "driver"}) then { ["stop", _veh] spawn ALF_fnc_fishingNet; };
    }];
    _ehs pushBack ["vehGetOut", _veh, _idVGetOut];

    // Le joueur meurt
    private _idPKilled = player addEventHandler ["Killed", { ["stop", vehicle player] spawn ALF_fnc_fishingNet; }];
    _ehs pushBack ["plyKilled", player, _idPKilled];

    _veh setVariable ["ALF_net_ehs", _ehs, false];
};
