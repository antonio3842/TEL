/*
    File: fn_eboueur_bloquerOrdures.sqf
    Author: MRP / Corrigé ALF
    Description: Empêche les éboueurs de garder des ordures sur eux
    
    CORRECTIONS:
    - Fix vérification hasInterface
    - Ajout logs debug
    - Optimisation boucle
*/

if (!hasInterface) exitWith {
    diag_log "EBOUEUR_BLOQUER: Pas d'interface - Exit";
};

[] spawn {
    private _lastCheck = 0;
    
    while {true} do {
        uiSleep 1; // Augmenté à 1 sec pour réduire la charge
        
        if (player getVariable ["MRP_Eboueur_EnService", false]) then {
            
            if (time - _lastCheck > 1) then {
                _lastCheck = time;
                private _supprime = false;
                
                // Vérifier arme en main
                if (currentWeapon player isEqualTo "MRP_Ordure") then {
                    player removeWeapon "MRP_Ordure";
                    _supprime = true;
                };
                
                // Vérifier inventaire
                if ("MRP_Ordure" in uniformItems player) then {
                    player removeItemFromUniform "MRP_Ordure";
                    _supprime = true;
                };
                
                if ("MRP_Ordure" in vestItems player) then {
                    player removeItemFromVest "MRP_Ordure";
                    _supprime = true;
                };
                
                if ("MRP_Ordure" in backpackItems player) then {
                    player removeItemFromBackpack "MRP_Ordure";
                    _supprime = true;
                };
                
                if ("MRP_Ordure" in assignedItems player) then {
                    player unassignItem "MRP_Ordure";
                    player removeItem "MRP_Ordure";
                    _supprime = true;
                };
                
                if (_supprime) then {
                    ["Éboueur", "Vous ne pouvez pas avoir d'ordures sur vous!", "danger"] spawn ALF_fnc_doMsg;
                };
            };
        };
    };
};