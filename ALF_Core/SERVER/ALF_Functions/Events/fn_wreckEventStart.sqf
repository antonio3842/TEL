#include "\ALF_Core\SERVER\script_macros.hpp"
/*
    ALF_Server_fnc_wreckEventStart (SERVER ONLY)
    - Démarre une boucle horaire unique (idempotent).
    - "force" ou une position [x,y,z] déclenchent un spawn immédiat, avec cooldown.
    Usages:
      [] spawn ALF_Server_fnc_wreckEventStart;
      "force" call ALF_Server_fnc_wreckEventStart;
      [798.311,4594.279,0.50] call ALF_Server_fnc_wreckEventStart;
      [[798.311,4594.279,0.50]] call ALF_Server_fnc_wreckEventStart;
*/
if (!isServer) exitWith {false};
params [["_mode", false]];

// --- Constantes
private _firstDelaySec    = 60;   // délai avant 1er spawn auto
private _forceCooldownSec = 60;   // anti-spam pour "force"/pos

// --- State (server-only via missionNamespace, non diffusé)
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

// --- Traite "force" / position (avec cooldown, silencieux si refusé)
if (_forceNow || {(count _forcePosASL) isEqualTo 3}) exitWith {
    if (_now < _nextForce) exitWith {
        // Silencieux pour éviter le spam de logs
        true
    };
    missionNamespace setVariable ["ALF_wreckEvent_nextForceAllowed", _now + _forceCooldownSec];
    // Spawn ciblé si pos fournie, sinon spawn standard
    [_forcePosASL] call ALF_Server_fnc_wreckSpawn;
    true
};

// --- Si la boucle tourne déjà, ne rien faire (idempotent + silencieux)
if (!isNull _loopHandle && {!scriptDone _loopHandle}) exitWith { true };

// --- Anti-race si start spammé à la même frame
if (_loopStarting) exitWith { true };
missionNamespace setVariable ["ALF_wreckEvent_loopStarting", true];

// --- Crée la boucle planifiée
private _h = [_firstDelaySec] spawn {
    params ["_delay"];
    diag_log format ["[ALF][WRECK] Loop starting (first spawn in %1s).", _delay];

    uiSleep _delay;
    [] call ALF_Server_fnc_wreckSpawn;

    // Boucle horaire
    while {true} do {
        uiSleep 3600; // 1 h
        [] call ALF_Server_fnc_wreckSpawn;
    };
};

// --- Enregistre le handle (local serveur, non diffusé)
missionNamespace setVariable ["ALF_wreckEvent_loopHandle", _h];
missionNamespace setVariable ["ALF_wreckEvent_loopStarting", false];
true
