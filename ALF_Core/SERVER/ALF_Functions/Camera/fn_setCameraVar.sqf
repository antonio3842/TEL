#include "\ALF_Core\SERVER\script_macros.hpp"
/*
	File: fn_setCameraVar.sqf
	Author: Nanou
	This file is for Nanou's HeadlessClient.
*/
params [
	["_atm",objNull,[objNull]],
	["_time","",[""]],
	["_nearPlayersFace",[],[[]]],
	["_cameraKey","",[""]]
];

if (_time isEqualTo "" || {_nearPlayersFace isEqualTo []}) exitWith {};

private _storeKey = _cameraKey;
if (_storeKey isEqualTo "" && {!isNull _atm}) then {
	_storeKey = netId _atm;
	if (_storeKey isEqualTo "0:0") then {
		private _p = getPosWorld _atm;
		_storeKey = format [
			"%1_%2_%3_%4",
			toLower typeOf _atm,
			round ((_p # 0) * 10),
			round ((_p # 1) * 10),
			round ((_p # 2) * 10)
		];
	};
};
if (_storeKey isEqualTo "") exitWith {};

if !(isNull _atm) then {
	private _stock = _atm getVariable ["camera",[]];
	if(count _stock > 0) then {
		_stock pushBack [_time,[_nearPlayersFace]];
		_atm setVariable ["camera",_stock,true];
	} else {
		_atm setVariable ["camera",[[_time,[_nearPlayersFace]]],true];
	};
};

private _store = missionNamespace getVariable ["ALF_CameraStore",createHashMap];
if !(_store isEqualType createHashMap) then {
	_store = createHashMap;
};
private _globalStock = _store getOrDefault [_storeKey,[]];
_globalStock pushBack [_time,[_nearPlayersFace]];
_store set [_storeKey,_globalStock];
missionNamespace setVariable ["ALF_CameraStore",_store];
