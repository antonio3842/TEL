// MRPV2_fnc_Interaction_Objets_Transfert_De_Joueur = {
private _ctrl = param [0,controlnull]; 
private _maj_Appuyer = param [4,FALSE]; 

if !(_maj_Appuyer) exitwith {};

private _index = lbCurSel _ctrl;
private _itemClass = _ctrl lbData _index;

if (isNil {_itemClass} OR {_itemClass isEqualTo ""}) exitWith { hint "Aucun objet valide sélectionné."; };

// Protection contre les exécutions simultanées
if (!isNil {MRPV2_Transfert_De_Joueur_Lock} AND {MRPV2_Transfert_De_Joueur_Lock}) exitWith {};
MRPV2_Transfert_De_Joueur_Lock = true;

if (!isNil {lastActionTime} AND {(time - lastActionTime) < 0.5}) exitWith {MRPV2_Transfert_De_Joueur_Lock = false;};
lastActionTime = time;

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
	// Conteneur du joueur (640, 633, 638, 619) - utiliser Conteneur_0 (véhicule/objet principal)
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

if (isNull _conteneur) exitWith {MRPV2_Transfert_De_Joueur_Lock = false;};

// Transfert atomique : compter, retirer et ajouter en une seule opération
private _count = {_x == _itemClass} count (items player);
if (_count > 0) then 
{
    // Retirer tous les items d'abord
    for "_i" from 1 to _count do 
    {
        player removeItem _itemClass;
    };
    // Puis ajouter au conteneur
    _conteneur addItemCargoGlobal [_itemClass, _count];
};

private _magCount = {_x == _itemClass} count (magazines player);
if (_magCount > 0) then 
{    
    // Vérifier si le conteneur a un maximumLoad (véhicules, objets avec inventaire)
    private _containerType = typeOf _conteneur;
    private _maxLoad = getNumber(configFile >> "CfgVehicles" >> _containerType >> "maximumLoad");
    
    if (_maxLoad > 0) then {
        // Calculer la masse actuelle du conteneur
        private _currentMass = 0;
        
        // Masse des items
        private _itemCargo = getItemCargo _conteneur;
        private _itemClasses = _itemCargo select 0;
        private _itemCounts = _itemCargo select 1;
        for "_i" from 0 to (count _itemClasses - 1) do {
            private _item = _itemClasses select _i;
            private _itemCount = _itemCounts select _i;
            private _itemDetails = [_item] call ALF_fnc_fetchCfgDetails;
            if (count _itemDetails > 15) then {
                _currentMass = _currentMass + ((_itemDetails select 15) * _itemCount);
            };
        };
        
        // Masse des magazines
        private _magCargo = getMagazineCargo _conteneur;
        private _magClasses = _magCargo select 0;
        private _magCounts = _magCargo select 1;
        for "_i" from 0 to (count _magClasses - 1) do {
            private _mag = _magClasses select _i;
            private _magCnt = _magCounts select _i;
            private _magDetails = [_mag] call ALF_fnc_fetchCfgDetails;
            if (count _magDetails > 15) then {
                _currentMass = _currentMass + ((_magDetails select 15) * _magCnt);
            };
        };
        
        // Masse des armes
        private _weaponCargo = getWeaponCargo _conteneur;
        private _weaponClasses = _weaponCargo select 0;
        private _weaponCounts = _weaponCargo select 1;
        for "_i" from 0 to (count _weaponClasses - 1) do {
            private _weapon = _weaponClasses select _i;
            private _weaponCnt = _weaponCounts select _i;
            private _weaponDetails = [_weapon] call ALF_fnc_fetchCfgDetails;
            if (count _weaponDetails > 15) then {
                _currentMass = _currentMass + ((_weaponDetails select 15) * _weaponCnt);
            };
        };
        
        // Calculer la masse disponible
        private _availableMass = _maxLoad - _currentMass;
        
        // Obtenir la masse d'un magazine
        private _magDetails = [_itemClass] call ALF_fnc_fetchCfgDetails;
        private _magMass = 0;
        if (count _magDetails > 15) then {
            _magMass = _magDetails select 15;
        };
        
        // Calculer combien de magazines peuvent être transférés
        private _transferableCount = 0;
        if (_magMass > 0) then {
            _transferableCount = floor(_availableMass / _magMass);
            _transferableCount = _transferableCount min _magCount;
        } else {
            // Si pas de masse définie, transférer tous les magazines
            _transferableCount = _magCount;
        };
        
        if (_transferableCount > 0) then {
            // Retirer les magazines transférables
            for "_i" from 1 to _transferableCount do 
            {
                player removeMagazine _itemClass;
            };
            // Ajouter au conteneur
            _conteneur addMagazineCargoGlobal [_itemClass, _transferableCount];
            
            // Message si tous les magazines n'ont pas pu être transférés
            if (_transferableCount < _magCount) then {
                hint format["Seulement %1/%2 magazines transférés. Capacité maximale atteinte.", _transferableCount, _magCount];
            };
        } else {
            hint "Le conteneur n'a pas assez de place pour ces magazines.";
        };
    } else {
        // Pas de maximumLoad, transférer tous les magazines (comportement original)
        for "_i" from 1 to _magCount do 
        {
            player removeMagazine _itemClass;
        };
        _conteneur addMagazineCargoGlobal [_itemClass, _magCount];
    };
};

