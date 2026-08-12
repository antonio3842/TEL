/*
    File: fn_staff_player_info_list.sqf
    Author: Matthew

    Description
    Function to fetch selected player's informations.
*/

#include "\ALF_Client\script_macros.hpp"

private _display = findDisplay 98;
private _selectedIndex = lbCurSel 1500;
private _control = _display displayCtrl 1503;
private _selectedPlayer = (ALF_PlayersList#_selectedIndex);
private _playerInfoArray = [
    ["SteamID64:", [getplayerUID _selectedPlayer,1]],
    ["Nom:", [name _selectedPlayer,1]],
    ["Stats. médicaux:", ["MedicalStats",0]],
    ["En prison:", ["ALF_EnPrison",2]],
    ["En service pompier:", ["MedService",2]],
    ["En service gendarmerie:", ["CopService",2]],
    ["En service pompier:", ["PenitService",2]],
    ["En service PM:", ["PenitService",2]]
];
lbClear 1503;
{
    private _text = _x#0;
    private _data = _x#1;
    switch(_data#1) do {
        case 0: {lbAdd [1503, format ["%1 %2", _text, _selectedPlayer getVariable [_data#0,"Indéfini"]]];};
        case 1: {lbAdd [1503, format ["%1 %2", _text, _data#0]];};
        case 2: {
            if (_selectedPlayer getVariable[_data#0,false]) then {
                lbAdd [1503, format ["%1 %2", _text, "Oui"]];
            } else {
                lbAdd [1503, format ["%1 %2", _text, "Non"]];
            };
        };
    };
 } forEach _playerInfoArray;
