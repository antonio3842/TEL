/*
	File: fn_staff_revive.sqf
	Author: Matthew

	Description
	Function to revive the selected player.
*/
#include "\ALF_Client\script_macros.hpp"

private _selectedIndex = lbCurSel 1500;
private _target = (ALF_PlayersList#_selectedIndex);
[] remoteExec ["ALF_fnc_adminRevived",_target];
