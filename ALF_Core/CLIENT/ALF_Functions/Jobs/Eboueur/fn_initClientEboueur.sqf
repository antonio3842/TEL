/*
    File: init/fn_initClient.sqf
    Author: MRP
    Description: Init client
    
    OPTIMISATIONS BOHEMIA APPLIQUÉES:
    - call sans arguments (2x plus rapide que call avec arguments)
*/

if (!hasInterface) exitWith {};

MRP_Eboueur_EnService = false;
MRP_EboueurEnCours = false;
MRP_PoubelleAttachee = objNull;

waitUntil {!isNull player};

// call sans arguments est 2x plus rapide selon Bohemia
call ALF_fnc_eboueur_bloquerOrdures;

diag_log "MRP_EBOUEUR: Client init v3.1";