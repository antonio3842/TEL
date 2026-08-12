#include "\ALF_Client\script_macros.hpp"
/*
  File: fn_takeCanneSucre.sqf
  MRP Carter
*/
params [
  ["_obj",objNull,[objNull]]
];

if !(player canAdd ["canne_a_sucre", 3]) exitWith {["Canne a Sucre", "Vous n'avez pas assez de place.", "warning", false] spawn ALF_fnc_doMsg;};
deleteVehicle _obj;
["canne_a_sucre",true] spawn ALF_fnc_handleItem;
["canne_a_sucre",true] spawn ALF_fnc_handleItem;
["canne_a_sucre",true] spawn ALF_fnc_handleItem;

[0,3] spawn ALF_fnc_addXP;
