// /*
// 	File: fn_inventoryClosed.sqf
// */
// ALF_fnc_inventoryClosed = {
private _obj = param [1, objNull, [objNull]];

// Collecter tous les conteneurs à déverrouiller (optimisé)
private _conteneurs = [];

// Récupérer depuis les variables du joueur (nouveau système) ou globales (compatibilité)
private _cursorObject = player getVariable ["ALF_Conteneur_0", objNull];
if (isNull _cursorObject) then {
	_cursorObject = if (!isNil "Conteneur_0") then {Conteneur_0} else {objNull};
};

private _conteneur1 = player getVariable ["ALF_Conteneur_1", objNull];
if (isNull _conteneur1) then {
	_conteneur1 = if (!isNil "Conteneur_1") then {Conteneur_1} else {objNull};
};

private _conteneur2 = player getVariable ["ALF_Conteneur_2", objNull];
if (isNull _conteneur2) then {
	_conteneur2 = if (!isNil "Conteneur_2") then {Conteneur_2} else {objNull};
};

// Ajouter tous les conteneurs valides (y compris _obj si différent)
if (!isNull _obj) then {_conteneurs pushBackUnique _obj;};
if (!isNull _cursorObject) then {_conteneurs pushBackUnique _cursorObject;};
if (!isNull _conteneur1) then {_conteneurs pushBackUnique _conteneur1;};
if (!isNull _conteneur2) then {_conteneurs pushBackUnique _conteneur2;};

// Vérifier si le joueur est dans un véhicule et l'ajouter aux conteneurs à déverrouiller
private _playerVehicle = vehicle player;
if (_playerVehicle != player && {!(_playerVehicle in _conteneurs)}) then {
	_conteneurs pushBackUnique _playerVehicle;
};

// Ajouter tous les GroundWeaponHolder proches à la liste des conteneurs à déverrouiller
// (important pour le minage et autres objets au sol)
private _nearHolders = nearestObjects [player, ["GroundWeaponHolder", "WeaponHolderSimulated", "groundweaponholder"], 10];
{
	if (!isNull _x && {!(_x in _conteneurs)}) then {
		_conteneurs pushBackUnique _x;
	};
} forEach _nearHolders;

// Déverrouiller tous les conteneurs en un seul batch (optimisé)
// IMPORTANT: Déverrouiller de manière synchrone pour éviter les blocages
// Note: Les GroundWeaponHolder ne sont normalement jamais verrouillés, mais on les déverrouille quand même par sécurité
// Pour les véhicules : ne déverrouiller l'inventaire que si le véhicule est déverrouillé
if (count _conteneurs > 0) then {
	{
		if (!isNull _x) then {
			// Pour les véhicules : vérifier l'état de verrouillage avant de déverrouiller l'inventaire
			private _isVehicle = (_x isKindOf "Car") || {(_x isKindOf "Air") || {(_x isKindOf "Ship")}};
			if (_isVehicle) then {
				private _vehicleLocked = locked _x;
				// Si le véhicule est déverrouillé, déverrouiller l'inventaire
				// Si le véhicule est verrouillé, garder l'inventaire verrouillé
				if (_vehicleLocked isEqualTo 0) then {
					if (local _x) then {
						_x lockInventory false;
					};
					[_x, false] remoteExec ["lockInventory", 0, true];
				};
				// Si le véhicule est verrouillé, ne pas déverrouiller l'inventaire
			} else {
				// Pour les autres conteneurs (non-véhicules), déverrouiller normalement
				if (local _x) then {
					_x lockInventory false;
				};
				// Toujours synchroniser avec tous les clients pour éviter les problèmes de synchronisation
				// Utiliser remoteExec vers tous les clients (0) pour garantir la synchronisation
				[_x, false] remoteExec ["lockInventory", 0, true];
			};
		};
	} forEach _conteneurs;
	
	// Double check après un court délai pour s'assurer que le déverrouillage a fonctionné
	[] spawn {
		uiSleep 0.1;
		private _conteneur0 = player getVariable ["ALF_Conteneur_0", objNull];
		private _conteneur1 = player getVariable ["ALF_Conteneur_1", objNull];
		private _conteneur2 = player getVariable ["ALF_Conteneur_2", objNull];
		private _playerVeh = vehicle player;
		private _conteneursToCheck = [_conteneur0, _conteneur1, _conteneur2];
		if (_playerVeh != player && {!(_playerVeh in _conteneursToCheck)}) then {
			_conteneursToCheck pushBack _playerVeh;
		};
		
		// Ajouter les GroundWeaponHolder proches à la vérification
		private _nearHolders = nearestObjects [player, ["GroundWeaponHolder", "WeaponHolderSimulated", "groundweaponholder"], 10];
		{
			if (!isNull _x && {!(_x in _conteneursToCheck)}) then {
				_conteneursToCheck pushBack _x;
			};
		} forEach _nearHolders;
		
		{
			if (!isNull _x && {lockedInventory _x}) then {
				// Pour les véhicules : vérifier l'état de verrouillage avant de déverrouiller l'inventaire
				private _isVehicle = (_x isKindOf "Car") || {(_x isKindOf "Air") || {(_x isKindOf "Ship")}};
				if (_isVehicle) then {
					private _vehicleLocked = locked _x;
					// Ne déverrouiller l'inventaire que si le véhicule est déverrouillé
					if (_vehicleLocked isEqualTo 0) then {
						if (local _x) then {
							_x lockInventory false;
						};
						[_x, false] remoteExec ["lockInventory", 0, true];
					};
				} else {
					// Pour les autres conteneurs, déverrouiller normalement
					if (local _x) then {
						_x lockInventory false;
					};
					[_x, false] remoteExec ["lockInventory", 0, true];
				};
			};
		} forEach _conteneursToCheck;
		
		// Vérification supplémentaire pour le véhicule du joueur (important pour les véhicules)
		if (_playerVeh != player && {lockedInventory _playerVeh}) then {
			private _vehicleLocked = locked _playerVeh;
			// Ne déverrouiller l'inventaire que si le véhicule est déverrouillé
			if (_vehicleLocked isEqualTo 0) then {
				if (local _playerVeh) then {
					_playerVeh lockInventory false;
				};
				// Synchroniser avec tous les clients
				[_playerVeh, false] remoteExec ["lockInventory", 0, true];
			};
		};
	};
};

