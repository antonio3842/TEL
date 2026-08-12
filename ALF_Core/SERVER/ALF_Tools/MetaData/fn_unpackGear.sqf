/*
    GET YOUR PATH
    Code written by Association law 1901 "GET YOUR PATH" (RNA W252007073)
    Statement from the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403
    @Copyright GET YOUR PATH (https://www.getyourpath.fr)
    YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
    More informations : https://www.bistudio.com/community/game-content-usage-rules
    Contact : kainnon@getyourpath.fr
*/

if !(isServer) exitWith {};
if (hasInterface) exitWith {};

params[
	["_gear", [], [[]]]
];

_gear params [
	["_primaryW", [], [[]]],
	["_secondaryW", [], [[]]],
	["_handGunW", [], [[]]],
	["_uniform", [], [[]]],
	["_vest", [], [[]]],
	["_backPack", [], [[]]],
	["_headGear", "", [[], ""]],
	["_googles", "", [[], ""]],
	["_binoculars", [], [[]]],
	["_assignedItems", ["","","","","",""], [[]]]
];

{
	
	if (count _x <= 0) then {continue};
	private _newItemClass = [_x#0] call ALFTools_Server_MD_T_fnc_checkMetaData;
	if (_newItemClass isEqualTo "") then {continue};
	if (_newItemClass isEqualTo -1) then {_x = []; continue};
	_x set [0, _newItemClass];
}forEach [_primaryW, _secondaryW, _handGunW, _uniform, _vest, _backPack, _binoculars];



private _newItemClass = [_headGear] call ALFTools_Server_MD_T_fnc_checkMetaData;
if !(_newItemClass isEqualTo "") then {
	_headGear = _newItemClass;
};
if (_newItemClass isEqualTo -1) then {
	_headGear = "";
};



private _newItemClass = [_googles] call ALFTools_Server_MD_T_fnc_checkMetaData;
if !(_newItemClass isEqualTo "") then {
	_googles = _newItemClass;
};
if (_newItemClass isEqualTo -1) then {
	_googles = "";
};

if ((count _uniform) >= 2) then {
	{
		private _newItemClass = [_x#0] call ALFTools_Server_MD_T_fnc_checkMetaData;
		if (_newItemClass isEqualTo "") then {continue};
		if (_newItemClass isEqualTo -1) then {
			(_uniform#1) set [_forEachIndex, []];
			continue;
		};
		private _returnArray = _x;
		_returnArray set[0, _newItemClass];
		(_uniform#1) set [_forEachIndex, _returnArray];
	}forEach (_uniform#1);
};

if ((count _vest) >= 2) then {
	{
		private _newItemClass = [_x#0] call ALFTools_Server_MD_T_fnc_checkMetaData;
		if (_newItemClass isEqualTo "") then {continue};
		if (_newItemClass isEqualTo -1) then {
			(_vest#1) set [_forEachIndex, []];
			continue;
		};
		private _returnArray = _x;
		_returnArray set[0, _newItemClass];
		(_vest#1) set [_forEachIndex, _returnArray];
	}forEach (_vest#1);
};

if ((count _backPack) >= 2) then {
	{
		private _newItemClass = [_x#0] call ALFTools_Server_MD_T_fnc_checkMetaData;
		if (_newItemClass isEqualTo "") then {continue};
		if (_newItemClass isEqualTo -1) then {
			(_backPack#1) set [_forEachIndex, []];
			continue;
		};
		private _returnArray = _x;
		_returnArray set[0, _newItemClass];
		(_backPack#1) set [_forEachIndex, _returnArray];
	}forEach (_backPack#1);
};

{
	private _newItemClass = [_x] call ALFTools_Server_MD_T_fnc_checkMetaData;
	if (_newItemClass isEqualTo "") then {continue};
	if (_newItemClass isEqualTo -1) then {
		_assignedItems set[_forEachIndex, ""];
		continue;
	};
	_assignedItems set[_forEachIndex, _newItemClass];
}forEach _assignedItems;

private _finalGear = [_primaryW, _secondaryW, _handGunW, _uniform, _vest, _backPack, _headGear, _googles, _binoculars,_assignedItems];

_finalGear