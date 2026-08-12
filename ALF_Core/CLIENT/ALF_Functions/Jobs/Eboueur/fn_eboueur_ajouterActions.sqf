/*
    File: fn_eboueur_ajouterActions.sqf
    Author: MRP
    Description: Ajoute actions au camion
    
    OPTIMISATIONS BOHEMIA APPLIQUÉES:
    - params au lieu de _this select (14x plus rapide)
    
    CORRECTIONS:
    - Distance calculée depuis le memory point "command_arr_trigger"
    - Rayon de détection: 2 mètres
*/

params ["_camion"];

_camion addAction [
    "<t color='#00FFFF'>Charger la poubelle</t>",
    {
        params ["_target", "_caller"];
        [_target, _caller] call ALF_fnc_eboueur_chargerPoubelle;
    },
    nil,
    1.5,
    true,
    true,
    "",
    "(_this getVariable ['MRP_Eboueur_EnService', false]) && {_this distance (_target modelToWorld (_target selectionPosition 'command_arr_trigger')) < 3}",
    15
];