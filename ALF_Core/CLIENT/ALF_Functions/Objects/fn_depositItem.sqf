/*
    File: fn_depositItem.sqf
    Author: ALF - Louis Wood
*/
if (isNull (findDisplay 602)) exitWith {};

private _display = findDisplay 602;
if !(_display getVariable ["InventoryShiftClick", false]) exitWith {};

_display setVariable ["InventoryShiftClick", false];

params ["_ctrl", "_index"];

private _item = _ctrl lbData _index;
if !((_item call BIS_fnc_itemType) isEqualTo ["Magazine","UnknownMagazine"]) exitWith {};
private _itemDisabled = ["ARRAY", ["InventoryItemsDepositTake", "items_disabled"]] call ALFTools_Client_Config_fnc_getConfig;
if (_item in _itemDisabled) exitWith {};

private _containers = player getVariable ["ContainerOpened", []];
if ((count _containers) isEqualTo 0) exitWith {};

_containers params ["_container", "_secContainer"];

if (ctrlShown (_display displayCtrl 632)) then {
	if !((typeOf _container) isEqualTo "GroundWeaponHolder") then {_container = _secContainer};
} else {
	if ((typeOf _container) isEqualTo "GroundWeaponHolder") then {_container = _secContainer};
};

if !(_container canAdd [_item, 0]) exitWith {};

private _amount = 0;

{
    private _index = (_x select 0) findIf {_x isEqualTo _item};

    if !(_index isEqualTo -1) then {_amount = _amount + ((_x select 1) select _index);};
} forEach [getMagazineCargo (uniformContainer player), getMagazineCargo (vestContainer player), getMagazineCargo (backpackContainer player)];

if (_amount isEqualTo 0) exitWith {};

private _amount = if (_container canAdd [_item, _amount]) then {
    _amount;
    } else {
        if !(_container canAdd [_item, _amount]) exitWith {["INFO", "Il n'y a pas assez de place dans le stockage.", "warning"] spawn ALF_fnc_doMsg;};

};

for "_i" from 1 to _amount do {
    player removeItem _item;
};

_container addMagazineCargoGlobal [_item, _amount];
