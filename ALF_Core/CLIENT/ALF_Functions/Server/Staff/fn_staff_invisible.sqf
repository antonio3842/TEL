/*
    File: fn_staff_invisible.sqf
    Author: Matthew

    Description
    Function to activate/deactivate invisibility.
*/

#include "\ALF_Client\script_macros.hpp"

if(alf_admin_invi) then {
    alf_admin_invi = false;
    player setVariable ["admininvisible",false,true];
    [player, false] remoteExecCall ["hideObjectGlobal", 2];
    [name player,getPlayerUID player,"ADMIN","N'est plus invisible"] remoteExec ["ALF_Server_fnc_logIt",2];
} else {
    alf_admin_invi = true;
    player setVariable ["admininvisible",true,true];
    [player, true] remoteExecCall ["hideObjectGlobal", 2];
    [name player,getPlayerUID player,"ADMIN","Est maintenant invisible"] remoteExec ["ALF_Server_fnc_logIt",2];
};
