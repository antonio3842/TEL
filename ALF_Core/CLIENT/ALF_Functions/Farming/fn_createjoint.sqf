#include "\ALF_Client\script_macros.hpp"
/*
    File: fn_createjoint.sqf
    Author: ALF - NiiRoZz
*/

//ALF_fnc_createjoint = { 
 
if ( 
    ({_x isEqualTo "ALF_Tabac_Seche"} count (magazines player) < 5) || 
    ({_x in ["ALF_Weed", "ALF_Weed_2", "ALF_Weed_3"]} count (magazines player) < 1) 
) exitWith { 
    ["Info", "Il vous faut 5 feuilles de tabac et au moins 1 pochon de weed pour rouler.", "danger"] spawn ALF_fnc_doMsg; 
}; 
 
for "_i" from 1 to 5 do { 
    ["ALF_Tabac_Seche", false] call ALF_fnc_handleItem; 
}; 
 
private _weedList = ["ALF_Weed", "ALF_Weed_2", "ALF_Weed_3"]; 
private _playerMags = +magazines player; 
{ 
    if (_x in _weedList) exitWith { 
        [_x, false] call ALF_fnc_handleItem; 
    }; 
} forEach _playerMags; 
 
private _upp = "Confectionne des joints"; 
life_action_inUse = true; 
disableSerialization; 
5 cutRsc ["life_progress","PLAIN"]; 
private _ui = uiNamespace getVariable "life_progress"; 
private _progress = _ui displayCtrl 38201; 
private _pgText = _ui displayCtrl 38202; 
_pgText ctrlSetText format["%2 (1%1)...","%",_upp]; 
_progress progressSetPosition 0.01; 
private _cP = 0.01; 
 
for "_i" from 0 to 1 step 0 do { 
    sleep 0.4; 
    _cP = _cP + 0.035; 
    _progress progressSetPosition _cP; 
    _pgText ctrlSetText format["%3 (%1%2)...", round(_cP * 100), "%", _upp]; 
    if (_cP >= 1) exitWith {}; 
    if (!alive player) exitWith {}; 
    if (player != vehicle player) exitWith {}; 
    if (life_interrupted) exitWith {}; 
}; 
 
life_action_inUse = false; 
5 cutText ["", "PLAIN"]; 
player playActionNow "stop"; 
 
if !(alive player) exitWith {}; 
if (player != vehicle player) exitWith {}; 
if (life_interrupted) exitWith { 
    life_interrupted = false; 
    titleText["Action annulée.", "PLAIN"]; 
}; 
 
player addItem "HG_Weed_0"; 
 
//};