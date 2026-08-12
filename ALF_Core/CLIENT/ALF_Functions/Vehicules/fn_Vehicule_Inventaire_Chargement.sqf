private _vehicle = cursorTarget;
if (isNull _vehicle || {typeOf _vehicle isEqualTo ""}) exitWith {
	// systemChat "[ERREUR] Aucun véhicule valide ciblé!";
};

comment "Vérification si l'inventaire global existe";
if (isNil "ALF_Global_Vehicle_Inventory" || {count ALF_Global_Vehicle_Inventory == 0}) exitWith {
	// systemChat "[ERREUR] Aucun inventaire sauvegardé ou inventaire vide!";
};

comment "Nettoyage de l'inventaire actuel du véhicule";
// systemChat "[INFO] Nettoyage de l'inventaire du véhicule...";
clearItemCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearWeaponCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;

comment "Chargement de l'inventaire depuis la variable globale";
// systemChat "[INFO] Chargement de l'inventaire sauvegardé...";
{
	private _category = _x select 0;
	private _type = _x select 1;
	private _count = _x select 2;
	
	switch (_category) do {
		case "item": {
			_vehicle addItemCargoGlobal [_type, _count];
			// systemChat format ["[INFO] Ajout item: %1 x%2", _type, _count];
		};
		case "magazine": {
			_vehicle addMagazineCargoGlobal [_type, _count];
			// systemChat format ["[INFO] Ajout chargeur: %1 x%2", _type, _count];
		};
		case "weapon": {
			_vehicle addWeaponCargoGlobal [_type, _count];
			// systemChat format ["[INFO] Ajout arme: %1 x%2", _type, _count];
		};
		case "backpack": {
			_vehicle addBackpackCargoGlobal [_type, _count];
			// systemChat format ["[INFO] Ajout sac: %1 x%2", _type, _count];
		};
	};
} forEach (values ALF_Global_Vehicle_Inventory);

// systemChat "[INFO] Chargement de l'inventaire terminé avec succès!";
