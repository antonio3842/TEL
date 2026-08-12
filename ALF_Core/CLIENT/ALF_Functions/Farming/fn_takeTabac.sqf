#include "\ALF_Client\script_macros.hpp"
/*
  File: fn_takeTabac.sqf
  ALF Nanou
*/
params [
  ["_obj",objNull,[objNull]]
];

if !(player canAdd "ALF_Tabac") exitWith {["Tabac", "Vous n'avez pas assez de place.", "warning", false] spawn ALF_fnc_doMsg;};
deleteVehicle _obj;
["ALF_Tabac",true] spawn ALF_fnc_handleItem;

[0,3] spawn ALF_fnc_addXP;
