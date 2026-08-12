/*
    File: fn_staff_global_message.sqf
    Author: Matthew

    Description
    Function to send a global message to every players.
*/

#include "\ALF_Client\script_macros.hpp"

private _message = ctrlText 1402;
if(_message isEqualTo "") exitWith {["Erreur","Veuillez entrer un message","danger"] spawn ALF_fnc_doMsg};
["Message Global",format["%1",_message],"warning"] remoteExec ["ALF_fnc_doMsg",-2];
