/*
    File: fn_debug_open.sqf
    Author: Matthew

    Description
    Function to open the debug.
*/

#include "\ALF_Client\script_macros.hpp"

if (ALF_AdminLevel <= 3) exitWith {};

disableSerialization;
createDialog "ALF_Debug_Dialog";

(findDisplay 155) displayAddEventHandler ["Unload","profileNamespace setVariable ['ALF_Debug_Main',ctrlText 1400]"];
ctrlSetText [1400,profileNamespace getVariable ["ALF_Debug_Main","Il n'y a rien pour le moment"]];
