/*
    File: fn_staff_saveFields.sqf
    Author: Matthew

    Description
    Function to save debug fields when disconnecting.
*/

#include "\ALF_Client\script_macros.hpp"

private _debugMenu = findDisplay 155;
private _watch1Ctrl = _debugMenu displayCtrl 11;
private _watch2Ctrl = _debugMenu displayCtrl 12;
private _watch3Ctrl = _debugMenu displayCtrl 13;
private _codeCtrl = _debugMenu displayCtrl 51;
profileNamespace setVariable ["ALF_Debug_Watch1",ctrlText _watch1Ctrl];
profileNamespace setVariable ["ALF_Debug_Watch2",ctrlText _watch2Ctrl];
profileNamespace setVariable ["ALF_Debug_Watch3",ctrlText _watch3Ctrl];
profileNamespace setVariable ["ALF_Debug_Expression",ctrlText _codeCtrl];
