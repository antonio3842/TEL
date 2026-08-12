/*
    File: fn_staff_open.sqf
    Author: Matthew

    Description
    Function to open the admin menu.
*/

#include "\ALF_Client\script_macros.hpp"

disableSerialization;
if(isNull (findDisplay 98)) exitWith 
{
    createDialog "ALF_ExecutiveMenu_Dialog";
    private _display = findDisplay 98;
    private _control = _display displayCtrl 1500;

    ALF_PlayersList = [];
    {
        lbAdd [1500, format ["%1",name _x]];
        ALF_PlayersList pushBack _x;
    } foreach playableUnits;

    _control ctrlAddEventHandler ["LBSelChanged","call ALF_fnc_staff_player_info_list;"];
    _control lbSetCurSel count(ALF_PlayersList)-1;

    _control = _display displayCtrl 1400;
    _control ctrlAddEventHandler ["KeyUp",{call ALF_fnc_staff_search_player_list;}];
    call ALF_fnc_staff_player_info_list;

    private _control = _display displayCtrl 1504;
    private _fullList = 
    [
        ["Animations Rapides",ALF_FastAnimationOn,2],
        ["Se Rassasier",false,2],
        ["Marqueurs",alf_admin_btn,1],
        ["Caméra",false,1],
        ["Invisible",(player getVariable ["admininvisible",false]),1],
        ["Arsenal",false,3],
        ["Créer feu de fôret",false,2],
        ["Créer feu de maison (cible)",false,1],
        ["Supprimer incendies",false,2]
    ];

    private _adminLevel = ALF_AdminLevel;
    ALF_AdminToolsList = [];
    {
        private _toolName = _x#0;
        private _perm = _x#2;
        if (_perm <= _adminLevel) then 
        {
            ALF_AdminToolsList pushBack _x;
            lbAdd [1504,_toolName];

            if (_x#1) then 
            {
                lbSetColor [1504, _forEachIndex, [0.90588235294,0.49411764705,0.14901960784,1]];
            };
        };
    } foreach _fullList;
    _control ctrlAddEventHandler ["LBDblClick","call ALF_fnc_staff_selected_tool;"];

    _control = _display displayCtrl 1015;
    if (alf_admin_on) then {_control ctrlSetTextColor [0.90588235294,0.49411764705,0.14901960784,1];};

    _control = _display displayCtrl 1016;
    if (ALF_MapTeleportReady) then {_control ctrlSetTextColor [0.90588235294,0.49411764705,0.14901960784,1];};

    _control = _display displayCtrl 1018;
    if(_selectedPlayer getVariable ["alf_freeze",false]) then {_control ctrlSetTextColor [0.90588235294,0.49411764705,0.14901960784,1];};

    _control = _display displayCtrl 1453;
    if (!isDamageAllowed player) then {_control ctrlSetTextColor [0.90588235294,0.49411764705,0.14901960784,1];};    
};
