/*
    File: fn_staff_remoteExecGlobal.sqf
    Author: Matthew

    Description
    Function to execute the command globally.
*/

#include "\ALF_Client\script_macros.hpp"

params [["_code", "", [""]]];
diag_log (["ALF: Edaly_Debug_RemoteExecGlobal - Caller:",(ALF_ClientOwnerTable get remoteExecutedOwner),"Code:",(compile _code)] joinString " ");
if (remoteExecutedOwner isEqualTo clientOwner) exitWith {};
call compile _code;
