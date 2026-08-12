
comment "SCRIPT DE SAUVEGARDE AVANCÉE";

private _vehicle = cursorTarget;
if (isNull _vehicle || {typeOf _vehicle isEqualTo ""}) exitWith {
    // systemChat "[ERREUR] Aucun véhicule valide ciblé!";
};

comment "Initialisation de la variable globale";
ALF_Global_Vehicle_Inventory = createHashMap;

// systemChat "[INFO] Début de la sauvegarde de l'inventaire...";

comment "Récupération des items simples";
{
    private _itemType = _x;
    private _itemCount = (getItemCargo _vehicle select 1) select _forEachIndex;
    ALF_Global_Vehicle_Inventory set [_itemType, ["item", _itemCount]];
    // systemChat format ["[INFO] Sauvegarde item: %1 x%2", _itemType, _itemCount];
} forEach (getItemCargo _vehicle select 0);

comment "Récupération des chargeurs avec munitions";
private _magazinesDetail = magazinesAmmoCargo _vehicle;
{
    private _magClass = _x select 0;
    private _ammoCount = _x select 1;
    ALF_Global_Vehicle_Inventory set [_magClass, ["magazineAmmo", _ammoCount]];
    // systemChat format ["[INFO] Sauvegarde chargeur: %1 (%2 munitions)", _magClass, _ammoCount];
} forEach _magazinesDetail;

comment "Récupération des armes avec accessoires";
private _weaponsDetail = weaponsItemsCargo _vehicle;
{
    ALF_Global_Vehicle_Inventory set [_x select 0, ["weaponItem", _x]];
    // systemChat format ["[INFO] Sauvegarde arme: %1 avec accessoires", _x select 0];
} forEach _weaponsDetail;

comment "Récupération des sacs à dos (simples)";
{
    private _backpackType = _x;
    private _backpackCount = (getBackpackCargo _vehicle select 1) select _forEachIndex;
    ALF_Global_Vehicle_Inventory set [_backpackType, ["backpack", _backpackCount]];
    // systemChat format ["[INFO] Sauvegarde sac: %1 x%2", _backpackType, _backpackCount];
} forEach (getBackpackCargo _vehicle select 0);

comment "Récupération de tous les conteneurs et leur contenu";
private _containers = everyContainer _vehicle;
{
    private _container = _x select 1;
    private _containerClass = _x select 0;
    
    comment "Sauvegarde des informations du conteneur";
    private _containerInfo = [
        getItemCargo _container,
        magazinesAmmoCargo _container,
        weaponsItemsCargo _container
    ];
    
    ALF_Global_Vehicle_Inventory set [_containerClass, ["container", _containerInfo]];
    // systemChat format ["[INFO] Sauvegarde conteneur: %1 avec son contenu", _containerClass];
} forEach _containers;

// systemChat format ["[INFO] Sauvegarde terminée! %1 éléments au total.", count (ALF_Global_Vehicle_Inventory)];