#include "\ALF_Client\script_macros.hpp"
/*
File: fn_cnpmRetirer.sqf
Author: ALF Team
*/
if((time - life_action_delay) < 10) exitWith {["INFO","Vous ne pouvez retirer que toute les 10 secondes.","warning"] spawn ALF_fnc_doMsg;};
life_action_delay = time;

private _num = ctrlText 17503;
if !([_num] call TON_fnc_isnumber) exitWith {};
_num = parseNumber(_num);
if(_num < 1) exitWith {["INFO","Numéro invalide.","warning"] spawn ALF_fnc_doMsg;};
private _value = missionNamespace getVariable ["CNPM",0];

if(_value < _num) exitWith {["INFO","Il n'y a pas assez dans les caisses.","warning"] spawn ALF_fnc_doMsg;};

_value = _value - _num;
life_cash = life_cash + _num;
[0] call SOCK_fnc_updatePartial;

missionNamespace setVariable ["CNPM",_value,true];
[] call ALF_fnc_cnpmMenu;

private _name = name player;
private _uid = getPlayerUID player;

//Lance la notification chez les Pénits.
["Caisse nationale.",format["%1 a retiré %2€ de la caisse nationale des Pénitanciers.",_name,[_num] call ALF_fnc_numberText], "success"] remoteExecCall ["ALF_Server_fnc_doPenitCall",2];

[_uid,_name,_num] remoteExec ["ALF_Server_fnc_retirerCNPM",2];
