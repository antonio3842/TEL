/*
    File: fn_staff_freeze.sqf
    Author: Matthew

    Description
    Function to Freeze the selected player.
*/

#include "\ALF_Client\script_macros.hpp"

private _display = findDisplay 98;
private _control = _display displayCtrl 1018;
private _selectedIndex = lbCurSel 1500;
private _selectedPlayer = (ALF_PlayersList#_selectedIndex);
if(_selectedPlayer isEqualTo player) exitWith {};
[] remoteExec ["ALF_fnc_staff_userInputDisable",_selectedPlayer];
if(_selectedPlayer getVariable ["alf_freeze",false]) then {
    _control ctrlSetTextColor [0.90588235294,0.49411764705,0.14901960784,1];
} else {
    _control ctrlSetTextColor [1,1,1,1];
};
