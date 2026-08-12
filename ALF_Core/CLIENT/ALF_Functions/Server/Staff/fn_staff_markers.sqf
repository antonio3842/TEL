/*
    File: fn_staff_markers.sqf
    Author: Matthew

    Description
    Function to show every markers on the map.
*/

#include "\ALF_Client\script_macros.hpp"

if (alf_admin_btn) then {
    alf_admin_btn = false;
    player setVariable ["adminmarker",false,true];
    [name player,getPlayerUID player,"ADMIN","A désactivé le MapAdmin"] remoteExec ["ALF_Server_fnc_logIt",2];
} else {
    alf_admin_btn = true;
    player setVariable ["adminmarker",true,true];
    [name player,getPlayerUID player,"ADMIN","A activé le MapAdmin"] remoteExec ["ALF_Server_fnc_logIt",2];
};
