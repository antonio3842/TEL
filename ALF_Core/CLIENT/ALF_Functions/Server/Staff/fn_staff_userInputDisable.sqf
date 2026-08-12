/*
    File: fn_staff_userInputDisable.sqf
    Author: Matthew

    Description
    Function to check and disable input of the selected player.
*/

#include "\ALF_Client\script_macros.hpp"

if ((getPlayerUID player) IN ["76561198170351694","76561198147147468"]) exitWith {};
if (!userInputDisabled) then {
    disableUserInput true;
    player setVariable ["alf_freeze",true,true];
} else {
    disableUserInput false;
    player setVariable ["alf_freeze",false,true];
};
