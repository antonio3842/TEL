/*
    File: fn_staff_noclip.sqf
    Author: Matthew

    Description
    Function to activate/deactivate noClip.
*/

#include "\ALF_Client\script_macros.hpp"

private["_config", "_keyForward", "_keyLeft", "_keyBackward", "_keyRight", "_keyUp", "_keyDown"];

ALF_fnc_fly_forward =
{
    if ((vehicle player) isKindOf "Man") then
    {
        _vel = velocity player;
        _dir = direction player;
        player setVelocity [(_vel select 0) + (sin _dir * 0.4), (_vel select 1) + (cos _dir * 0.4), 0.4];
    };
};

ALF_fnc_fly_left =
{
    if ((vehicle player) isKindOf "Man") then
    {
        player setdir ((getdir player) - 2);
    };
};

ALF_fnc_fly_right =
{
    if ((vehicle player) isKindOf "Man") then
    {
        player setdir ((getdir player) + 2);
    };
};

ALF_fnc_fly_backward =
{
    if ((vehicle player) isKindOf "Man") then
    {
        _vel = velocity player;
        _dir = direction player;
        player setVelocity [(_vel select 0) - (sin _dir * 0.4), (_vel select 1) - (cos _dir * 0.4), 0.4];
    };
};

ALF_fnc_fly_up =
{
    if ((vehicle player) isKindOf "Man") then
    {
        _vel = velocity player;
        player setVelocity [(_vel select 0), (_vel select 1), 6];
    };
};

ALF_fnc_fly_down =
{
    if ((vehicle player) isKindOf "Man") then
    {
        player setVelocity [0,0,-4];
    };
};

if !("ItemMap" in (assignedItems player)) then
{
    if ((uniform player) isEqualTo "") then {player forceAddUniform "U_C_Man_casual_4_F";};
    player addItem "ItemMap";
    player assignItem "ItemMap";
};

if (alf_admin_on) then 
{
    alf_admin_btn = false;
    player allowDamage true;
    alf_admin_on = false;
    [player, false] remoteExecCall ["hideObjectGlobal", 2];
    onMapSingleClick "";
    // if ((player getVariable ["tf_voiceVolume", 0]) isEqualTo 0) then {
    //     player setVariable ["tf_voiceVolume", 1, true];
    // };
    (findDisplay 46) displayRemoveEventHandler ["KeyDown", keyForward];
    (findDisplay 46) displayRemoveEventHandler ["KeyDown", keyLeft];
    (findDisplay 46) displayRemoveEventHandler ["KeyDown", keyBackward];
    (findDisplay 46) displayRemoveEventHandler ["KeyDown", keyRight];
    (findDisplay 46) displayRemoveEventHandler ["KeyDown", keyUp];
    (findDisplay 46) displayRemoveEventHandler ["KeyDown", keyDown];
} else 
{
    keyForward = (findDisplay 46) displayAddEventHandler ["KeyDown","if ((_this select 1) in (actionKeys 'MoveForward')) then {call ALF_fnc_fly_forward}"];
    keyLeft = (findDisplay 46) displayAddEventHandler ["KeyDown","if ((_this select 1) in (actionKeys 'MoveLeft')) then {call ALF_fnc_fly_left}"];
    keyBackward = (findDisplay 46) displayAddEventHandler ["KeyDown","if ((_this select 1) in (actionKeys 'MoveBack')) then {call ALF_fnc_fly_backward}"];
    keyRight = (findDisplay 46) displayAddEventHandler ["KeyDown","if ((_this select 1) in (actionKeys 'MoveRight')) then {call ALF_fnc_fly_right}"];
    keyUp = (findDisplay 46) displayAddEventHandler ["KeyDown","if ((_this select 1) in (actionKeys 'MoveUp')) then {call ALF_fnc_fly_up}"];
    keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown","if ((_this select 1) in (actionKeys 'MoveDown')) then {call ALF_fnc_fly_down}"];
    alf_admin_on = true;
    player allowDamage false;
    alf_admin_btn = true;
    [player, true] remoteExecCall ["hideObjectGlobal", 2];
    onMapSingleClick "(vehicle player) setPos _pos";
    // if ((player getVariable ["tf_voiceVolume", 0]) > 0) then {
    //     player setVariable ["tf_voiceVolume", 0, true];
    // };
};

while {alf_admin_on} do
{
    _eventHandler = addMissionEventHandler ["Draw3D",

    {
        {
            if (!(isNull _x) && (isPlayer _x) && (_x != player) && ((player distance _x) <= 300)) then
            {
                drawIcon3D [
                    "\a3\ui_f\data\Map\Diary\Icons\unitPlayable_ca.paa",
                    [side _x, false] call BIS_fnc_sideColor,
                    _x modelToWorld [0, 0.1, 2.1],
                    0,
                    0,
                    0,
                    _x getVariable "realname",
                    2,
                    0.04,
                    "PuristaMedium",
                    "center",
                    false
                ];
            };
        } forEach allPlayers;
    }];

    _currentPlayerCount = count allPlayers;
    waitUntil {((_currentPlayerCount != (count allPlayers)) || !alf_admin_on)};

    removeMissionEventHandler ["Draw3D", _eventHandler];

    uiSleep 1;
};
