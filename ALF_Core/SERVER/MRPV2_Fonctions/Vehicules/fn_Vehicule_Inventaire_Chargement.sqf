// MRPV2_Server_fnc_Vehicule_Inventaire_Chargement = {

private _veh = param [0,objNull];
private _inventory = param [1,[]];

if (_inventory isequalto []) exitwith {};

clearItemCargoGlobal _veh;
clearMagazineCargoGlobal _veh;
clearBackpackCargoGlobal _veh;
clearWeaponCargoGlobal _veh;

private _containers = _inventory # 0;
private _items = _inventory # 1;
private _magazines = _inventory # 2;
private _weapons = _inventory # 3;
private _backpacks = _inventory # 4;

for "_i" from 0 to count (_items # 0)-1 do {_veh addItemCargoGlobal [_items # 0 # _i,_items # 1 # _i];};

private _fnc_temp_addMagazines_inVehinventory_fromHashmap =
{
	private _conteneur = param [0,objnull];
	private _hashMap_Liste_Chargeurs = param [1,createhashmap];

	{
		private _classname = _x;
		private _chargeurs_Contenus = _hashMap_Liste_Chargeurs get _classname;

		{
			private _balles = _x # 0;
			private _chargeurs = _x # 1;
			_conteneur addMagazineAmmoCargo [_classname,_chargeurs,_balles];
		} foreach _chargeurs_Contenus;
	} foreach (keys _hashMap_Liste_Chargeurs);

	TRUE
};

[_veh,(createHashMapFromArray _magazines)] call _fnc_temp_addMagazines_inVehinventory_fromHashmap;
{_veh addWeaponWithAttachmentsCargoGlobal [_x,1];} forEach _weapons;

for "_i" from 0 to count (_backpacks # 0)-1 do {_veh addBackpackCargoGlobal [_backpacks # 0 # _i,_backpacks # 1 # _i];};

private _real_containers = everyContainer _veh;
private _type = "";

{
	private _sac = _x # 1;
	private _classname = _x # 0;
	for "_i" from 0 to count(_containers) do
	{
		if (_containers # _i # 0 isEqualTo _classname) exitWith
		{
			private _index_list = 0;
			{
				private _items = _x;
				switch (_index_list) do
				{
					case 0:
					{
						for "_j" from 0 to count(_items # 0) do {_sac addItemCargoGlobal [_items # 0 # _j,_items # 1 # _j];};
					};
					case 1:
					{
						[_sac,(createHashMapFromArray _items)] call _fnc_temp_addMagazines_inVehInventory_fromHashmap;
					};
					case 2:
					{
						{_sac addWeaponWithAttachmentsCargoGlobal [_x,1];} forEach _items;
					};
					case 3:
					{
						for "_j" from 0 to count(_items # 0) do {_sac addBackpackCargoGlobal [_items # 0 # _j,_items # 1 # _j];};
					};
				};

				_index_list = _index_list + 1;
			} forEach _containers # _i # 1;
		};
	};
} forEach _real_containers;
// };