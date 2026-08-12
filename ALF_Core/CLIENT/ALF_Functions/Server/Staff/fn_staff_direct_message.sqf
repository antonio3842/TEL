/*
    File: fn_staff_direct_message.sqf
    Author: Matthew

    Description
    Function to send a direct message to a player.
*/

#include "\ALF_Client\script_macros.hpp"

private _message = ctrlText 1402;
private _selectedIndex = lbCurSel 1500;
private _target = (ALF_PlayersList#_selectedIndex);
private _thisAdmin = name player;
if(_message isEqualTo "") exitWith {["Erreur","Veuillez entrer un message","danger"] spawn ALF_fnc_doMsg};
[format["Message Admin de %1:",_thisAdmin],_message,"warning"] remoteExec ["ALF_fnc_doMsg",_target];
