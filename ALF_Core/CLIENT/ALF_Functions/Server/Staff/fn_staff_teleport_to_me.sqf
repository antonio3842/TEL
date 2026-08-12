/*
    File: fn_staff_teleport_to.sqf
    Author: Matthew

    Description
    Function to teleport to the selected player.
*/

#include "\ALF_Client\script_macros.hpp"

/*
Base

private _display = findDisplay 98;
private _selectedIndex = lbCurSel 1500;
private _target = (ALF_PlayersList#_selectedIndex);
if(vehicle _target isEqualTo _target) then {
    player setPosATL (getPosATL _target);
} else {
    private _veh = vehicle _target;
    private _value = getNumber (configFile >> "CfgVehicles" >> typeOf _veh >> "transportSoldier");
    private _freeseats = count (fullCrew _veh);
    if (_freeseats >= _value) exitwith {
        player setPosATL (getPosATL _target);
    };
    player moveInAny _veh;
};
*/


private _display = findDisplay 98;
private _selectedIndex = lbCurSel 1500;

if (_selectedIndex < 0) exitWith { systemChat "[ADMIN] Aucun joueur sélectionné"; };

private _target = ALF_PlayersList select _selectedIndex;
if (isNull _target) exitWith { systemChat "[ADMIN] Cible invalide"; };

private _playerName = name player;
private _playerUID = getPlayerUID player;
private _targetName = name _target;
private _targetUID = getPlayerUID _target;

[_playerName, _playerUID, "ADMIN", format[
    "%1 (%2) s'est téléporté vers %3 (%4) en [%5].",
    _playerName, _playerUID,
    _targetName, _targetUID,
    str getPosATL _target
]] remoteExec ["ALF_Server_fnc_logIt", 2];

if (vehicle _target isEqualTo _target) then {
    player setPosATL getPosATL _target;
} else {
    private _veh = vehicle _target;
    private _capacity = getNumber (configFile >> "CfgVehicles" >> typeOf _veh >> "transportSoldier");
    private _currentCrew = { !isNull (_x select 0) } count fullCrew [_veh, "", true];

    if (_currentCrew >= _capacity) then {
        player setPosATL getPosATL _target;
    } else {
        player moveInAny _veh;
    };
};
