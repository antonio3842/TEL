#include "\ALF_Client\script_macros.hpp"
/*
File: fn_checkSecurityCam.sqf
Author: ALF Team
*/
disableSerialization;
private _cursorObject = _this select 0;
if(count (attachedObjects _cursorObject) > 0) exitWith {};
private _pObj = getPosWorld _cursorObject;
private _cameraKey = format [
	"%1_%2_%3_%4",
	toLower typeOf _cursorObject,
	round ((_pObj # 0) * 10),
	round ((_pObj # 1) * 10),
	round ((_pObj # 2) * 10)
];

createDialog "ALF_Laptop_Dialog";
private _listbox = (findDisplay 11500) displayCtrl 11501;
lbClear _listbox;

ALF_retrieveArrayCamera = nil;
[_cursorObject,_cameraKey] remoteExecCall ["ALF_Server_fnc_getCameraVar",2];
private _timeout = diag_tickTime + 10;
waitUntil {!isNil "ALF_retrieveArrayCamera" || {diag_tickTime > _timeout}};
private _cameradata = if !(isNil "ALF_retrieveArrayCamera") then {ALF_retrieveArrayCamera} else {[]};

if(count _cameradata > 0) then {
	{
		private _time = _x select 0;
		private _count = count(_x select 1);
		_listbox lbAdd format["%1 - %2 donnée(s) exploitable(s).",_time,_count];
		_listbox lbSetdata [(lbSize _listbox)-1,str(_x select 1)];
	} forEach _cameradata;
} else {
	_listbox lbAdd "Aucune donnée";
	_listbox lbSetdata [(lbSize _listbox)-1, "Aucune donnée"];
};
((findDisplay 11500) displayCtrl 11501) lbSetCurSel 0;
