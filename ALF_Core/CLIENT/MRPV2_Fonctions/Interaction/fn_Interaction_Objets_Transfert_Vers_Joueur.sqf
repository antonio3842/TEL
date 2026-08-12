// MRPV2_fnc_Interaction_Objets_Transfert_Vers_Joueur = {
private _ctrl = param [0,controlnull]; 
private _maj_Appuyer = param [4,FALSE]; 

if !(_maj_Appuyer) exitwith {};

private _index = lbCurSel _ctrl;
private _itemClass = _ctrl lbData _index;

// Protection contre les exécutions simultanées
if (!isNil {MRPV2_Transfert_Vers_Joueur_Lock} AND {MRPV2_Transfert_Vers_Joueur_Lock}) exitWith {};
MRPV2_Transfert_Vers_Joueur_Lock = true;

if (isNil {_itemClass} OR {_itemClass == ""}) exitWith { hint "Objet invalide."; MRPV2_Transfert_Vers_Joueur_Lock = false; };

if (!isNil {lastActionTime} AND {(time - lastActionTime) < 0.5}) exitWith {MRPV2_Transfert_Vers_Joueur_Lock = false;};
lastActionTime = time;

private _picked = 0;

// Récupérer les conteneurs depuis les variables du joueur (nouveau système) ou globales (compatibilité)
private _conteneur0 = player getVariable ["ALF_Conteneur_0", objNull];
if (isNull _conteneur0 && {!isNil "Conteneur_0"}) then {_conteneur0 = Conteneur_0;};

private _conteneur1 = player getVariable ["ALF_Conteneur_1", objNull];
if (isNull _conteneur1 && {!isNil "Conteneur_1"}) then {_conteneur1 = Conteneur_1;};

private _conteneur2 = player getVariable ["ALF_Conteneur_2", objNull];
if (isNull _conteneur2 && {!isNil "Conteneur_2"}) then {_conteneur2 = Conteneur_2;};

// Déterminer quel conteneur utiliser selon le contrôle cliqué
private _ctrlID = ctrlIDC _ctrl;
private _conteneur = objNull;

// Si on clique depuis le conteneur au sol (632), utiliser Conteneur_2 ou Conteneur_0
// Sinon, utiliser Conteneur_0 (véhicule/objet principal) ou Conteneur_1 (conteneur secondaire)
if (_ctrlID == 632) then {
	// Conteneur au sol - utiliser Conteneur_2 si disponible, sinon Conteneur_0
	_conteneur = if (!isNull _conteneur2) then {_conteneur2} else {_conteneur0};
} else {
	// Conteneur du véhicule/objet - utiliser Conteneur_0 (véhicule/objet principal)
	// Si Conteneur_0 est un GroundWeaponHolder, utiliser Conteneur_1 à la place
	if (!isNull _conteneur0) then {
		if ((typeOf _conteneur0) isEqualTo "GroundWeaponHolder") then {
			_conteneur = _conteneur1;
		} else {
			_conteneur = _conteneur0;
		};
	} else {
		_conteneur = _conteneur1;
	};
};

