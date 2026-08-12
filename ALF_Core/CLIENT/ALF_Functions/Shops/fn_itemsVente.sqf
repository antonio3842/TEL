#include "\ALF_Client\script_macros.hpp"

if((time - life_action_delay) < 0.2) exitWith {};
life_action_delay = time;

//if (alf_contrats <= 0) exitWith {};

disableSerialization;
if((lbCurSel 39403) isEqualTo -1) exitWith {hint localize "STR_Shop_Weapon_NoSelect"};
private _price = lbValue[39403,(lbCurSel 39403)];
if(isNil "_price") then {_price = 0;};
private _item = lbData[39403,(lbCurSel 39403)];
if (_item isEqualTo "ALF_pierre_small" && {player getVariable ["ALF_EnPrison",false]}) then {
	_price = floor (_price / 21);
};

private _btn = ((findDisplay 39400) displayCtrl 39405);
_btn ctrlEnable false;

life_cash = life_cash + _price;

[name player, getPlayerUID player, "VENTE_ITEM", format["%1 a vendu %2 pour %3€", name player, _item, _price]] remoteExec ["ALF_Server_fnc_logIt", 2];


if(_item in ["ALF_Banane","ALF_Peche"]) then {
	[0,1] spawn ALF_fnc_addXP;
} else {
	if(_item in ["ALF_Raisin","ALF_Huitre","ALF_Champignon"]) then {
		[0,3] spawn ALF_fnc_addXP;
	} else {
		if(_item in ["ALF_Fraise","ALF_Truffe"]) then {
			[0,5] spawn ALF_fnc_addXP;
		};
	};
};
private _h = [_item,false] spawn ALF_fnc_handleItem;
ALFBOURSE_NbAchat pushBack [_item,1];

waitUntil {sleep 0.05; scriptDone _h};

[] call ALF_fnc_itemsVenteLoad;

private _itemInfo = [_item] call ALF_fnc_fetchCfgDetails;
hint parseText format["Vous avez vendu : %1 pour <t color='#8cff9b'>%2€</t>.",_itemInfo select 1,[_price] call ALF_fnc_numberText];

_btn ctrlEnable true;
