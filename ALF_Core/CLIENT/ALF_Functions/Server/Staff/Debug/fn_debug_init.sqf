/*
    File: fn_debug_init.sqf
    Author: Matthew

    Description
    Function to initialize the debug.
*/

#include "\ALF_Client\script_macros.hpp"

[] spawn {
    scriptName "ALF_DebugInfoLoop";
    private _debugMenu = findDisplay 155;
    private _infoCtrl = _debugMenu displayCtrl 34;
    while {!(isNull findDisplay 155)} do {
        _infoCtrl ctrlSetStructuredText parseText format ["
            <t size='0.7' color='#a6a6a6'>FPS: </t><t size='0.7'>%1</t><br/>
            <t size='0.7' color='#a6a6a6'>serverTime: </t><t size='0.7'>%2</t><br/>
            <t size='0.7' color='#a6a6a6'>ActiveScripts: </t><t size='0.7'>%4</t><br/>
            <t size='0.7' color='#a6a6a6'>ResLods: </t><t size='0.7'>%5</t><br/>
            <t size='0.7' color='#a6a6a6'>getCursorObjectParams: </t><t size='0.7'>%6</t><br/>
            <t size='0.7' color='#a6a6a6'>typeOf Target: </t><t size='0.7'>%7</t><br/>
            <t size='0.7' color='#a6a6a6'>Target: </t><t size='0.7'>%3</t><br/>
            <t size='0.7' color='#a6a6a6'>worldToModel Player Pos: </t><t size='0.7'>%8</t><br/>
            ",
            round diag_fps,
            round serverTime,
            getModelInfo cursorObject,
            diag_activeScripts,
            {_x select 1 in "0123456789"} count (allLODs ((getModelInfo cursorObject) select 1)),
            getCursorObjectParams,
            typeOf cursorObject,
            cursorObject worldToModel ((getPosATL player))
        ];
        uiSleep 0.15;
    };
};

[] spawn {
    scriptName "ALF_DebugWatchLoop";
    private _debugMenu = findDisplay 155;
    private _watch1Ctrl = _debugMenu displayCtrl 11;
    private _watch2Ctrl = _debugMenu displayCtrl 12;
    private _watch3Ctrl = _debugMenu displayCtrl 13;
    private _watch1ReturnCtrl = _debugMenu displayCtrl 21;
    private _watch2ReturnCtrl = _debugMenu displayCtrl 22;
    private _watch3ReturnCtrl = _debugMenu displayCtrl 23;
    private _codeCtrl = _debugMenu displayCtrl 51;

    _watch1Ctrl ctrlSetText (profileNamespace getVariable ["ALF_Debug_Watch1", ""]);
    _watch2Ctrl ctrlSetText (profileNamespace getVariable ["ALF_Debug_Watch2", ""]);
    _watch3Ctrl ctrlSetText (profileNamespace getVariable ["ALF_Debug_Watch3", ""]);
    _codeCtrl ctrlSetText (profileNamespace getVariable ["ALF_Debug_Expression", ""]);

    while {!(isNull findDisplay 155)} do {
        if (ctrlText _watch1Ctrl isEqualTo "") then {
            _watch1ReturnCtrl ctrlSetText ""
        } else {
            _watch1ReturnCtrl ctrlSetText str (call compile (ctrlText _watch1Ctrl));
        };
        if (ctrlText _watch2Ctrl isEqualTo "") then {
            _watch2ReturnCtrl ctrlSetText ""
        } else {
            _watch2ReturnCtrl ctrlSetText str (call compile (ctrlText _watch2Ctrl));
        };
        if (ctrlText _watch3Ctrl isEqualTo "") then {
            _watch3ReturnCtrl ctrlSetText ""
        } else {
            _watch3ReturnCtrl ctrlSetText str (call compile (ctrlText _watch3Ctrl));
        };
        uiSleep 0.01;
    };
};

private _debugMenu = findDisplay 155;
private _clearCtrl = _debugMenu displayCtrl 160;
private _prevCtrl = _debugMenu displayCtrl 141;
private _nextCtrl = _debugMenu displayCtrl 142;
private _watch1Ctrl = _debugMenu displayCtrl 11;
private _watch2Ctrl = _debugMenu displayCtrl 12;
private _watch3Ctrl = _debugMenu displayCtrl 13;
private _codeCtrl = _debugMenu displayCtrl 51;

uiNamespace setVariable ["ALF_DebugExpressionIndex", -1];
call ALF_fnc_Debug_UpdateHistoryButtons;

_codeCtrl ctrlAddEventHandler ["KeyDown", {call ALF_fnc_Debug_SaveFields}];
_watch1Ctrl ctrlAddEventHandler ["KeyDown", {call ALF_fnc_Debug_SaveFields}];
_watch2Ctrl ctrlAddEventHandler ["KeyDown", {call ALF_fnc_Debug_SaveFields}];
_watch3Ctrl ctrlAddEventHandler ["KeyDown", {call ALF_fnc_Debug_SaveFields}];

_clearCtrl ctrlAddEventHandler ["ButtonClick", {
    ((findDisplay 155) displayCtrl 51) ctrlSetText "";
    uiNamespace setVariable ["ALF_DebugExpressionIndex", 0];
}];

_prevCtrl ctrlAddEventHandler ["ButtonClick", {
    private _debugMenu = findDisplay 155;
    private _codeCtrl = _debugMenu displayCtrl 51;
    private _debugHistory = ([] + (profileNamespace getVariable ["ALF_Debug_ExpressionHistory",[]]));
    private _curIndex = uiNamespace getVariable ["ALF_DebugExpressionIndex", 0];
    if (_curIndex > (count _debugHistory - 1)) exitWith {
        reverse _debugHistory;
        _codeCtrl ctrlSetText (_debugHistory select _curIndex);
    };

    _curIndex = _curIndex + 1;
    reverse _debugHistory;
    _codeCtrl ctrlSetText (_debugHistory select _curIndex);

    if (_curIndex == count _debugHistory) then {
        _curIndex = _curIndex - 1;
    };

    uiNamespace setVariable ["ALF_DebugExpressionIndex", _curIndex];
    call ALF_fnc_Debug_UpdateHistoryButtons;
}];

_nextCtrl ctrlAddEventHandler ["ButtonClick", {
    private _debugMenu = findDisplay 155;
    private _codeCtrl = _debugMenu displayCtrl 51;
    private _debugHistory = ([] + (profileNamespace getVariable ["ALF_Debug_ExpressionHistory",[]]));
    private _curIndex = uiNamespace getVariable ["ALF_DebugExpressionIndex", 0];
    if (_curIndex == 0) exitWith {};
    _curIndex = _curIndex - 1;
    uiNamespace setVariable ["ALF_DebugExpressionIndex", _curIndex];

    reverse _debugHistory;
    _codeCtrl ctrlSetText (_debugHistory select _curIndex);
    call ALF_fnc_Debug_UpdateHistoryButtons;
}];
