#include "\ALF_Core\SERVER\script_macros.hpp"
/*
	File: fn_getCameraVar.sqf
	Author: Nanou
	This file is for Nanou's HeadlessClient.
*/
params [
	["_obj",objNull,[objNull]],
	["_cameraKey","",[""]]
];

private _storeKey = _cameraKey;
if (_storeKey isEqualTo "" && {!isNull _obj}) then {
	_storeKey = netId _obj;
	if (_storeKey isEqualTo "0:0") then {
		private _p = getPosWorld _obj;
		_storeKey = format [
			"%1_%2_%3_%4",
			toLower typeOf _obj,
			round ((_p # 0) * 10),
			round ((_p # 1) * 10),
			round ((_p # 2) * 10)
		];
	};
};

if (_storeKey isEqualTo "" && {isNull _obj}) exitWith {
	missionNamespace setVariable ["ALF_retrieveArrayCamera", [], remoteExecutedOwner];
};

private _store = missionNamespace getVariable ["ALF_CameraStore",createHashMap];
if !(_store isEqualType createHashMap) then {
	_store = createHashMap;
};

private _fallback = if (isNull _obj) then {[]} else {_obj getVariable ["camera",[]]};
private _data = _store getOrDefault [_storeKey,_fallback];
if !(_data isEqualType []) then {
	_data = [];
};

missionNamespace setVariable ["ALF_retrieveArrayCamera",_data,remoteExecutedOwner];