// Nettoyer les variables du joueur
player setVariable ["ALF_Conteneur_0", nil, false];
player setVariable ["ALF_Conteneur_1", nil, false];
player setVariable ["ALF_Conteneur_2", nil, false];

// Nettoyer les variables globales (compatibilité ancien code)
if (!isNil "Conteneur_0") then {Conteneur_0 = nil;};
if (!isNil "Conteneur_1") then {Conteneur_1 = nil;};
if (!isNil "Conteneur_2") then {Conteneur_2 = nil;};

// Supprimer les event handlers de l'inventaire pour éviter les accumulations
if (!isNil "MRPV2_Inventory_EventHandlers") then {
	private _display = findDisplay 602;
	if (!isNull _display) then {
		{
			private _ctrl = _display displayCtrl (_x select 0);
			if (!isNull _ctrl) then {
				_ctrl ctrlRemoveEventHandler ["MouseButtonUp", _x select 1];
			};
		} forEach MRPV2_Inventory_EventHandlers;
	};
	MRPV2_Inventory_EventHandlers = nil;
};

// Gestion des GroundWeaponHolder
if (!isNull _obj && {(typeOf _obj) isEqualTo "GroundWeaponHolder"}) then {
	if(count (magazineCargo _obj) isEqualTo 0 && {count (itemCargo _obj) isEqualTo 0} && {count (weaponCargo _obj) isEqualTo 0} && {count (backpackCargo _obj) isEqualTo 0}) then {
		deleteVehicle _obj;
	};
};

// Déverrouiller tous les GroundWeaponHolder proches qui pourraient être restés verrouillés
// (sécurité supplémentaire en cas de fermeture d'inventaire incorrecte, notamment pour le minage)
[] spawn {
	// Déverrouillage immédiat des GroundWeaponHolder proches
	private _nearHolders = nearestObjects [player, ["GroundWeaponHolder", "WeaponHolderSimulated", "groundweaponholder"], 10];
	{
		if (!isNull _x && {lockedInventory _x}) then {
			if (local _x) then {
				_x lockInventory false;
			};
			// Synchroniser avec tous les clients
			[_x, false] remoteExec ["lockInventory", 0, true];
		};
	} forEach _nearHolders;
	
	// Double vérification après un court délai pour s'assurer que tous les GroundWeaponHolder sont déverrouillés
	uiSleep 0.1;
	_nearHolders = nearestObjects [player, ["GroundWeaponHolder", "WeaponHolderSimulated", "groundweaponholder"], 10];
	{
		if (!isNull _x && {lockedInventory _x}) then {
			if (local _x) then {
				_x lockInventory false;
			};
			// Synchroniser avec tous les clients
			[_x, false] remoteExec ["lockInventory", 0, true];
		};
	} forEach _nearHolders;
	
	// Vérification finale après un délai supplémentaire (pour les cas où le joueur se déplace rapidement)
	uiSleep 0.2;
	_nearHolders = nearestObjects [player, ["GroundWeaponHolder", "WeaponHolderSimulated", "groundweaponholder"], 10];
	{
		if (!isNull _x && {lockedInventory _x}) then {
			if (local _x) then {
				_x lockInventory false;
			};
			// Synchroniser avec tous les clients
			[_x, false] remoteExec ["lockInventory", 0, true];
		};
	} forEach _nearHolders;
};
// };