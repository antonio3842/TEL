/*
    File: fn_staff_search_player_list.sqf
    Author: Matthew

    Description
    Function to search a player by its name.
*/

#include "\ALF_Client\script_macros.hpp"

private _display = findDisplay 98;
private _text = ctrlText 1400;
lbClear 1500;
ALF_PlayersList = [];
{
    private _name = name _x;
    if ([_text, _name] call BIS_fnc_inString) then {
        lbAdd [1500, format ["%1",name _x]];
        ALF_PlayersList pushBack _x;
    };
} foreach playableUnits;