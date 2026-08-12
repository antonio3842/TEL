#include "\ALF_Client\script_macros.hpp"
/*
    File: fn_createCigarette.sqf
    Author: ALF - NiiRoZz
*/

//ALF_fnc_createCigarette = {

if ({_x isEqualTo "ALF_Tabac_Seche"} count (magazines player) < 5) exitWith {
	["Info", "Tu n'as pas assez de feuilles séché sur toi.", "danger"] spawn ALF_fnc_doMsg;
};

for "_i" from 1 to 5 do {
    ["ALF_Tabac_Seche", false] call ALF_fnc_handleItem;
};

private _upp = "Confectionne des cigarettes";
life_action_inUse = true;

disableSerialization;
5 cutRsc ["life_progress", "PLAIN"];
private _ui = uiNamespace getVariable "life_progress";
private _progress = _ui displayCtrl 38201;
private _pgText = _ui displayCtrl 38202;
_pgText ctrlSetText format["%2 (1%1)...", "%", _upp];
_progress progressSetPosition 0.01;

private _cP = 0.01;
for "_i" from 0 to 1 step 0 do {
    sleep 0.4;
    _cP = _cP + 0.07;
    _progress progressSetPosition _cP;
    _pgText ctrlSetText format["%3 (%1%2)...", round(_cP * 100), "%", _upp];

    if (_cP >= 1) exitWith {};
    if (!alive player) exitWith {};
    if (player != vehicle player) exitWith {};
    if (life_interrupted) exitWith {};
};

5 cutText ["", "PLAIN"];
player playActionNow "stop";
life_action_inUse = false;

if !(alive player) exitWith {};
if (player != vehicle player) exitWith {};
if (life_interrupted) exitWith { life_interrupted = false; titleText["Action annulée.","PLAIN"]; };


for "_i" from 1 to 5 do {
    player addItem "murshun_cigs_cig0";
};
//};