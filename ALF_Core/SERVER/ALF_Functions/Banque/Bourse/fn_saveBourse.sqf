#include "\ALF_Core\SERVER\script_macros.hpp"
/*
	File:
	Author:

	This file is for Nanou's HeadlessClient.

	Description:

*/
private["_switch","_query","_queryResult","_pricearray","_curItemName","_index","_itemNewPrice","_itemName"];

_switch = _this select 0;

switch (_switch) do
{
	case 0:
	{
		private["_roundedPriceArr","_itemName","_itemPrice","_itemAmountSold"];
		_roundedPriceArr = [];
		{
			_itemName = _x select 0;
			_itemPrice = round (_x select 1);
			_itemAmountSold = _x select 2;
			_roundedPriceArr pushBack [_itemName,_itemPrice,_itemAmountSold];
		} forEach ALFMARKET_Items_PriceArr;
		_query = format["UPDATE bourse SET items = '%1' WHERE id='1'",_roundedPriceArr];
		_queryResult = [_query,1] call ALF_Server_fnc_asyncCall;
	};

	case 1:
	{
		_query = format["SELECT items FROM bourse WHERE id='1'"];
		_queryResult = [_query,2] call ALF_Server_fnc_asyncCall;
		_pricearray = _queryResult select 0;
		if (count _pricearray < 1) then {
			diag_log "ALFMARKET: Erreur de chargement Base de donnée";
		} else {
			private["_roundedPriceArr","_itemName","_itemPrice","_itemAmountSold"];
			_roundedPriceArr = [];
			{
				_itemName = _x select 0;
				_itemPrice = round (_x select 1);
				_itemAmountSold = _x select 2;
				_roundedPriceArr pushBack [_itemName,_itemPrice,_itemAmountSold];
			} forEach _pricearray;
			ALFMARKET_Items_PriceArr = _roundedPriceArr;
			{
				_itemName = _x select 0;
				_itemNewPrice = round (_x select 1);
				_index = -1;
				{
					_index = _index + 1;
					_curItemName = _x select 0;
					if (_curItemName isEqualTo _itemName) then {
					ALFMARKET_sellarraycopy set [_index,[_itemName,_itemNewPrice]];
					};
				} forEach ALFMARKET_sellarraycopy;
			} forEach ALFMARKET_Items_PriceArr;
			diag_log "ALFMARKET: Bourse OK !";
		};
	};
};