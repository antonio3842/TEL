/*
    Fichier : fn_busjob_ajouterActions.sqf
    Desc    : Actions sur le bus (fin de service via PNJ depot uniquement)
*/

params [["_bus", objNull, [objNull]]];

if (isNull _bus) exitWith {};

// Validation des arrets : automatique (fn_busjob_autoArretLoop) a proximite + 3s a l'arret
