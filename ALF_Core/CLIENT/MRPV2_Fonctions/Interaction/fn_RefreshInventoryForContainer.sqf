MRPV2_fnc_RefreshInventoryForContainer = {
params ["_container"];

// Vérifier si le joueur a ce conteneur ouvert dans son inventaire
private _display = findDisplay 602;
if (!isNull _display) then {
    private _conteneur0 = player getVariable ["ALF_Conteneur_0", objNull];
    private _conteneur1 = player getVariable ["ALF_Conteneur_1", objNull];
    private _conteneur2 = player getVariable ["ALF_Conteneur_2", objNull];
    
    // Vérifier aussi si le joueur est dans le véhicule (quand on est à l'intérieur, le véhicule est automatiquement ajouté aux conteneurs)
    private _playerVehicle = vehicle player;
    private _isInVehicle = (_playerVehicle != player && {_playerVehicle == _container});
    
    // Si ce conteneur est ouvert (soit via les variables, soit parce que le joueur est dedans), forcer un refresh de l'inventaire
    if (_container in [_conteneur0, _conteneur1, _conteneur2] || {_isInVehicle}) then {
        // Forcer la mise à jour immédiatement en accédant aux données cargo (déclenche la synchronisation réseau)
        // Cela force Arma 3 à synchroniser l'inventaire avec le serveur
        private _dummy = getItemCargo _container;
        _dummy = getMagazineCargo _container;
        _dummy = getWeaponCargo _container;
        _dummy = getBackpackCargo _container;
        
        // Aussi forcer un refresh après un petit délai pour s'assurer que la synchronisation réseau est complète
        // (utile pour les cas où la synchronisation prend un peu de temps)
        [_container] spawn {
            params ["_container"];
            uiSleep 0.15;
            
            private _display = findDisplay 602;
            if (!isNull _display) then {
                // Vérifier à nouveau si le conteneur est toujours ouvert
                private _conteneur0 = player getVariable ["ALF_Conteneur_0", objNull];
                private _conteneur1 = player getVariable ["ALF_Conteneur_1", objNull];
                private _conteneur2 = player getVariable ["ALF_Conteneur_2", objNull];
                private _playerVehicle = vehicle player;
                private _isInVehicle = (_playerVehicle != player && {_playerVehicle == _container});
                
                if (_container in [_conteneur0, _conteneur1, _conteneur2] || {_isInVehicle}) then {
                    // Forcer à nouveau la mise à jour
                    private _dummy = getItemCargo _container;
                    _dummy = getMagazineCargo _container;
                    _dummy = getWeaponCargo _container;
                    _dummy = getBackpackCargo _container;
                };
            };
        };
    };
};
};

