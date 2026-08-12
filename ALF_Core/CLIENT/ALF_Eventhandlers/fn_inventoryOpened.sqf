// [{ 
// ALF_fnc_inventoryOpened = {

private _unit = (_this select 0);
private _cursorObject = (_this select 1);
private _conteneur1 = (_this select 2);
private _conteneur2 = (_this select 3);

// Stocker dans les variables du joueur au lieu de globales (évite les conflits)
player setVariable ["ALF_Conteneur_0", _cursorObject, false];
player setVariable ["ALF_Conteneur_1", _conteneur1, false];
player setVariable ["ALF_Conteneur_2", _conteneur2, false];
// Compatibilité avec l'ancien code
Conteneur_0 = _cursorObject;
Conteneur_1 = _conteneur1;
Conteneur_2 = _conteneur2;

// Vérifications préliminaires AVANT le verrouillage
if (!isNull _cursorObject) then {
	// Vérifier si c'est un sac à dos (avant de verrouiller)
	private _isPack = getNumber(configFile >> "CfgVehicles" >> typeOf _cursorObject >> "isBackpack");
	if (_isPack isEqualTo 1) exitWith {
		hint "Vous ne pouvez pas fouiller les gens comme ça.";
		true;
	};
	
	// Vérifier si le joueur est menotté
	if ([_unit] call ALF_fnc_checkMenotter) exitWith {true};
	
	// Vérifier si c'est un personnage mort
	if (_cursorObject isKindOf "Man" && {!alive _cursorObject}) exitWith {true};
};

// Collecter tous les conteneurs valides
private _conteneurs = [];
if (!isNull _cursorObject) then {_conteneurs pushBack _cursorObject;};
if (!isNull _conteneur1) then {_conteneurs pushBack _conteneur1;};
if (!isNull _conteneur2) then {_conteneurs pushBack _conteneur2;};

// Vérifier si le joueur est dans un véhicule et l'ajouter aux conteneurs à vérifier
private _playerVehicle = vehicle player;
if (_playerVehicle != player && {!(_playerVehicle in _conteneurs)}) then {
	_conteneurs pushBack _playerVehicle;
};

// Vérification spécifique pour les véhicules : accès à l'inventaire basé sur les clés et l'état de verrouillage
private _vehicleAccessDenied = false;
{
	if (!isNull _x && {(_x isKindOf "Car") || {(_x isKindOf "Air") || {(_x isKindOf "Ship")}}}) then {
		private _vehicleLocked = locked _x;
		private _hasKeys = _x in life_vehicles;
		
		// Si le véhicule est verrouillé (lock 2) et que le joueur n'a pas les clés, bloquer l'accès
		if (_vehicleLocked isEqualTo 2 && {!_hasKeys}) then {
			hint "Vous devez avoir les clés de ce véhicule pour accéder à son inventaire.";
			_vehicleAccessDenied = true;
		} else {
			// Si le véhicule est déverrouillé (lock 0), s'assurer que l'inventaire est aussi déverrouillé
			if (_vehicleLocked isEqualTo 0 && {lockedInventory _x}) then {
				if (local _x) then {
					_x lockInventory false;
				} else {
					[_x, false] remoteExec ["lockInventory", _x];
				};
			};
			// Si le véhicule est verrouillé mais que le joueur a les clés, permettre l'accès
			// (l'inventaire sera géré par la suite dans le code)
		};
	};
} forEach _conteneurs;

if (_vehicleAccessDenied) exitWith {true};

// Vérifier si un conteneur est déjà verrouillé (optimisé avec boucle)
// Exception pour les GroundWeaponHolder : déverrouiller automatiquement s'ils sont verrouillés
// (peut arriver si l'inventaire a été fermé récemment et que le déverrouillage n'a pas encore pris effet)

// Étape 1 : Déverrouiller TOUS les GroundWeaponHolder proches en premier (même s'ils ne sont pas dans _conteneurs)
// Cela garantit que les objets au sol créés par le minage sont toujours accessibles
private _allNearHolders = nearestObjects [player, ["GroundWeaponHolder", "WeaponHolderSimulated", "groundweaponholder"], 10];
{
	if (!isNull _x && {lockedInventory _x}) then {
		if (local _x) then {
			_x lockInventory false;
		} else {
			[_x, false] remoteExec ["lockInventory", _x];
		};
	};
} forEach _allNearHolders;

