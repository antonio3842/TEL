#include "\ALF_Client\script_macros.hpp"
//           ___  _  _        _                    _    _             
//          | _ )| || |      | |_   __ _  _ _  ___| |__(_) _ _   _ _  
//          | _ \ \_. |      |   \ / _` || '_|(_-/| / /| || ' \ | ' \ 
//          |___/ |__/       |_||_|\__/_||_|  /__/|_\_\|_||_||_||_||_| pour MRP
//

// ============================
// CONFIGURATION
// ============================
private _cfgVehicles = [
    "V_ALF_Sprinter_22_Benne_MRPV2",
    "mrp_premium_benne_chantier_farm_1",
    ""
];
private _cfgSableMag = "sable"; // Type ditem
private _cfgSableQty = 1;                  // Quantité à ajouter
private _cfgSearchRadius = 6;              // Rayon de recherche véhic

// ============================
// SCRIPT PRINCIPAL
// ============================


private _camion = nearestObjects [player, _cfgVehicles, _cfgSearchRadius];
if ((count _camion) isEqualTo 0) exitWith {
    ["ERREUR","Aucun camion à proximité pour stocker le sable.","danger"] spawn ALF_fnc_doMsg;
};

_camion = _camion select 0;

// Vérifier si on peut ajouter le sable
if !(_camion canAdd [_cfgSableMag, _cfgSableQty]) exitWith {
    ["ERREUR","Le camion est plein, impossible d’ajouter plus de sable.","danger"] spawn ALF_fnc_doMsg;
};

// Ajouter le sable au camion
_camion addMagazineCargoGlobal [_cfgSableMag, _cfgSableQty];

// Message joueur
["INFO", format ["Vous avez ajouté %1 sac(s) de sable dans le camion.", _cfgSableQty], "warning"] spawn ALF_fnc_doMsg;
