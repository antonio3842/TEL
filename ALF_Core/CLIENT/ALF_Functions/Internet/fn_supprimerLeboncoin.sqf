#include "\ALF_Client\script_macros.hpp"
/*
File: supprimerLeboncoin.sqf
Author: ALF Nanou
*/
disableSerialization;
if((lbCurSel 24532) isEqualTo -1) exitWith {hint "Vous n'avez rien sélectionné."};

private _data = CONTROL_DATA(24532);
_data = call compile format["%1",_data];

private _action = ["Etes-vous certain de vouloir supprimer cette annonce ?","Leboncoin","OUI","NON"] call BIS_fnc_guiMessage;
if (!_action) exitWith {};

closeDialog 0;

[_data select 0,_data select 2,player] remoteExec ["ALF_Server_fnc_supprimerLeboncoin",2];

[name player,getPlayerUID player,"LEBONCOIN",format["vient de supprimer %1 de l'uid %2",_data select 2,_data select 1]] remoteExec ["ALF_Server_fnc_logIt",2];