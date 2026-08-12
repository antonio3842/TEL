/*
    File: fn_staff_selected_tool.sqf
    Author: Matthew

    Description
    Function to use selected tool.
*/

#include "\ALF_Client\script_macros.hpp"

private _selectedIndex = lbCurSel 1504;
private _selectedAction = ALF_AdminToolsList select _selectedIndex select 0;

[name player, getPlayerUID player, "ADMIN", format["A utilisé l'action '%1' via le menu admin.", _selectedAction]]
remoteExec ["ALF_Server_fnc_logIt", 2];

switch (ALF_AdminToolsList#_selectedIndex#0) do {
    case "Animations Rapides": {call ALF_fnc_staff_fast_animation};
    case "Se Rassasier": {call ALF_fnc_staff_self_feed};
    case "Marqueurs": {call ALF_fnc_staff_markers;};
    case "Caméra": {closeDialog 0;["Init"] call BIS_fnc_camera;};
    case "Invisible": {call ALF_fnc_staff_invisible};
    case "Arsenal": {closeDialog 0;["Open",true] spawn BIS_fnc_arsenal;};
    case "Créer feu de fôret": {[] remoteExec ["ALF_Server_fnc_burn_foret",2]};
    case "Créer feu de maison (cible)": {[cursorObject] remoteExec ["ALF_Server_fnc_burn_building",2]};
    case "Supprimer incendies": {
        {
            _x setDammage 1;
            if !(typeOf _x in ["byscream_fire", "byscream_fire_2", "byscream_fire_3"]) then {
                {
                    deleteVehicle _x;
                } forEach (missionNamespace getVariable[format["flamme_%1", str (getPos _x)], []]);
                deleteVehicle _x;
            };
        } forEach (byscream_fires + (nearestObjects [[worldSize/2, worldSize/2], ["byscream_fire", "byscream_fire_2", "byscream_fire_3"], (sqrt 2) / 2 * worldSize]));
        byscream_fires = [];
        publicVariable "byscream_fires";
    };
};