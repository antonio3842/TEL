/*
    File: fn_eboueur_animerVidage.sqf
    Author: MRP / Corrigé ALF
    Description: Anime le vidage d'une poubelle avec mouvement réaliste
    
    CORRECTIONS:
    - Fix calcul ordures + limite 30
    - Fix animations jauges visuelles
    - Fix messages
*/

params ["_camion", "_poubelle", "_animSource", "_nbOrdures", "_slotNumber"];


// === PHASE 1: MONTÉE COMPLÈTE ===
_camion animateSource [_animSource, 1, 0.5];
uiSleep 3;

// Récupération variables
private _orduresActuelles = _camion getVariable ["MRP_Eboueur_NbOrdures", 0];
private _capaciteMax = 100;


// Camion plein (vérification sécurité)
if (_orduresActuelles >= _capaciteMax) exitWith {
    ["Éboueur", "Camion plein! Direction la déchetterie.", "warning"] spawn ALF_fnc_doMsg;
    
    uiSleep 1;
    _camion animateSource [_animSource, 0];
    uiSleep 3;
    
    _poubelle enableSimulationGlobal true;
    detach _poubelle;
    private _posPoubelle = getPosATL _poubelle;
    _poubelle setPosATL [_posPoubelle select 0, _posPoubelle select 1, 0];
    
    MRP_PoubelleAttachee = objNull;
};

// Calcul ordures ajoutées (limité à 30)
private _orduresAjoutees = _nbOrdures min (_capaciteMax - _orduresActuelles);
private _orduresNouveauTotal = _orduresActuelles + _orduresAjoutees;


// Mise à jour variables
_camion setVariable ["MRP_Eboueur_NbOrdures", _orduresNouveauTotal, true];
_poubelle setVariable ["MRP_Eboueur_NbOrdures", 0, true];

// Stats joueur
private _nbColisRamasses = player getVariable ["MRP_Eboueur_NbColisRamasses", 0];
player setVariable ["MRP_Eboueur_NbColisRamasses", _nbColisRamasses + _orduresAjoutees];

// === JAUGE VISUELLE (FIX) ===
private _pourcentageRemplissage = (_orduresNouveauTotal / _capaciteMax) * 100;


// Reset toutes les jauges
_camion animateSource ["ordure_10_source", 0];
_camion animateSource ["ordure_50_source", 0];
_camion animateSource ["ordure_100_source", 0];

// Activer selon pourcentage
if (_pourcentageRemplissage >= 1) then {
    _camion animateSource ["ordure_10_source", 1];
};

if (_pourcentageRemplissage >= 20) then {
    _camion animateSource ["ordure_50_source", 1];
};

if (_pourcentageRemplissage >= 50) then {
    _camion animateSource ["ordure_100_source", 1];
};

["Éboueur", format["Vidage terminé! %1/%2 (%3%%)", _orduresNouveauTotal, _capaciteMax, round _pourcentageRemplissage], "success"] spawn ALF_fnc_doMsg;

// === PHASE 2: MOUVEMENT DE SECOUSSE RÉALISTE ===
uiSleep 1;

// Descente partielle pour préparer la secousse
_camion animateSource [_animSource, 0.7, 1];
uiSleep 0.6;

// Remontée rapide pour secouer le fond
_camion animateSource [_animSource, 1, 3];
uiSleep 0.4;

// Petite pause au sommet
uiSleep 1;

// === PHASE 3: DESCENTE COMPLÈTE ===
_camion animateSource [_animSource, 0, 0.5];
uiSleep 3;

// Replacer poubelle
_poubelle enableSimulationGlobal true;
detach _poubelle;
private _posPoubelle = getPosATL _poubelle;
_poubelle setPosATL [_posPoubelle select 0, _posPoubelle select 1, 0];

MRP_PoubelleAttachee = objNull;

["Éboueur", "Poubelle replacée!", "info"] spawn ALF_fnc_doMsg;
