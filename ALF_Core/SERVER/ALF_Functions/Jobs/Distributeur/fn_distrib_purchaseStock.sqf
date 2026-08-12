/*
	File: fn_distrib_purchaseStock.sqf
	Serveur — achat distributeur : −1 stock, save BDD, limite livreur (autoritaire).
*/
params [
	["_machine", objNull, [objNull]],
	["_item", "", [""]],
	["_unit", objNull, [objNull]]
];

private _setResult = {
	params ["_ok"];
	_unit setVariable ["MRP_Distrib_PurchaseResult", _ok, true];
};

private _fail = {
	params ["_msg"];
	if (_msg isNotEqualTo "") then {
		["Distributeur", _msg, "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
	};
	[false] call _setResult;
};

if (isNull _machine || {_item isEqualTo ""} || {isNull _unit}) exitWith {
	if (!isNull _unit) then { [""] call _fail; };
};

if (isNil {_machine getVariable "MRP_Distrib_Stock"}) then {
	[_machine] call ALF_Server_fnc_distrib_stockLoad;
};

private _stock = _machine getVariable ["MRP_Distrib_Stock", createHashMap];
if (_stock isEqualType []) then { _stock = createHashMap; };

private _qty = _stock getOrDefault [_item, 0];
if (_qty < 1) exitWith {
	["Rupture de stock."] call _fail;
};

private _limitOk = true;

if (_unit getVariable ["MRP_Distrib_EnService", false]) then {
	private _limit = call ALF_Server_fnc_distrib_getServiceBuyLimit;
	private _machineKey = [_machine] call ALF_Server_fnc_distrib_getMachineKey;
	private _buyKey = format ["%1|%2|%3", getPlayerUID _unit, _machineKey, _item];
	private _counts = missionNamespace getVariable ["MRP_Distrib_ServiceBuys", createHashMap];

	if (_counts isEqualType []) then { _counts = createHashMap; };

	if ((_counts getOrDefault [_buyKey, 0]) >= _limit) then {
		_limitOk = false;
		[format [
			"Limite livreur : max %1 de cet article par distributeur jusqu'au reboot serveur.",
			_limit
		]] call _fail;
	} else {
		_counts set [_buyKey, (_counts getOrDefault [_buyKey, 0]) + 1];
		missionNamespace setVariable ["MRP_Distrib_ServiceBuys", _counts];
	};
};

if (!_limitOk) exitWith {};

_stock set [_item, _qty - 1];
_machine setVariable ["MRP_Distrib_Stock", _stock, true];
[_machine] call ALF_Server_fnc_distrib_bddSave;

[true] call _setResult;

true
