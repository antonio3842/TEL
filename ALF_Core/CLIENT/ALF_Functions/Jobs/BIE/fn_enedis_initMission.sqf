/*
    File: fn_enedis_initMission.sqf
    Author: MRP
    Description: Prise de service enedis
    
*/

if (!alive player) exitWith {};

if (!isNil {player getVariable "MRP_Bie_EnService"}) exitWith {
    ["Enedis", "Déjà en service", "danger"] spawn ALF_fnc_doMsg;
};

if (!license_enedis) exitWith {
    ["Enedis", "Pas de licence Enedis. Allez à la préfecture.", "danger"] spawn ALF_fnc_doMsg;
};


// Variables joueur
MRP_Bie_EnService = true;
player setVariable ["MRP_Bie_EnService", true, true];
["Enedis", "Prise de service OK !", "success"] spawn ALF_fnc_doMsg;