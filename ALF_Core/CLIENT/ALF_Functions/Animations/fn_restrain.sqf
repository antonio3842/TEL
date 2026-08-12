#include "\ALF_Client\script_macros.hpp"
/*
    File: fn_restrain.sqf
    Author: Bryan "Tonic" Boardwine
    Description:
    Restrains the client.
*/
params 
[
	["_cop",objNull,[objNull]]
];
if (isNull _cop) exitWith {};

private _player = player;
private _vehicle = vehicle player;

["INFO", "Vous êtes menotté.", "warning"] spawn ALF_fnc_doMsg;

life_disable_getIn = true;
life_disable_getOut = false;

player playActionNow "ALF_Menotter";
player forceWalk true;
player setVariable ["tf_unable_to_use_radio",true];

_array = player getVariable ["ALF_MenotterSurrender",[false,false]];
_array set [0,true];
if (_array select 1) then {_array set [1,false];};
player setVariable ["ALF_MenotterSurrender",_array,true];

uiSleep 1;

while {[player] call ALF_fnc_checkMenotter} do 
{
    if (isNull objectParent player) then {player playActionNow "ALF_Menotter";};
    if !(isForcedWalk player) then {player forceWalk true;};

    _state = vehicle player;
    waitUntil 
    {
        if (currentWeapon player isnotequalto "") then 
        {
            life_curWep_h = currentWeapon player;
            player action ["SwitchWeapon", player, player, 100];
            player switchCamera cameraView;
            player playActionNow "ALF_Menotter";
        };
        player playActionNow "ALF_Menotter";
        !([player] call ALF_fnc_checkMenotter) OR {vehicle player isnotequalto _state} OR {!isForcedWalk player}
    };

    if !(alive player) exitWith {player playActionNow "gestureNod";};
    if !(alive _cop) then {player playActionNow "gestureNod";};

    if (vehicle player != player AND {(driver vehicle player) isEqualTo player}) then 
    {
		unassignVehicle player;
		player action ["getOut", vehicle player];
	};

    if (!(isNull objectParent player) AND !(vehicle player isEqualTo _vehicle)) then {_vehicle = vehicle player;};
};

if (alive player) then {player playActionNow "gestureNod";};
[] spawn 
{
    sleep 1;
    player forceWalk false;
};
