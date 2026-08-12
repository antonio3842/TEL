#include "\ALF_Client\script_macros.hpp"
/*
	File: fn_weaponShopFilter.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Applies the filter selected and changes the list.
*/
disableSerialization;
params [["_unused", nil], ["_forcedIndex", nil]];

private["_itemList","_index","_config","_priceTag","_itemArray"];
if (!isNil "_forcedIndex" && {_forcedIndex isEqualType 0}) then {
	_index = _forcedIndex;
} else {
	_index = lbCurSel 38402;
	if (_index isEqualTo -1) then {
		_index = uiNamespace getVariable ["Weapon_Shop_Filter", 0];
	};
};
_shop = uiNamespace getVariable ["Weapon_Shop",""];
if(_index isEqualTo -1 OR _shop isEqualTo "") exitWith {systemChat "Bad Data Filter"; closeDialog 0;}; //Bad data passing.

uiNamespace setVariable ["Weapon_Shop_Filter",_index];
//Setup List Control & Purge it.

_priceTag = ((findDisplay 38400) displayCtrl 38404);
_priceTag ctrlSetStructuredText parseText "";
_itemList = ((findDisplay 38400) displayCtrl 38403);

uiNamespace setVariable ["Weapon_Shop_Filtering", true];
lbClear _itemList;
switch (_index) do {
	case 0: {
		_config = ["ARRAY", ["WeaponShops", _shop, "items"]] call ALFTools_Client_Config_fnc_getConfig;
		{
			_showall = true;
			_licValue = _x select 4;
			if !(_licValue isEqualTo "") then {
				private _varnameConfig = ["STRING", ["Licenses", _licValue, "variable"]] call ALFTools_Client_Config_fnc_getConfig;
				_level = missionNamespace getVariable [format["license_%1",_varnameConfig], false];
				if !(_level) then {_showall = false;};
			};

			if(_showall) then {
				private _className = _x select 0;
				private _itemInfo = [_className] call ALF_fnc_fetchCfgDetails;
				private _displayName = _x select 1;
				if (_displayName isEqualTo "") then {
					if (count _itemInfo > 1) then {
						_displayName = _itemInfo select 1;
					} else {
						_displayName = getText (configFile >> "CfgWeapons" >> _className >> "displayName");
						if (_displayName isEqualTo "") then {
							_displayName = getText (configFile >> "CfgMagazines" >> _className >> "displayName");
						};
						if (_displayName isEqualTo "") then { _displayName = _className; };
					};
				};

				if (_shop isEqualTo "distributeur_auto") then {
					private _machine = uiNamespace getVariable ["MRP_Distrib_Machine", objNull];
					if (!isNull _machine) then {
						private _stock = [_machine] call ALF_fnc_distrib_stockEnsure;
						private _qty = _stock getOrDefault [_className, 0];
						if (_qty < 1) then {
							_displayName = format ["%1 (rupture)", _displayName];
						} else {
							if (MRP_Distrib_EnService) then {
								private _bought = [_machine, _className] call ALF_fnc_distrib_getServiceBuyCount;
								private _limit = [] call ALF_fnc_distrib_getServiceBuyLimit;
								_displayName = format ["%1 (stock: %2 | achat: %3/%4)", _displayName, _qty, _bought, _limit];
							} else {
								_displayName = format ["%1 (stock: %2)", _displayName, _qty];
							};
						};
					};
				};

				if (_showall) then {
				private _picture = "";
				if (count _itemInfo > 2) then { _picture = _itemInfo select 2; };
				if (_picture isEqualTo "") then {
					_picture = getText (configFile >> "CfgWeapons" >> _className >> "picture");
				};
				_itemList lbAdd _displayName;
				_itemList lbSetData[(lbSize _itemList)-1,_className];
				if (_picture isNotEqualTo "") then {
					_itemList lbSetPicture[(lbSize _itemList)-1,_picture];
				};
				_itemList lbSetValue[(lbSize _itemList)-1,_x select 2];
				};
			};
		} forEach (_config);
		((findDisplay 38400) displayCtrl 38405) ctrlSetText localize "STR_Global_Buy";
		ctrlShow [38402,true];
	};
	case 1: {
		private["_listedItems"];
		_config = [];
		_listedItems = [];
		//Go through weapons
		if(primaryWeapon player != "") then {_config pushBack primaryWeapon player;};
		if(secondaryWeapon player != "") then {_config pushBack secondaryWeapon player;};
		if(handgunWeapon player != "") then {_config pushBack handgunWeapon player;};
		//Go through items
		_config = _config + primaryWeaponItems player;
		_config = _config + (assignedItems player);
		_config = _config + (uniformItems player);
		_config = _config + (vestItems player);
		_config = _config + (backPackItems player);
		((findDisplay 38400) displayCtrl 38405) ctrlSetText localize "STR_Global_Sell";
		ctrlShow [38402,true];
		_itemArray = ["ARRAY", ["WeaponShops", _shop, "items"]] call ALFTools_Client_Config_fnc_getConfig;
		{
			if(!(_x in _listedItems) && _x != "") then {
				_iS = [_x,_itemArray] call TON_fnc_index;
				if(_iS != -1) then {
					if(!(EQUAL(SEL(SEL(_itemArray,_iS),3),-1))) then {
						_itemInfo = [_x] call ALF_fnc_fetchCfgDetails;
						_listedItems pushBack _x;
						_itemCount = {_x isEqualTo (_itemInfo select 0)} count _config;
						if(_itemCount > 1) then {
							_itemList lbAdd format["[%2] %1",_itemInfo select 1,_itemCount];
						} else {
							_itemList lbAdd format["%1",_itemInfo select 1];
						};
						_itemList lbSetData[(lbSize _itemList)-1,_itemInfo select 0];
						_itemList lbSetPicture[(lbSize _itemList)-1,_itemInfo select 2];
					};
				};
			};
		} forEach _config;
	};
};

private _keepItem = uiNamespace getVariable ["Weapon_Shop_KeepSelection", ""];
private _keepIndex = uiNamespace getVariable ["Weapon_Shop_KeepIndex", -1];
private _listSize = lbSize _itemList;
private _selIndex = 0;

if (_listSize > 0) then {
	if (_keepIndex >= 0 && {_keepIndex < _listSize}) then {
		_selIndex = _keepIndex;
	};

	if (_shop isEqualTo "distributeur_auto" && {_keepItem isNotEqualTo ""}) then {
		for "_i" from 0 to (_listSize - 1) do {
			if ((_itemList lbData _i) isEqualTo _keepItem) exitWith {
				_selIndex = _i;
			};
		};
	};

	uiNamespace setVariable ["Weapon_Shop_KeepSelection", nil];
	uiNamespace setVariable ["Weapon_Shop_KeepIndex", nil];
};

uiNamespace setVariable ["Weapon_Shop_Filtering", false];
_itemList lbSetCurSel _selIndex;

if (_listSize > 0 && {_selIndex >= 0}) then {
	[_itemList, _selIndex] call ALF_fnc_weaponShopSelection;
};
