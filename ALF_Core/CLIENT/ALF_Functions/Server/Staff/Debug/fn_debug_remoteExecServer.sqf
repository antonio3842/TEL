/*
    File: fn_staff_remoteExecServer.sqf
    Author: Matthew

    Description
    Function to execute the command on the server side.
*/

#include "\ALF_Client\script_macros.hpp"

params [
    ["_execId", "", [""]],
    ["_code", "", [""]]
];
diag_log (["ALF: Edaly_Debug_RemoteExecServer - Caller:",(ALF_ClientOwnerTable get remoteExecutedOwner),"Code:",(compile _code)] joinString " ");
ALF_Debug_ServerReturn = [_execId, call compile _code];
remoteExecutedOwner publicVariableClient "ALF_Debug_ServerReturn";
