/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
params["_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt"];

// Admin Menu - F1
if (_dikCode isEqualTo 59) exitWith {
    if (ALF_AdminLevel > 1) exitWith {
        call ALF_fnc_staff_open;
    };
};

// Admin Cursor - F2
if (_dikCode isEqualTo 60) exitWith {
    if (ALF_AdminLevel > 1) then {
        if (ALF_CursorTargetEnabled) then {
            ALF_CursorTargetEnabled = false;
        } else {
            [] spawn ALF_fnc_cursor_cursorTarget;
        };
    };
};

// Spectate - F3
if (_dikCode isEqualTo 61) exitWith {
    if (ALF_AdminLevel > 1) then {
        disableSerialization;
        ["Initialize", [player, [], false, true, true, false, true, true, true, true]] call BIS_fnc_EGSpectator;
        ALF_MapTeleportReady = false;
        [] spawn {
            waitUntil {!isNull findDisplay 49};
            ["Terminate"] call BIS_fnc_EGSpectator;
            (findDisplay 49) closeDisplay 1;
            waitUntil {isNull findDisplay 49};
        };
    };
};

// Debug console - F4
if (_dikCode isEqualTo 62) exitWith {
    if (ALF_AdminLevel > 2) exitWith {
        call ALF_fnc_debug_Open;
    };
};

// Admin Cursor EVH

if ((_dikCode isEqualTo 82) && ALF_CursorTargetEnabled && (ALF_AdminLevel > 1)) exitWith {
    cursorTarget lock false;
    player action["GetInDriver",cursorTarget];
    cursorTarget lock true;
};
if ((_dikCode isEqualTo 79) && ALF_CursorTargetEnabled && (ALF_AdminLevel > 1)) exitWith {
    [cursorTarget] spawn ALF_fnc_cursor_attachTo;
};
if ((_dikCode isEqualTo 80) && ALF_CursorTargetEnabled && (ALF_AdminLevel > 1)) exitWith {
    {detach _x;} forEach attachedObjects player;
};
if ((_dikCode isEqualTo 81) && ALF_CursorTargetEnabled && (ALF_AdminLevel > 1)) exitWith {
    [cursorObject,player] remoteExec ["ALF_Server_fnc_putInFourriere",2];
};
if ((_dikCode isEqualTo 75) && ALF_CursorTargetEnabled && (ALF_AdminLevel > 1)) exitWith {
    if ((vehicle player) isEqualTo player) then {
        {deleteVehicle _x;} foreach (attachedObjects cursorTarget);
        deleteVehicle cursorTarget;
    } else {
        {deleteVehicle _x;} foreach (attachedObjects vehicle player);
        deleteVehicle vehicle player;
    };
};
if ((_dikCode isEqualTo 76) && ALF_CursorTargetEnabled && (ALF_AdminLevel > 1)) exitWith {
    cursorTarget lock false;
    player action ["GetInCargo", cursorTarget];
    cursorTarget lock true;
};
if ((_dikCode isEqualTo 77) && ALF_CursorTargetEnabled && (ALF_AdminLevel > 1)) exitWith {
    if ((vehicle player) isEqualTo player) then {
        private _car = cursorTarget;
        private _pass = crew _car;
        {_x action ["getOut", _car];} foreach _pass;
    } else {
        private _car = vehicle player;
        private _pass = crew _car;
        {_x action ["getOut", _car];} foreach _pass;
    };
};
if ((_dikCode isEqualTo 71) && ALF_CursorTargetEnabled && (ALF_AdminLevel > 1)) exitWith {
    _target = cursorObject;
    _target setDamage 0;
};
if ((_dikCode isEqualTo 72) && ALF_CursorTargetEnabled && (ALF_AdminLevel > 1)) exitWith {
    if ((vehicle player) isEqualTo player) then {
        cursorTarget setdamage 0;
    } else {
        vehicle player setdamage 0;
    };
};
if ((_dikCode isEqualTo 73) && ALF_CursorTargetEnabled && (ALF_AdminLevel > 1)) exitWith {
    if ((vehicle player) isEqualTo player) then {
        cursorTarget setFuel 1;
    } else {
        vehicle player setFuel 1;
    };
};
