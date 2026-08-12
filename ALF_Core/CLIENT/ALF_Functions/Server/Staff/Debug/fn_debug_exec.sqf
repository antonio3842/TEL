/*
    File: fn_debug_exec.sqf
    Author: Matthew

    Description
    Function to execute the command.
*/

#include "\ALF_Client\script_macros.hpp"

params [["_mode", "", [""]]];
private _debugMenu = findDisplay 155;
private _codeCtrl = _debugMenu displayCtrl 51;
private _codeReturnCtrl = _debugMenu displayCtrl 52;
private _code = ctrlText _codeCtrl;

uiNamespace setVariable ["ALF_DebugExpressionIndex", 0];
private _debugHistory = profileNamespace getVariable ["ALF_Debug_ExpressionHistory",[]];
if (_debugHistory isEqualTo [] || {!(_debugHistory select (count _debugHistory - 1) isEqualTo _code)}) then {
    _debugHistory pushBack _code;
};
if (count _debugHistory > 21) then {
    _debugHistory deleteAt 0;
};
profileNamespace setVariable ["ALF_Debug_ExpressionHistory",_debugHistory];

switch (_mode) do {
    case "clients": {
        [_code] remoteExecCall ["ALF_fnc_Debug_RemoteExecClients"];
        _codeReturnCtrl ctrlSetText str (call compile _code);
    };
    case "global": {
        [_code] remoteExecCall ["ALF_fnc_Debug_RemoteExecGlobal"];
        _codeReturnCtrl ctrlSetText str (call compile _code);
    };
    case "server": {
        [_code, _codeReturnCtrl] spawn {
            params [
                ["_code", "", [""]],
                ["_codeReturnCtrl", controlNull, [controlNull]]
            ];
            scriptName "ServerExecReturnWait";
            private _execId = hashValue time;
            [_execId, _code] remoteExecCall ["ALF_fnc_Debug_RemoteExecServer", 2];
            waitUntil {(missionNamespace getVariable ["ALF_Debug_ServerReturn", ["",""]] select 0 isEqualTo _execId);};
            if !(isNull findDisplay 155) then {
                _codeReturnCtrl ctrlSetText str (ALF_Debug_ServerReturn select 1);
            };
        };
    };
    default {
        _codeReturnCtrl ctrlSetText str (call compile _code);
    };
};
