#include "\ALF_Client\script_macros.hpp"
/*
File: fn_cngDeposer.sqf
Author: ALF Team
*/
if((time - life_action_delay) < 10) exitWith {["INFO","Vous ne pouvez deposer que toute les 10 secondes.","warning"] spawn ALF_fnc_doMsg;};
life_action_delay = time;

private _num = ctrlText 16503;
if !([_num] call TON_fnc_isnumber) exitWith {};
_num = parseNumber(_num);
if(_num < 1) exitWith {["INFO","Numéro invalide.","warning"] spawn ALF_fnc_doMsg;};
private _value = missionNamespace getVariable ["CNG",0];

if(life_cash < _num) exitWith {["INFO","Vous n'avez pas assez d'argent sur vous.","warning"] spawn ALF_fnc_doMsg;};

_value = _value + _num;
life_cash = life_cash - _num;
[0] call SOCK_fnc_updatePartial;

missionNamespace setVariable ["CNG",_value,true];
[] call ALF_fnc_cngMenu;

private _name = name player;
private _uid = getPlayerUID player;

//Lance la notification chez les Gendarmes.
["Caisse nationale.",format["%1 a déposé %2€ dans la caisse nationale de la Gendarmerie.",_name,[_num] call ALF_fnc_numberText]] remoteExecCall ["ALF_Server_fnc_doCopCall",2];

[] remoteExec ["ALF_Server_fnc_deposerCNG",2];
