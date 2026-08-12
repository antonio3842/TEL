/*
    File: fn_staff_updateHistoryButtons.sqf
    Author: Matthew

    Description
    Function to get previous commands used in the debug (saved after disconnection).
*/

#include "\ALF_Client\script_macros.hpp"

private _prevCtrl = _debugMenu displayCtrl 141;
private _nextCtrl = _debugMenu displayCtrl 142;
private _countHistory = count ([] + (profileNamespace getVariable ["ALF_Debug_ExpressionHistory",[]]));
private _index = uiNamespace getVariable ["ALF_DebugExpressionIndex", 0];
if (_index <= 0) then {
    _nextCtrl ctrlEnable false;
} else {
    _nextCtrl ctrlEnable true;
};
if (_index >= (_countHistory - 1)) then {
    _prevCtrl ctrlEnable false;
} else {
    _prevCtrl ctrlEnable true;
};
(_debugMenu displayCtrl 52) ctrlSetText str _index;
