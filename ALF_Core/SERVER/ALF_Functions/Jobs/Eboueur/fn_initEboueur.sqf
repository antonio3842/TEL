/*
    File: init/fn_initServer.sqf
    Author: MRP
    Description: Init serveur
    
    OPTIMISATIONS BOHEMIA APPLIQUÉES:
    - call sans arguments (2x plus rapide)
*/

if (!isServer) exitWith {};

// Charger config
[] call ALF_Server_fnc_eboueur_config_positions;

// Variables globales

MRP_EBOUEUR_CARS = [];
missionNamespace setVariable ["MRP_Eboueur_ListCamion", [], true];

publicVariable "MRP_EBOUEUR_CARS";

// Lancement système
[] spawn {
    waitUntil {time > 0};
    call ALF_Server_fnc_eboueur_spawnPoubelles;
    
    // Recharge toutes les 25 minutes
    while {true} do {
        uiSleep 1500; // 25 * 60
        call ALF_Server_fnc_eboueur_rechargerPoubelles;
    };
};

diag_log "MRP_EBOUEUR: Serveur init OK";