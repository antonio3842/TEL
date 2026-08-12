/*
    File: fn_staff_heal_player.sqf
    Author: Matthew

    Description
    Function to heal selected player.
*/

#include "\ALF_Client\script_macros.hpp"

private _selectedIndex = lbCurSel 1500;
private _target = (ALF_PlayersList#_selectedIndex);

_target setDamage 0; // Rétablit la vie à 100%
_target setFatigue 0; // Supprime la fatigue


// Réinitialisation des constantes vitales
_target setVariable ["alf_ms_bpm", 80, true]; // BPM normal
_target setVariable ["alf_ms_mmHg", 120, true]; // Pression sanguine normale
_target setVariable ["alf_ms_resp", 15, true]; // Respiration normale
_target setVariable ["alf_ms_spo2", 97, true]; // Oxygène normal
_target setVariable ["alf_ms_pain", 0, true]; // Supprime la douleur
_target setVariable ["alf_ms_bleeding", false, true]; // Arrête le saignement
_target setVariable ["alf_ms_active", false, true]; // Désactive le mode critique

// Remet la faim et la soif à 100%
_target setVariable ["life_hunger", 100, true];
_target setVariable ["life_thirst", 100, true];

// Supprime les maladies et infections
_target setVariable ["alf_medecine", [], true]; // Vide la liste des médicaments en cours
_target setVariable ["alf_vaccins", [], true]; // Vide la liste des vaccins
_target setVariable ["alf_ms_bouteille", false, true]; // Désactive la bouteille d'oxygène


// Ajout d'un message au joueur
hint "✅ Vous avez été complètement soigné !";

// Log dans le fichier RPT
diag_log format ["[ADMIN HEAL] %1 a été complètement soigné.", name _target];

