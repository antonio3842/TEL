#include "\ALF_Client\script_macros.hpp"
/*
  File: fn_planterMais.sqf
  ALF Nanou
*/
private["_item","_pos","_object"];
_item = _this select 0;
_pos = getPos player;

if !(vehicle player isEqualTo player) exitWith {["Mais", "Il faut sortir du véhicule, prend un bain de boue.", "warning", false] spawn ALF_fnc_doMsg;};
if (player distance (getMarkerPos "champ_mais") > 100) exitWith {["Mais", "Tu n'es pas dans un champ réservé à la plantation de maïs.", "warning", false] spawn ALF_fnc_doMsg;};
if(count(nearestObjects[_pos,["Land_ALF_Plante_M"],2]) > 0) exitWith {["Mais", "Tu es trop prêt d'un autre plant de maïs.", "warning", false] spawn ALF_fnc_doMsg;};
if(count(nearestObjects[_pos,["Land_ALF_Plante_M"],200]) > 300) exitWith {["Mais", "Le champ de maïs ne supporte pas plus de 300 plants.", "warning", false] spawn ALF_fnc_doMsg;};

[_item,false] spawn ALF_fnc_handleItem;

_object = "Land_ALF_Plante_M" createVehicle [0,0,0];
_object animateSource ["et_4_source",1,true];
_object animateSource ["et_3_source",1,true];
_object animateSource ["et_2_source",1,true];
_object animateSource ["et_1_source",1,true];

_object setPos [_pos select 0,_pos select 1,0];

[_object,"FAST"] remoteExec ["ALF_Server_fnc_MaisSystem",2];
[_object,false] remoteExecCall ["enableSimulationGlobal", 2];
