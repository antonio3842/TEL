/*
	File: fn_distrib_countPlayerItem.sqf
	Compte un classname dans l'inventaire joueur.
*/
params [["_item", "", [""]]];

if (_item isEqualTo "") exitWith { 0 };

private _allItems = magazines player + items player;
_allItems append (uniformItems player);
_allItems append (vestItems player);
_allItems append (backpackItems player);

{ _x isEqualTo _item } count _allItems
