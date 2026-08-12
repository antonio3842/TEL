#include "\ALF_Client\script_macros.hpp"
/*
File: fn_updateHsbc.sqf
Author: ALF Team
Description: Hsbc Panel update

*/
private["_display"];

disableSerialization;
_display = findDisplay 23560;
_textelivret = _display displayCtrl 23560;
_textecash = _display displayCtrl 23560;

_textelivret ctrlSetStructuredText parseText format["<t align='center' color='#000000' size='1.4px'>%1€</t>",[life_hsbc] call ALF_fnc_numberText];
_textecash ctrlSetStructuredText parseText format["<t align='center' color='#000000' size='1.4px'>%1€</t>",[life_cash] call ALF_fnc_numberText];