// Étape 2 : Collecter les GroundWeaponHolder qui sont dans la liste des conteneurs
private _groundHolders = [];
{
	if (!isNull _x && {(_x isKindOf "GroundWeaponHolder") || {(_x isKindOf "WeaponHolderSimulated")}}) then {
		_groundHolders pushBack _x;
	};
} forEach _conteneurs;

// Déverrouiller tous les GroundWeaponHolder en batch
{
	if (lockedInventory _x) then {
		if (local _x) then {
			_x lockInventory false;
		} else {
			[_x, false] remoteExec ["lockInventory", _x];
		};
	};
} forEach _groundHolders;

// Étape 3 : Vérifier maintenant si un conteneur (sauf GroundWeaponHolder) est encore verrouillé
// Note: Pas besoin d'attendre car les opérations de déverrouillage sont synchrones
private _isLocked = false;
{
	if (!isNull _x && !(_x isKindOf "byscream_demi_raccord45") && {!((_x isKindOf "GroundWeaponHolder") || {(_x isKindOf "WeaponHolderSimulated")})} && {lockedInventory _x}) then {
		hint "Cet inventaire est actuellement utilisé par quelqu'un d'autre.";
		_isLocked = true;
	};
} forEach _conteneurs;

if (_isLocked) exitWith {true};

// Verrouiller tous les conteneurs en un seul batch (optimisé)
// EXCEPTION : Ne pas verrouiller les GroundWeaponHolder (objets au sol) car ils peuvent être partagés
// et causent des problèmes de blocage lors de réouverture d'inventaire (minage, etc.)
if (count _conteneurs > 0) then {
	{
		if (!isNull _x) then {
			// Ne pas verrouiller les GroundWeaponHolder (objets au sol)
			if ((_x isKindOf "GroundWeaponHolder") || {(_x isKindOf "WeaponHolderSimulated")}) then {
				// S'assurer qu'ils sont déverrouillés
				if (lockedInventory _x) then {
					if (local _x) then {
						_x lockInventory false;
					} else {
						[_x, false] remoteExec ["lockInventory", _x];
					};
				};
			} else {
				// Pour les véhicules : ne verrouiller l'inventaire que si le véhicule est verrouillé
				// Si le véhicule est déverrouillé, laisser l'inventaire accessible
				private _isVehicle = (_x isKindOf "Car") || {(_x isKindOf "Air") || {(_x isKindOf "Ship")}};
				if (_isVehicle) then {
					private _vehicleLocked = locked _x;
					// Ne verrouiller l'inventaire que si le véhicule est verrouillé
					if (_vehicleLocked isEqualTo 2) then {
						if (local _x) then {
							_x lockInventory true;
						} else {
							[_x, true] remoteExec ["lockInventory", _x];
						};
					};
					// Si le véhicule est déverrouillé, ne pas verrouiller l'inventaire (déjà géré plus haut)
				} else {
					// Verrouiller les autres conteneurs (coffres, etc.) mais pas les véhicules déverrouillés
					if (local _x) then {
						_x lockInventory true;
					} else {
						// Si l'objet n'est pas local, utiliser remoteExec
						[_x, true] remoteExec ["lockInventory", _x];
					};
				};
			};
		};
	} forEach _conteneurs;
	
	// Système de sécurité : déverrouiller automatiquement après 5 minutes si l'event handler échoue
	[] spawn {
		uiSleep 300; // 5 minutes
		private _conteneur0 = player getVariable ["ALF_Conteneur_0", objNull];
		private _conteneur1 = player getVariable ["ALF_Conteneur_1", objNull];
		private _conteneur2 = player getVariable ["ALF_Conteneur_2", objNull];
		{
			if (!isNull _x && {lockedInventory _x}) then {
				if (local _x) then {
					_x lockInventory false;
				} else {
					[_x, false] remoteExec ["lockInventory", _x];
				};
			};
		} forEach [_conteneur0, _conteneur1, _conteneur2];
	};
};

// Lancer la mise à jour des métadonnées
[] spawn ALF_fnc_inventoryMetaData;

