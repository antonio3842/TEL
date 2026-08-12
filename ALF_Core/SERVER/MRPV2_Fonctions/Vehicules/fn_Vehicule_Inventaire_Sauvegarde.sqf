// MRPV2_Server_fnc_Vehicule_Inventaire_Sauvegarde = {
private _veh = param [0,objNull];


private _fnc_temp_gethasmap_forMagazine_forVehinventory =
{
    private _conteneur = param [0, objNull];
    private _liste_Chargeurs = createhashmap;
    {
        private _liste_Classename_magazinesAmmo = _x;
        private _classename = _liste_Classename_magazinesAmmo # 0;
        private _nombre_Balles = _liste_Classename_magazinesAmmo # 1;

        if (_classename in _liste_Chargeurs) then 
        {
            private _info_Balles_Chargeurs = _liste_Chargeurs get _classename;
            private _liste_Balles_Chargeurs = _info_Balles_Chargeurs select {(_x # 0) isEqualto _nombre_Balles};
            
            if (_liste_Balles_Chargeurs isNotEqualTo []) then
            {
                private _balles_Chargeurs = _liste_Balles_Chargeurs # 0;                
                _balles_Chargeurs set [1, (_balles_Chargeurs # 1) + 1];
            } else
            {
                _info_Balles_Chargeurs pushBack [_nombre_Balles, 1];
                _liste_Chargeurs set [_classename, _info_Balles_Chargeurs];
            };
        } else
        {
            _liste_Chargeurs set [_classename, [[_nombre_Balles, 1]]];
        };
    } forEach magazinesAmmoCargo _conteneur;

    _liste_Chargeurs
};

private _containers = everyContainer _veh;

{
    private _sac = _x # 1;
    private  _backpack_inventory = [getitemCargo _sac, [_sac] call _fnc_temp_gethasmap_forMagazine_forVehinventory, weaponsItemsCargo _sac, getBackpackCargo _sac];
    _x set [1, _backpack_inventory];
} forEach _containers;

private _inventory = [_containers, getitemCargo _veh, [_veh] call _fnc_temp_gethasmap_forMagazine_forVehinventory, weaponsItemsCargo _veh, getBackpackCargo _veh];

_inventory
// };