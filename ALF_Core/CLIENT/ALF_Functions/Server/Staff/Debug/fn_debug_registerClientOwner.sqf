/*
    File: fn_staff_registerClientOwner.sqf
    Author: Matthew

    Description
    Function to register the client owner in the ALF_ClientOwnerTable variable.
*/

#include "\ALF_Client\script_macros.hpp"

params [
    ["_machineID", 0, [0]],
    ["_uid", "", [""]]
];
if !(isRemoteExecuted) exitWith {};
if (isNil "ALF_ClientOwnerTable") then {
    ALF_ClientOwnerTable = createHashMapFromArray [[_machineID,_uid]];
} else {
    ALF_ClientOwnerTable set [_machineID,_uid];
};
publicVariable "ALF_ClientOwnerTable";