// Transfert des armes
private _weaponCount = {_x == _itemClass} count (weapons player);
if (_weaponCount > 0) then 
{
    // Vérifier si le conteneur a un maximumLoad
    private _containerType = typeOf _conteneur;
    private _maxLoad = getNumber(configFile >> "CfgVehicles" >> _containerType >> "maximumLoad");
    
    if (_maxLoad > 0) then {
        // Calculer la masse actuelle du conteneur (réutiliser le calcul précédent si disponible)
        private _currentMass = 0;
        
        // Masse des items
        private _itemCargo = getItemCargo _conteneur;
        private _itemClasses = _itemCargo select 0;
        private _itemCounts = _itemCargo select 1;
        for "_i" from 0 to (count _itemClasses - 1) do {
            private _item = _itemClasses select _i;
            private _itemCount = _itemCounts select _i;
            private _itemDetails = [_item] call ALF_fnc_fetchCfgDetails;
            if (count _itemDetails > 15) then {
                _currentMass = _currentMass + ((_itemDetails select 15) * _itemCount);
            };
        };
        
        // Masse des magazines
        private _magCargo = getMagazineCargo _conteneur;
        private _magClasses = _magCargo select 0;
        private _magCounts = _magCargo select 1;
        for "_i" from 0 to (count _magClasses - 1) do {
            private _mag = _magClasses select _i;
            private _magCnt = _magCounts select _i;
            private _magDetails = [_mag] call ALF_fnc_fetchCfgDetails;
            if (count _magDetails > 15) then {
                _currentMass = _currentMass + ((_magDetails select 15) * _magCnt);
            };
        };
        
        // Masse des armes existantes
        private _weaponCargo = getWeaponCargo _conteneur;
        private _weaponClasses = _weaponCargo select 0;
        private _weaponCounts = _weaponCargo select 1;
        for "_i" from 0 to (count _weaponClasses - 1) do {
            private _weapon = _weaponClasses select _i;
            private _weaponCnt = _weaponCounts select _i;
            private _weaponDetails = [_weapon] call ALF_fnc_fetchCfgDetails;
            if (count _weaponDetails > 15) then {
                _currentMass = _currentMass + ((_weaponDetails select 15) * _weaponCnt);
            };
        };
        
        // Calculer la masse disponible
        private _availableMass = _maxLoad - _currentMass;
        
        // Obtenir la masse d'une arme
        private _weaponDetails = [_itemClass] call ALF_fnc_fetchCfgDetails;
        private _weaponMass = 0;
        if (count _weaponDetails > 15) then {
            _weaponMass = _weaponDetails select 15;
        };
        
        // Calculer combien d'armes peuvent être transférées
        private _transferableCount = 0;
        if (_weaponMass > 0) then {
            _transferableCount = floor(_availableMass / _weaponMass);
            _transferableCount = _transferableCount min _weaponCount;
        } else {
            // Si pas de masse définie, transférer toutes les armes
            _transferableCount = _weaponCount;
        };
        
        if (_transferableCount > 0) then {
            // Retirer les armes transférables
            for "_i" from 1 to _transferableCount do 
            {
                player removeWeapon _itemClass;
            };
            // Ajouter au conteneur
            _conteneur addWeaponCargoGlobal [_itemClass, _transferableCount];
            
            // Message si toutes les armes n'ont pas pu être transférées
            if (_transferableCount < _weaponCount) then {
                hint format["Seulement %1/%2 armes transférées. Capacité maximale atteinte.", _transferableCount, _weaponCount];
            };
        } else {
            hint "Le conteneur n'a pas assez de place pour ces armes.";
        };
    } else {
        // Pas de maximumLoad, transférer toutes les armes
        for "_i" from 1 to _weaponCount do 
        {
            player removeWeapon _itemClass;
        };
        _conteneur addWeaponCargoGlobal [_itemClass, _weaponCount];
    };
};

