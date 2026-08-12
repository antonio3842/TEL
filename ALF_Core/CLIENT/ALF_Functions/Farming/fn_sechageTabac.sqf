#include "\ALF_Client\script_macros.hpp"
/*
    File: fn_sechageTabac.sqf
    Author: ALF - NiiRoZz
*/
/*
if ({_x isEqualTo "ALF_Tabac"} count (magazines player) isEqualTo 0) exitWith {
	["Info", "Il vous faut des feuilles de tabac pour pouvoir les sécher.", "danger"] spawn ALF_fnc_doMsg;
};
if (life_action_inUse) exitWith {
	["EREEUR", "Une action est déjà en cours.", "danger"] spawn ALF_fnc_doMsg;
};


private _upp = "Sechage des feuilles de tabac";
life_action_inUse = true;
//Setup our progress bar.
disableSerialization;
5 cutRsc ["life_progress","PLAIN"];
private _ui = GVAR_UINS "life_progress";
private _progress = _ui displayCtrl 38201;
private _pgText = _ui displayCtrl 38202;
_pgText ctrlSetText format["%2 (1%1)...","%",_upp];
_progress progressSetPosition 0.01;
private _cP = 0.01;
for "_i" from 0 to 1 step 0 do {
	sleep 0.4;
	_cP = _cP + 0.035;
	_progress progressSetPosition _cP;
	_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];
	if(_cP >= 1) exitWith {};
	if(!alive player) exitWith {};
	if(player != vehicle player) exitWith {};
	if(life_interrupted) exitWith {};
};
life_action_inUse = false;
5 cutText ["","PLAIN"];
player playActionNow "stop";

//Verification du bon procédé.
if !(alive player) exitWith {};
if (player != vehicle player) exitWith {};
if (life_interrupted) exitWith {life_interrupted = false; titleText["Action annulé.","PLAIN"];};
if ({_x isEqualTo "ALF_Tabac"} count (magazines player) isEqualTo 0) exitWith {life_interrupted = false; titleText["Action annulé.","PLAIN"];};

["ALF_Tabac",false] call ALF_fnc_handleItem;
["ALF_Tabac_Seche",true] call ALF_fnc_handleItem;
/*

/*
    File: fn_sechageTabac.sqf
    Author: ALF - NiiRoZz / Modifié par ChatGPT
*/

// Vérification initiale
if (life_action_inUse) exitWith {
    ["ERREUR", "Une action est déjà en cours.", "danger"] spawn ALF_fnc_doMsg;
};

if ({_x isEqualTo "ALF_Tabac"} count (magazines player) < 1) exitWith {
    ["Info", "Il vous faut au moins une feuille de tabac pour pouvoir la sécher.", "danger"] spawn ALF_fnc_doMsg;
};

// Retirer 1 feuille immédiatement
["ALF_Tabac", false] call ALF_fnc_handleItem;

private _upp = "Séchage d'une feuille de tabac";
life_action_inUse = true;

// Affiche la barre de progression
disableSerialization;
5 cutRsc ["life_progress", "PLAIN"];
private _ui = GVAR_UINS "life_progress";
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

// Vérifications finales
if !(alive player) exitWith {};
if (player != vehicle player) exitWith {};
if (life_interrupted) exitWith { life_interrupted = false; titleText["Action annulée.", "PLAIN"]; };

// Donne 1 feuille de tabac séchée
["ALF_Tabac_Seche", true] call ALF_fnc_handleItem;
