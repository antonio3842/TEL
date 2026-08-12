/*
    File: fn_staff_teleport_to_me.sqf
    Author: Matthew

    Description
    Function to teleport the selected player.
*/

#include "\ALF_Client\script_macros.hpp"

private _display = findDisplay 98;
private _selectedIndex = lbCurSel 1500;
private _target = ALF_PlayersList select _selectedIndex;

private _target = (ALF_PlayersList#_selectedIndex);
if(vehicle _target isNotEqualTo _target) then {_target action ["GetOut",vehicle _target];};
waitUntil{vehicle _target isEqualTo _target};
_target setPosATL (getPosATL player);

private _playerName = name player;
private _playerUID = getPlayerUID player;
private _targetName = name _target;
private _targetUID = getPlayerUID _target;

[_playerName, _playerUID, "ADMIN", format[
    "%1 (%2) a téléporté %3 (%4) sur sa position.",
    _playerName, _playerUID, _targetName, _targetUID
]] remoteExec ["ALF_Server_fnc_logIt", 2];