// Transfert des sacs à dos
private _backpackClass = backpack player;
if (_backpackClass != "" && {_backpackClass == _itemClass}) then 
{
    // Vérifier si le conteneur peut accepter des sacs
    private _containerType = typeOf _conteneur;
    private _maxLoad = getNumber(configFile >> "CfgVehicles" >> _containerType >> "maximumLoad");
    
    if (_maxLoad > 0) then {
        // Calculer la masse actuelle du conteneur
        private _currentMass = 0;
        
        // Masse des items
        private _itemCargo = getItemCargo _conteneur;
        private _itemClasses = _itemCargo select 0;
        private _itemCounts = _itemCargo select 1;
        for "_i" from 0 to (count _itemClasses - 1) do {
            private _item = _itemClasses select _i;
            private _itemCount = _itemCounts select _i;
            private _itemDetails = [_item] call ALF_fnc_fetchCfgDetails;
            if (count _itemDetails > 15) then {
                _currentMass = _currentMass + ((_itemDetails select 15) * _itemCount);
            };
        };
        
        // Masse des magazines
        private _magCargo = getMagazineCargo _conteneur;
        private _magClasses = _magCargo select 0;
        private _magCounts = _magCargo select 1;
        for "_i" from 0 to (count _magClasses - 1) do {
            private _mag = _magClasses select _i;
            private _magCnt = _magCounts select _i;
            private _magDetails = [_mag] call ALF_fnc_fetchCfgDetails;
            if (count _magDetails > 15) then {
                _currentMass = _currentMass + ((_magDetails select 15) * _magCnt);
            };
        };
        
        // Masse des armes
        private _weaponCargo = getWeaponCargo _conteneur;
        private _weaponClasses = _weaponCargo select 0;
        private _weaponCounts = _weaponCargo select 1;
        for "_i" from 0 to (count _weaponClasses - 1) do {
            private _weapon = _weaponClasses select _i;
            private _weaponCnt = _weaponCounts select _i;
            private _weaponDetails = [_weapon] call ALF_fnc_fetchCfgDetails;
            if (count _weaponDetails > 15) then {
                _currentMass = _currentMass + ((_weaponDetails select 15) * _weaponCnt);
            };
        };
        
        // Masse des sacs existants
        private _backpackCargo = getBackpackCargo _conteneur;
        private _backpackClasses = _backpackCargo select 0;
        private _backpackCounts = _backpackCargo select 1;
        for "_i" from 0 to (count _backpackClasses - 1) do {
            private _backpack = _backpackClasses select _i;
            private _backpackCnt = _backpackCounts select _i;
            private _backpackDetails = [_backpack] call ALF_fnc_fetchCfgDetails;
            if (count _backpackDetails > 15) then {
                _currentMass = _currentMass + ((_backpackDetails select 15) * _backpackCnt);
            };
        };
        
        // Calculer la masse disponible
        private _availableMass = _maxLoad - _currentMass;
        
        // Obtenir la masse d'un sac
        private _backpackDetails = [_itemClass] call ALF_fnc_fetchCfgDetails;
        private _backpackMass = 0;
        if (count _backpackDetails > 15) then {
            _backpackMass = _backpackDetails select 15;
        };
        
        // Vérifier si on peut transférer le sac
        if (_backpackMass > 0 && {_availableMass >= _backpackMass}) then {
            // Retirer le sac du joueur
            removeBackpack player;
            // Ajouter au conteneur
            _conteneur addBackpackCargoGlobal [_itemClass, 1];
        } else {
            hint "Le conteneur n'a pas assez de place pour ce sac à dos.";
        };
    } else {
        // Pas de maximumLoad, transférer le sac
        removeBackpack player;
        _conteneur addBackpackCargoGlobal [_itemClass, 1];
    };
};

MRPV2_Transfert_De_Joueur_Lock = false;
// };