/*
	File: fn_distrib_restockOnPlus.sqf
	Client — clic [+] : retire 1 item inventaire et ajoute au stock machine.
*/
params [
	["_item", "", [""]],
	["_label", "", [""]]
];

if (_item isEqualTo "") exitWith {};

uiNamespace setVariable ["MRP_Distrib_RestockFocus", _item];

private _mach = uiNamespace getVariable ["MRP_Distrib_RestockMachine", objNull];
if (isNull _mach) exitWith {
	["Distributeur", "Machine introuvable.", "warning"] spawn ALF_fnc_doMsg;
};

if ((time - life_action_delay) < 0.35) exitWith {};
life_action_delay = time;

if ([_item] call ALF_fnc_distrib_countPlayerItem < 1) exitWith {
	["Distributeur", format ["Vous n'avez pas de %1 dans votre inventaire.", _label], "warning"] spawn ALF_fnc_doMsg;
	[] call ALF_fnc_distrib_restockRefresh;
};

private _stock = [_mach] call ALF_fnc_distrib_stockEnsure;
private _maxStock = call ALF_fnc_distrib_getStockMax;
private _current = _stock getOrDefault [_item, 0];

if (_current >= _maxStock) exitWith {
	["Distributeur", "Machine pleine pour cet article.", "warning"] spawn ALF_fnc_doMsg;
	[] call ALF_fnc_distrib_restockRefresh;
};

_stock set [_item, _current + 1];
_mach setVariable ["MRP_Distrib_Stock", _stock, true];

[_item, false] call ALF_fnc_handleItem;
[] call ALF_fnc_distrib_restockRefresh;

private _stockSerialized = [_stock] call ALF_fnc_distrib_stockEncode;
[_mach, _item, player, _stockSerialized] remoteExecCall ["ALF_Server_fnc_distrib_addStock", 2];