// Configuration des event handlers de l'inventaire
[] spawn {
	waitUntil {!isNull (findDisplay 602)};
	private _display = findDisplay 602;
	
	// Supprimer les anciens handlers s'ils existent
	if (!isNil "MRPV2_Inventory_EventHandlers") then {
		{
			private _ctrl = _display displayCtrl (_x select 0);
			if (!isNull _ctrl) then {
				_ctrl ctrlRemoveEventHandler ["MouseButtonUp", _x select 1];
			};
		} forEach MRPV2_Inventory_EventHandlers;
	};
	
	// Stocker les IDs des nouveaux handlers
	MRPV2_Inventory_EventHandlers = [];
	
	private _ctrl640 = _display displayCtrl 640;
	private _ctrl632 = _display displayCtrl 632;
	private _ctrl638 = _display displayCtrl 638;
	private _ctrl633 = _display displayCtrl 633;
	private _ctrl619 = _display displayCtrl 619;
	
	MRPV2_Inventory_EventHandlers pushBack [640, _ctrl640 ctrlAddEventHandler ["MouseButtonUp", {_this spawn MRPV2_fnc_Interaction_Objets_Transfert_Vers_Joueur}]];
	MRPV2_Inventory_EventHandlers pushBack [632, _ctrl632 ctrlAddEventHandler ["MouseButtonUp", {_this spawn MRPV2_fnc_Interaction_Objets_Transfert_Vers_Joueur}]];
	MRPV2_Inventory_EventHandlers pushBack [638, _ctrl638 ctrlAddEventHandler ["MouseButtonUp", {_this spawn MRPV2_fnc_Interaction_Objets_Transfert_De_Joueur}]];
	MRPV2_Inventory_EventHandlers pushBack [633, _ctrl633 ctrlAddEventHandler ["MouseButtonUp", {_this spawn MRPV2_fnc_Interaction_Objets_Transfert_De_Joueur}]];
	MRPV2_Inventory_EventHandlers pushBack [619, _ctrl619 ctrlAddEventHandler ["MouseButtonUp", {_this spawn MRPV2_fnc_Interaction_Objets_Transfert_De_Joueur}]];
};

// Gestion des coffres de prison (configurable)
// Si ALF_Prison_Coffres n'est pas défini, utiliser la liste par défaut (compatibilité)
if (isNil "ALF_Prison_Coffres") then {
	ALF_Prison_Coffres = [
		alf_coffre_prison_1, alf_coffre_prison_2, alf_coffre_prison_3, alf_coffre_prison_4, alf_coffre_prison_5,
		alf_coffre_prison_6, alf_coffre_prison_7, alf_coffre_prison_8, alf_coffre_prison_9, alf_coffre_prison_10,
		alf_coffre_prison_11, alf_coffre_prison_12, alf_coffre_prison_13, alf_coffre_prison_14, alf_coffre_prison_15,
		alf_coffre_prison_16, alf_coffre_prison_17, alf_coffre_prison_18, alf_coffre_prison_19, alf_coffre_prison_20
	];
};

if (_cursorObject in ALF_Prison_Coffres) exitWith {
	private _coffreIndex = ALF_Prison_Coffres find _cursorObject;
	private _playerCoffreIndex = ALF_Prison_Coffre;
	private _isAuthorized = (_playerCoffreIndex > 0 && {_coffreIndex + 1 == _playerCoffreIndex});
	
	// Vérification du cadenas (safe_source)
	if ((_cursorObject animationSourcePhase "safe_source") < 0.5) then {
		if (!_isAuthorized) exitWith {
			hint "Ce coffre est cadenassé.";
			true;
		};
	};
	
	// Vérification du piège (piege_source)
	if ((_cursorObject animationSourcePhase "piege_source") < 0.5) then {
		if (!_isAuthorized) exitWith {
			private _bomb = "Bo_GBU12_LGB" createVehicle (getPos _cursorObject);
			[_cursorObject, 3] remoteExec ["ALF_Server_fnc_customCoffre", 2];
			true;
		};
	};
	
	// Vérification de la permission d'accès
	if (life_penit isEqualTo 0 && {!life_gendarme_service}) then {
		if (!_isAuthorized) exitWith {
			hint "Ce n'est pas votre cellule.";
			true;
		};
	};
	
	false; // Permettre l'ouverture si toutes les vérifications passent
};

// };
// }] remoteExec ['call',0,true];
