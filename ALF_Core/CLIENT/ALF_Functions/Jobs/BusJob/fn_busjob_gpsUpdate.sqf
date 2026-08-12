/*
    Fichier : fn_busjob_gpsUpdate.sqf
    Auteur  : MRP
    Desc    : Met à jour le marqueur GPS sur le prochain arrêt
*/

if (!MRP_BusJob_EnService) exitWith {};

// Supprimer l'ancien marqueur
if (MRP_BusJob_MarkerNom isNotEqualTo "") then {
    deleteMarker MRP_BusJob_MarkerNom;
    MRP_BusJob_MarkerNom = "";
};

private _idx = MRP_BusJob_ArretActuel;

// Circuit terminé
if (_idx >= count MRP_BusJob_Arrets) exitWith {
    hintSilent "";
};

private _arretData = MRP_BusJob_Arrets select _idx;
private _pos       = _arretData select 0;
private _markerVar = _arretData select 1;
private _num       = if (isNil "MRP_BusJob_ArretAffiche") then { _idx + 1 } else { MRP_BusJob_ArretAffiche };
private _total     = MRP_BusJob_ArretTotal;

// Récupérer nom de la ligne
private _nomLigne = "";
{ if ((_x select 0) isEqualTo MRP_BusJob_LigneActive) exitWith { _nomLigne = _x select 1; }; } forEach MRP_BusJob_Config;

// Créer le marqueur GPS
private _mkName = "MRP_BusJob_GPS_" + str floor random 9999;
MRP_BusJob_MarkerNom = _mkName;

createMarkerLocal [_mkName, _pos];
_mkName setMarkerTypeLocal "hd_objective";
_mkName setMarkerColorLocal "ColorGreen";
_mkName setMarkerTextLocal format ["Arrêt %1/%2", _num, _total];
_mkName setMarkerSizeLocal [0.8, 0.8];

// Hint GPS
private _ligneConfig = MRP_BusJob_Config select (MRP_BusJob_Config findIf { (_x select 0) isEqualTo MRP_BusJob_LigneActive });
private _salaire = if (_ligneConfig isEqualTo []) then { 0 } else { _ligneConfig select 2 };

hintSilent parseText format [
    "<t size='1.1' color='#F5C842'>BUS</t>  <t color='#28FF66'>Arret %2/%3</t>  <t color='#F5C842'>+%4 EUR</t>",
    _nomLigne, _num, _total, _salaire
];
