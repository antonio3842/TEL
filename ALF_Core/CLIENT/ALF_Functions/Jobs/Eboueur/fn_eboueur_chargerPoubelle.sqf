/*
    File: fn_eboueur_chargerPoubelle.sqf
    Author: MRP / Corrigé ALF
    Description: Charge une poubelle sur le camion
    
    CORRECTIONS:
    - Vérification limite 30 sacs AVANT transfert
    - Fix messages ordures/items
*/

params ["_camion", "_joueur"];

// Récupération positions
private _posLoad1 = _camion modelToWorld (_camion selectionPosition "poubelle_load1_point");
private _posLoad2 = _camion modelToWorld (_camion selectionPosition "poubelle_load2_point");

// Récupération poubelles proches
private _poubellesLoad1 = nearestObjects [_posLoad1, ["MRP_Poubelle"], 1.5];
private _poubellesLoad2 = nearestObjects [_posLoad2, ["MRP_Poubelle"], 1.5];

// Fusion et dédoublonnage
private _toutesPoubelles = (_poubellesLoad1 + _poubellesLoad2) arrayIntersect (_poubellesLoad1 + _poubellesLoad2);


if (_camion animationSourcePhase 'prepa_source' < 0.5) exitWith {
	["Éboueur", "Vous devez activer le mode de collecte", "warning"] spawn ALF_fnc_doMsg;
};

_zonePlayer = player getVariable ["MRP_Eboueur_Zone", ""];

private _zonePoubelle = "";

if (count _toutesPoubelles > 0) then {
    private _poubelle = _toutesPoubelles select 0;
    _zonePoubelle = _poubelle getVariable ["MRP_Eboueur_Zone", ""];
};



// Séparation attachées/libres
private _poubellesAttachees = [];
private _poubellesLibres = [];

{
    if (attachedTo _x isEqualTo _camion) then {
        _poubellesAttachees pushBack _x;
    } else {
        _poubellesLibres pushBack _x;
    };
} forEach _toutesPoubelles;

// Vérifications
if (_poubellesLibres isEqualTo []) exitWith {
    ["Éboueur", "Aucune poubelle à proximité!", "danger"] spawn ALF_fnc_doMsg;
};
if !(_zonePlayer isEqualTo _zonePoubelle) exitWith {
	["Éboueur", "Vous n'êtes pas dans la bonne zone de votre tournée", "warning"] spawn ALF_fnc_doMsg;
};

private _slotUtilise = count _poubellesAttachees;

if (_slotUtilise >= 2) exitWith {
    ["Éboueur", "Les 2 slots sont déjà occupés!", "warning"] spawn ALF_fnc_doMsg;
};

private _poubelle = _poubellesLibres select 0;

// === VÉRIFICATION LIMITE 30 SACS AVANT TOUT ===
private _orduresActuelles = _camion getVariable ["MRP_Eboueur_NbOrdures", 0];
private _capaciteMax = 100;

if (_orduresActuelles >= _capaciteMax) exitWith {
    ["Éboueur", "Camion plein (30/100)! Direction la déchetterie.", "warning"] spawn ALF_fnc_doMsg;
};

// Vérification contenu poubelle
private _itemsCargo = getMagazineCargo _poubelle;
private _nbOrduresReelles = 0;
private _aAutresItems = false;

if (count _itemsCargo > 0) then {
    private _items = _itemsCargo select 0;
    private _quantites = _itemsCargo select 1;
    
    {
        if (_x isEqualTo "MRP_Ordure") then {
            _nbOrduresReelles = _nbOrduresReelles + (_quantites select _forEachIndex);
        } else {
            _aAutresItems = true;
        };
    } forEach _items;
};

// Vérifier autres types
if (!_aAutresItems) then {
    private _magsCargo = getItemCargo _poubelle;
    private _weaponsCargo = getWeaponCargo _poubelle;
    private _backpacksCargo = getBackpackCargo _poubelle;
    
    if (count (_magsCargo select 0) > 0 || count (_weaponsCargo select 0) > 0 || count (_backpacksCargo select 0) > 0) then {
        _aAutresItems = true;
    };
};

// Poubelle vide
if (_nbOrduresReelles isEqualTo 0 && !_aAutresItems) exitWith {
    _poubelle setVariable ["MRP_Eboueur_NbOrdures", 0, true];
    clearItemCargoGlobal _poubelle;
    clearMagazineCargoGlobal _poubelle;
    ["Éboueur", "Cette poubelle est vide!", "warning"] spawn ALF_fnc_doMsg;
};

// Calcul ordures qui peuvent être ajoutées (respecter limite 30)
private _placeRestante = _capaciteMax - _orduresActuelles;
private _orduresAAjouter = _nbOrduresReelles min _placeRestante;

if (_orduresAAjouter isEqualTo 0) exitWith {
    ["Éboueur", "Camion plein! Impossible d'ajouter plus d'ordures.", "warning"] spawn ALF_fnc_doMsg;
};

// Message si limite atteinte
if (_orduresAAjouter < _nbOrduresReelles) then {
    ["Éboueur", format["Attention! Seulement %1/%2 sacs ajoutés (limite 100)", _orduresAAjouter, _nbOrduresReelles], "warning"] spawn ALF_fnc_doMsg;
};

// Déterminer slot
private _memoryPoint = ["poubelle_load1_point", "poubelle_load2_point"] select (_slotUtilise isEqualTo 0);
private _slotNumber = [1, 2] select (_slotUtilise isEqualTo 0);
private _animSource = ["vide_poubelle_g_source", "vide_poubelle_d_source"] select (_slotUtilise isEqualTo 0);

// Attacher poubelle
_poubelle enableSimulationGlobal false;
_poubelle attachTo [_camion, [0, -0.3, 0], _memoryPoint, true];
MRP_PoubelleAttachee = _poubelle;

["Éboueur", format["Poubelle chargée slot %1. Transfert...", _slotNumber], "info"] spawn ALF_fnc_doMsg;

// Transfert immédiat AVANT animation
private _orduresTransferees = [_camion, _poubelle] call ALF_fnc_eboueur_transfererOrdures;

// Message adapté
if (_aAutresItems) then {
    ["Éboueur", format["%1 ordures + items récupérés", _orduresTransferees], "success"] spawn ALF_fnc_doMsg;
} else {
    ["Éboueur", format["%1 ordures récupérées", _orduresTransferees], "success"] spawn ALF_fnc_doMsg;
};

// Animation
[_camion, _poubelle, _animSource, _orduresTransferees, _slotNumber] spawn ALF_fnc_eboueur_animerVidage;