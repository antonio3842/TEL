/*
    File: fn_staff_remoteExecClients.sqf
    Author: Matthew

    Description
    Function to execute the command to every clients.
*/

#include "\ALF_Client\script_macros.hpp"

params [["_code", "", [""]]];
diag_log (["ALF: ALF_Debug_RemoteExecClients - Caller:",(ALF_ClientOwnerTable get remoteExecutedOwner),"Code:",(compile _code)] joinString " ");
if (isServer || (remoteExecutedOwner isEqualTo clientOwner)) exitWith {};
call compile _code;