// Fonction helper pour transférer un type d'objet depuis un conteneur vers le joueur
private _transferFromContainer = {
    params ["_container", "_itemClass", "_type"];
    
    private _cargo = [];
    private _addFunc = {};
    private _clearFunc = {};
    private _addCargoFunc = {};
    
    switch (_type) do {
        case "item": {
            _cargo = getItemCargo _container;
            _addFunc = {player addItem _itemClass};
            _clearFunc = {clearItemCargoGlobal _container};
            _addCargoFunc = {_container addItemCargoGlobal _x};
        };
        case "magazine": {
            _cargo = getMagazineCargo _container;
            _addFunc = {player addMagazine _itemClass};
            _clearFunc = {clearMagazineCargoGlobal _container};
            _addCargoFunc = {_container addMagazineCargoGlobal _x};
        };
        case "weapon": {
            _cargo = getWeaponCargo _container;
            _addFunc = {player addWeapon _itemClass};
            _clearFunc = {clearWeaponCargoGlobal _container};
            _addCargoFunc = {_container addWeaponCargoGlobal _x};
        };
    };
    
    private _classes = _cargo select 0;
    private _counts = _cargo select 1;
    private _updated = [];
    private _pickedCount = 0;
    
    for "_i" from 0 to (count _classes - 1) do {
        private _cls = _classes select _i;
        private _cnt = _counts select _i;
        private _left = _cnt;
        
        if (_cls == _itemClass) then {
            for "_j" from 1 to _cnt do {
                if (player canAdd [_cls, 1]) then {
                    call _addFunc;
                    _pickedCount = _pickedCount + 1;
                    _left = _left - 1;
                } else {
                    break;
                };
            };
        };
        
        if (_left > 0) then {
            _updated pushBack [_cls, _left];
        };
    };
    
    call _clearFunc;
    { call _addCargoFunc; } forEach _updated;
    
    _pickedCount
};

if (!isNull _conteneur AND {_conteneur != player}) then {
    // Transfert des items
    _picked = _picked + ([_conteneur, _itemClass, "item"] call _transferFromContainer);
    
    // Transfert des magazines
    _picked = _picked + ([_conteneur, _itemClass, "magazine"] call _transferFromContainer);
    
    // Transfert des armes
    _picked = _picked + ([_conteneur, _itemClass, "weapon"] call _transferFromContainer);
    
    // Forcer la synchronisation de l'inventaire pour tous les joueurs qui ont ce conteneur ouvert
    // Cela garantit que les autres joueurs voient les changements immédiatement (comme pour les transferts unitaires)
    if (_picked > 0) then {
        // Forcer un refresh de l'inventaire pour tous les joueurs qui ont ce conteneur ouvert
        // En utilisant remoteExec vers tous les clients (0) pour synchroniser l'inventaire
        // Cette approche est similaire à ce qui se passe lors des transferts unitaires
        [_conteneur] remoteExec ["MRPV2_fnc_RefreshInventoryForContainer", 0];
    };
};

// Fallback sur GroundWeaponHolder si aucun objet n'a été récupéré
if (_picked == 0) then {
    private _near = nearestObjects [player, ["GroundWeaponHolder", "WeaponHolderSimulated"], 3];
    
    // Étape 1 : Déverrouiller TOUS les holders verrouillés d'abord (sans uiSleep dans la boucle)
    {
        private _holder = _x;
        if (!isNull _holder && {lockedInventory _holder}) then {
            if (local _holder) then {
                _holder lockInventory false;
            } else {
                [_holder, false] remoteExec ["lockInventory", _holder];
            };
        };
    } forEach _near;
    
    // Étape 2 : Attendre un court instant pour que tous les déverrouillages prennent effet
    uiSleep 0.1;
    
    // Étape 3 : Maintenant essayer de transférer depuis les holders déverrouillés
    {
        private _holder = _x;
        if (isNull _holder) then { continue; };
        
        // Vérifier à nouveau (au cas où le remoteExec n'aurait pas encore pris effet)
        if (lockedInventory _holder) then {
            // Tentative de déverrouillage supplémentaire
            if (local _holder) then {
                _holder lockInventory false;
            } else {
                [_holder, false] remoteExec ["lockInventory", _holder];
            };
            continue; // Passer au suivant si toujours verrouillé
        };
        
        private _holderPicked = 0;
        
        // Transfert depuis le holder
        _holderPicked = _holderPicked + ([_holder, _itemClass, "item"] call _transferFromContainer);
        _holderPicked = _holderPicked + ([_holder, _itemClass, "magazine"] call _transferFromContainer);
        _holderPicked = _holderPicked + ([_holder, _itemClass, "weapon"] call _transferFromContainer);
        
        _picked = _picked + _holderPicked;
        if (_picked > 0) exitWith {};
    } forEach _near;
};

MRPV2_Transfert_Vers_Joueur_Lock = false;
// };