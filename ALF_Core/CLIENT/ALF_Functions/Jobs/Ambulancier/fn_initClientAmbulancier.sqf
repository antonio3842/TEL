/*
    File: init/fn_initClient.sqf
    Author: MRP
    Description: Init client
    
    OPTIMISATIONS BOHEMIA APPLIQUÉES:
    - call sans arguments (2x plus rapide que call avec arguments)
*/

if (!hasInterface) exitWith {};

MRP_Ambulancier_EnService = false;
MRP_AmbulancierEnCours = false;
MRP_Ambulancier_Destination = "";

waitUntil {!isNull player};

diag_log "MRP_AMBULANCIER: Client init v1.0";