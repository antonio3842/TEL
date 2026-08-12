/*
    File: fn_enedis_terminerService.sqf
    Author: MRP
    Description: Termine le service enedis
    
*/


if (!alive player) exitWith {};

if (!(player getVariable ["MRP_Bie_EnService", false])) exitWith {
    ["Enedis", "Vous n'êtes pas en service!", "danger"] spawn ALF_fnc_doMsg;
};

_veh = player getVariable ["MRP_Bie_Camion", objNull];

if (!isnull _veh) exitWith {
    ["Enedis", "Ranger votre véhicule avant de prendre votre fin de service!", "danger"] spawn ALF_fnc_doMsg;
};


["Enedis", "Service terminé. À bientôt!", "info"] spawn ALF_fnc_doMsg;

// Nettoyage variables
player setVariable ["MRP_Bie_EnService", nil, true];
MRP_Bie_EnService = false;
