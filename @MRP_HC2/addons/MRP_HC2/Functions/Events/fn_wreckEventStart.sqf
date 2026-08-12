/*
    File: fn_wreckEventStart.sqf
    Author: ALF Team
    Desc: Event automatique d'epaves
    hc_2 - Events
*/

params [["_mode", false]];

// --- Constantes
private _firstDelaySec    = 60;
private _forceCooldownSec = 60;

// --- State
private _now           = time;
private _nextForce     = missionNamespace getVariable ["ALF_wreckEvent_nextForceAllowed", 0];
private _loopHandle    = missionNamespace getVariable ["ALF_wreckEvent_loopHandle",  scriptNull];
private _loopStarting  = missionNamespace getVariable ["ALF_wreckEvent_loopStarting", false];

// --- Parse _mode -> (_forceNow, _forcePosASL)
private _forceNow = false;
private _forcePosASL = [];

switch (true) do {
    case (_mode isEqualType ""): {
        _forceNow = _mode isEqualTo "force";
    };
    case (_mode isEqualType []): {
        private _a = _mode;
        if ((count _a) isEqualTo 1 && {(_a select 0) isEqualType "" && {(_a select 0) isEqualTo "force"}}) then {
            _forceNow = true;
        } else {
            if ((count _a) isEqualTo 1 && {(_a select 0) isEqualType []}) then { _a = _a select 0; };
            if ((count _a) isEqualTo 3) then { _forcePosASL = _a; };
        };
    };
    default {};
};

// --- Traite "force" / position (avec cooldown)
if (_forceNow || {(count _forcePosASL) isEqualTo 3}) exitWith {
    if (_now < _nextForce) exitWith { true };
    missionNamespace setVariable ["ALF_wreckEvent_nextForceAllowed", _now + _forceCooldownSec];
    // Appeler sur le serveur car wreckSpawn cree des objets
    [_forcePosASL] remoteExecCall ["ALF_Server_fnc_wreckSpawn", 2];
    true
};

// --- Si la boucle tourne deja, ne rien faire
if (!isNull _loopHandle && {!scriptDone _loopHandle}) exitWith { true };

// --- Anti-race
if (_loopStarting) exitWith { true };
missionNamespace setVariable ["ALF_wreckEvent_loopStarting", true];

// --- Cree la boucle planifiee
private _h = [_firstDelaySec] spawn {
    params ["_delay"];
    diag_log format ["[ALF][WRECK-HC2] Loop starting (first spawn in %1s).", _delay];

    uiSleep _delay;
    // Appeler sur le serveur
    [] remoteExecCall ["ALF_Server_fnc_wreckSpawn", 2];

    // Boucle horaire
    while {true} do {
        uiSleep 3600;
        [] remoteExecCall ["ALF_Server_fnc_wreckSpawn", 2];
    };
};

// --- Enregistre le handle
missionNamespace setVariable ["ALF_wreckEvent_loopHandle", _h];
missionNamespace setVariable ["ALF_wreckEvent_loopStarting", false];
true
