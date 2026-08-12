private _target       = param [0, objNull];
private _items_entree = param [1, []];
private _items_sortie = param [2, []];
private _times_craft  = param [3, 10];

if (isNull _target) exitWith {
    ["Info", "La machine est défaillante.", "warning"] spawn ALF_fnc_doMsg;
};

/* === Anti double-exécution côté client (verrou objet, répliqué) === */
private _lockTimeout = 60; // Délai d'expiration du verrou en secondes (si joueur déconnecte)

// Vérifier si le verrou existe et s'il est expiré
private _locked = _target getVariable ["ALF_craft_busy", false];
if (_locked) then {
    private _lockTimestamp = _target getVariable ["ALF_craft_timestamp", 0];
    private _timeElapsed = diag_tickTime - _lockTimestamp;
    
    // Si le verrou est trop ancien (> 60s), le considérer comme orphelin et le libérer
    if (_timeElapsed > _lockTimeout) then {
        _target setVariable ["ALF_craft_busy", false, true];
        _target setVariable ["ALF_craft_timestamp", nil, true];
        // Verrou expiré libéré, on peut continuer
    } else {
        // Verrou actif et valide, on bloque l'accès
        ["Info", "Cette machine est déjà en cours d'utilisation.", "warning"] spawn ALF_fnc_doMsg;
    };
};

// Si le verrou est toujours actif après vérification, on sort
if (_target getVariable ["ALF_craft_busy", false]) exitWith {};

// Activer le verrou avec timestamp
_target setVariable ["ALF_craft_busy", true, true];
_target setVariable ["ALF_craft_timestamp", diag_tickTime, true];

/* Sécu : si l'objet disparaît, on libère le verrou */
private _ehDeleted = _target addEventHandler ["Deleted", {
    params ["_ent"];
    _ent setVariable ["ALF_craft_busy", false, true];
    _ent setVariable ["ALF_craft_timestamp", nil, true];
}];

private _reprise = false;

private _unlock = {
    params ["_obj","_ehId"];
    if (!isNull _obj) then {
        _obj removeEventHandler ["Deleted", _ehId];
        _obj setVariable ["ALF_craft_busy", false, true]; // OFF (public)
        _obj setVariable ["ALF_craft_timestamp", nil, true]; // Supprimer le timestamp
    };
};

waitUntil {
    private _cargo   = magazineCargo _target;
    private _classes = _cargo # 0;
    private _counts  = _cargo # 1;

    private _exit = false;
    {
        private _cls = toLowerAnsi (_x # 0);
        private _qty = _x # 1;
        private _countok = (count (_cargo select {toLowerAnsi _x isEqualTo _cls})) >= _qty;
        if (!(_cls in toLowerAnsi str _cargo) or {!_countok}) exitWith { _exit = true; };
    } forEach _items_entree;

    if (_exit) exitWith {
        if !(_reprise) then { ["Info", "Ressource manquante.", "danger"] spawn ALF_fnc_doMsg; };
        true
    };

    {
        _x params ["_classIn","_qtyIn"];
        _target addMagazineCargoGlobal [_classIn, -_qtyIn];
    } forEach _items_entree;

    if !(_reprise) then {
        _reprise = true;
        ["Info", format ["Traitement en cours... (%1 s)", _times_craft], "info"] spawn ALF_fnc_doMsg;
    };

    sleep _times_craft;

    {
        _x params ["_classOut","_qtyOut"];
        _target addMagazineCargoGlobal [_classOut, _qtyOut];
    } forEach _items_sortie;

    false
};

if (_reprise) then {
    ["Info", "Traitement fini.", "success"] spawn ALF_fnc_doMsg;
};

/* Libération du verrou, quoi qu’il arrive */
[_target, _ehDeleted] call _unlock;
