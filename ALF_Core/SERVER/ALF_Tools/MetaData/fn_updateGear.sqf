/*
    GET YOUR PATH
    Code written by Association law 1901 "GET YOUR PATH" (RNA W252007073)
    Statement from the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403
    @Copyright GET YOUR PATH (https://www.getyourpath.fr)
    YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
    More informations : https://www.bistudio.com/community/game-content-usage-rules
    Contact : kainnon@getyourpath.fr
*/


params [
	["_gear", [], [[]]],
	["_isDisconnected", false, [false]]
];

if !(isServer) exitWith {_gear};
if (hasInterface) exitWith {_gear};

if (_gear isEqualTo []) exitWith {_gear};

private _allActiveMetaData = missionNamespace getVariable ["ALF_MetaData", createHashMap];

_gear params [
	["_primaryW", [""], [[]]],
	["_secondaryW", [""], [[]]],
	["_handGunW", [""], [[]]],
	["_uniform", ["", []], [[]]],
	["_vest", ["", []], [[]]],
	["_backPack", ["", []], [[]]],
	["_headGear", "", [""]],
	["_googles", "", [""]],
	["_binoculars", [""], [[]]],
	["_assignedItems", [], [[]]]
];

{
	if (count _x <= 0) then {continue};
	private _arrayRet = [_x#0, _isDisconnected] call ALFTools_Server_MD_T_fnc_packData;
	if (_arrayRet isEqualTo "") then {continue};
	_x set [0, _arrayRet];
}forEach [_primaryW, _secondaryW, _handGunW, _uniform, _vest, _backPack, _binoculars];


if (_headGear in _allActiveMetaData) then {
	private _arrayRet = [_headGear, _isDisconnected] call ALFTools_Server_MD_T_fnc_packData;
	if (_arrayRet isEqualTo "") exitWith {};
	_headGear = _arrayRet;
};

if (_googles in _allActiveMetaData) then {
	private _arrayRet = [_googles, _isDisconnected] call ALFTools_Server_MD_T_fnc_packData;
	if (_arrayRet isEqualTo "") exitWith {};
	_googles = _arrayRet;
};

if ((count _uniform) >= 2) then {
	{
		private _arrayRet = [_x#0, _isDisconnected] call ALFTools_Server_MD_T_fnc_packData;
		if (_arrayRet isEqualTo "") then {continue};
		private _retArray = _x;
		_retArray set [0, _arrayRet];
		(_uniform#1) set [_forEachIndex, _retArray];
	}forEach (_uniform#1);
};

if ((count _vest) >= 2) then {
	{
		private _arrayRet = [_x#0, _isDisconnected] call ALFTools_Server_MD_T_fnc_packData;
		if (_arrayRet isEqualTo "") then {continue};
		private _retArray = _x;
		_retArray set [0, _arrayRet];
		(_vest#1) set [_forEachIndex, _retArray];
	}forEach (_vest#1);
};

if ((count _backPack) >= 2) then {
	{
		private _arrayRet = [_x#0, _isDisconnected] call ALFTools_Server_MD_T_fnc_packData;
		if (_arrayRet isEqualTo "") then {continue};
		private _retArray = _x;
		_retArray set [0, _arrayRet];
		(_backPack#1) set [_forEachIndex, _retArray];
	}forEach (_backPack#1);
};

{
	private _arrayRet = [_x, _isDisconnected] call ALFTools_Server_MD_T_fnc_packData;
	if (_arrayRet isEqualTo "") then {continue};
	_assignedItems set[_forEachIndex, _arrayRet];
}forEach _assignedItems;

private _returnGear = [_primaryW, _secondaryW, _handGunW, _uniform, _vest, _backPack, _headGear, _googles, _binoculars,_assignedItems];

_returnGear