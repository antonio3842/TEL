// Nom du fichier : fn_setupKeyBinding_PNJ.sqf
// Auteur : NorX Aengell
// Description : Configuration des touches liées aux interactions avec les PNJ
// Dépendances requises : ALF_fnc_actionKeyHandler, ALF_Server_fnc_switchCommand

["Martinique RP", "Menu_Interaction_ALF", ["Menu Interaction", "Touche pour ouvrir un menu avec des interactions."], 
{
    if !(life_action_inUse) then 
    {
        [] spawn  
        {
            private _handle = [] spawn ALF_fnc_actionKeyHandler;
            waitUntil {sleep 0.1; scriptDone _handle};
            life_action_inUse = false;
        };
    };
}, {}, [219, [false, false, false]]] call CBA_fnc_addKeybind;

["Martinique RP", "Prise_Commandement", ["Prise Commandement GN", "Touche pour prendre/laisser le commandement."], 
{
    private _handle = false;
    if(life_gendarme_service && {time - life_action_delay > 5}) then 
    {
        life_action_delay = time;
        if (alf_gendarmerie_command) then 
        {
            alf_gendarmerie_command = false;
            ["COG", "Vous avez quitté le commandement.", "success"] spawn ALF_fnc_doMsg;
            [false, player] remoteExecCall ["ALF_Server_fnc_switchCommand", 2];
        } 
        else 
        {
            [true, player] remoteExecCall ["ALF_Server_fnc_switchCommand", 2];
        };
        _handle = true;
    };
    _handle
}, {}, [38, [true, false, false]]] call CBA_fnc_addKeybind;

["Martinique RP", "Menu_General_ALF", ["Menu General (aka Y)", "Touche pour afficher le menu."], 
{
    private _handle = false;
    if(!dialog && {!([player] call ALF_fnc_checkMenotter)} && {!life_action_inUse}) then 
    {
        [] call ALF_fnc_menuY;
        _handle = true;
    };
    _handle
}, {}, [21, [false, false, false]]] call CBA_fnc_addKeybind;