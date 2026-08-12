/*
    File: fn_takeItem.sqf
    Author: ALF - Louis Wood
*/
if (isNull (findDisplay 602)) exitWith {};

private _display = findDisplay 602;
if !(_display getVariable ["InventoryShiftClick", false]) exitWith {};

_display setVariable ["InventoryShiftClick", false];

params ["_ctrl", "_index"];

private _item = _ctrl lbData _index;
if !((_item call BIS_fnc_itemType) isEqualTo ["Magazine","UnknownMagazine"]) exitWith {};
private _itemDisabledC = ["ARRAY", ["InventoryItemsDepositTake", "items_disabled"]] call ALFTools_Client_Config_fnc_getConfig;
if (_item in _itemDisabledC) exitWith {};

private _containers = player getVariable ["ContainerOpened", []];
if ((count _containers) isEqualTo 0) exitWith {};

_containers params ["_container", "_secContainer"];

if ((ctrlIDC _ctrl) isEqualTo 632) then {
	if !((typeOf _container) isEqualTo "GroundWeaponHolder") then {_container = _secContainer};
} else {
	if ((typeOf _container) isEqualTo "GroundWeaponHolder") then {_container = _secContainer};
};

if !(player canAdd [_item, 0]) exitWith {};

(getMagazineCargo _container) params ["_cargoItems", "_cargoAmounts"];

private _index = _cargoItems findIf {_x isEqualTo _item};
if (_index isEqualTo -1) exitWith {};

private _amount = _cargoAmounts select _index;
if (_amount isEqualTo 0) exitWith {};

private _amount = if (player canAdd [_item, _amount]) then {
    _cargoItems deleteAt _index;
    _cargoAmounts deleteAt _index;

    _amount;
} else {
    if !(player canAdd [_item, _amount]) exitWith {["INFO", "Vous n'avez pas assez de place dans votre inventaire.", "warning"] spawn ALF_fnc_doMsg;};
};

clearMagazineCargoGlobal _container;

{
    _container addMagazineCargoGlobal [_x, _cargoAmounts select _forEachIndex];
} forEach _cargoItems;

for "_i" from 1 to _amount do {
    player addItem _item;
};
