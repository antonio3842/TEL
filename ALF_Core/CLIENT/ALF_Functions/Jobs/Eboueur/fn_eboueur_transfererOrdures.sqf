/*
    File: fn_eboueur_transfererOrdures.sqf
    Author: MRP / Corrigé ALF
    Description: Transfère les items de la poubelle vers le camion
    
    CORRECTIONS:
    - Fix comptage ordures vs autres items
    - Fix affichage messages
*/

params ["_camion", "_poubelle"];

if (isNull _camion || isNull _poubelle) exitWith {
    diag_log "EBOUEUR_TRANSFER: Camion ou poubelle null";
    0
};

// Récupération cargo
private _itemsCargo = getItemCargo _poubelle;
private _magsCargo = getMagazineCargo _poubelle;
private _weaponsCargo = getWeaponCargo _poubelle;
private _backpacksCargo = getBackpackCargo _poubelle;

private _orduresReelles = 0;
private _autresItems = [];


// Traitement items
if (count _magsCargo > 0) then {
    private _items = _magsCargo select 0;
    private _quantites = _magsCargo select 1;
    
    {
        private _itemClass = _x;
        private _itemQty = _quantites select _forEachIndex;
        
        
        if (_itemClass isEqualTo "MRP_Ordure") then {
            _orduresReelles = _orduresReelles + _itemQty;
        } else {
            _autresItems pushBack [_itemClass, _itemQty, "item"];
        };
    } forEach _items;
};

// Traitement magazines
if (count _itemsCargo > 0) then {
    private _mags = _itemsCargo select 0;
    private _quantites = _itemsCargo select 1;
    
    {
        _autresItems pushBack [_x, _quantites select _forEachIndex, "magazine"];
    } forEach _mags;
};

// Traitement armes
if (count _weaponsCargo > 0) then {
    private _weapons = _weaponsCargo select 0;
    private _quantites = _weaponsCargo select 1;
    
    {
        _autresItems pushBack [_x, _quantites select _forEachIndex, "weapon"];
    } forEach _weapons;
};

// Traitement sacs à dos
if (count _backpacksCargo > 0) then {
    private _backpacks = _backpacksCargo select 0;
    private _quantites = _backpacksCargo select 1;
    
    {
        _autresItems pushBack [_x, _quantites select _forEachIndex, "backpack"];
    } forEach _backpacks;
};

// Vider la poubelle
clearItemCargoGlobal _poubelle;
clearMagazineCargoGlobal _poubelle;
clearWeaponCargoGlobal _poubelle;
clearBackpackCargoGlobal _poubelle;

// Transférer autres items dans coffre
if (count _autresItems > 0) then {
    {
        _x params ["_class", "_qty", "_type"];
        
        switch (_type) do {
            case "item": {
                _camion addItemCargoGlobal [_class, _qty];
            };
            case "magazine": {
                _camion addMagazineCargoGlobal [_class, _qty];
            };
            case "weapon": {
                _camion addWeaponCargoGlobal [_class, _qty];
            };
            case "backpack": {
                _camion addBackpackCargoGlobal [_class, _qty];
            };
        };
    } forEach _autresItems;
};

// Retourner nombre d'ordures
_orduresReelles