#include "\ALF_Client\script_macros.hpp"
/*
	File: fn_planterCanne Sucre.sqf
	MRP Carter
*/
params [
	["_item","",[""]]
];
if (_item isEqualTo "") exitWith {};

private _objects = allSimpleObjects [];

if !(vehicle player isEqualTo player) exitWith {["Canne", "Il faut sortir du véhicule, prend un bain de boue.", "warning", false] spawn ALF_fnc_doMsg;};
if (player distance (getMarkerPos "champ_canne") > 90) exitWith {["Canne", "Tu n'es pas dans un champ réservé à la plantation de Canne a sucre.", "warning", false] spawn ALF_fnc_doMsg;};
if (({_x distance player <= 1.5} count _objects) > 0) exitWith {["Canne", "Tu es trop prêt d'un autre plant de canne a sucre.", "warning", false] spawn ALF_fnc_doMsg;};
if (({_x distance player <= 200} count _objects) > 500) exitWith {["Canne", "Le champ de canne a sucre ne supporte pas plus de 500 plants.", "warning", false] spawn ALF_fnc_doMsg;};

[_item,false] spawn ALF_fnc_handleItem;

private _object = createSimpleObject ["MRPV2_Cultures\Canne_a_Sucre\canne_sucre_1.p3d", getPosWorld player];

[_object,"FAST"] remoteExec ["ALF_Server_fnc_canneSucreSystem",2];