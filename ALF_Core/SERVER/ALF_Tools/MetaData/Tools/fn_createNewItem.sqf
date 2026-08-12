/*
    GET YOUR PATH
    Code written by Association law 1901 "GET YOUR PATH" (RNA W252007073)
    Statement from the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403
    @Copyright GET YOUR PATH (https://www.getyourpath.fr)
    YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
    More informations : https://www.bistudio.com/community/game-content-usage-rules
    Contact : kainnon@getyourpath.fr

	Return : New item className
*/

private _v = params [
	["_className", "", [""]],
	["_data", createHashMap, [createHashMap]]
];

if !(_v) exitWith {""};

if !(isServer) exitWith {""};
if (hasInterface) exitWith {""};

private _itemClassName = [_className] call ALFTools_Server_MD_T_fnc_getNextItemClass;

if ((_itemClassName#0) isEqualTo "") exitWith {""};

/* -- Add item to namespace -- */
private _allActiveMetaData = missionNamespace getVariable["ALF_MetaData", createHashMap];

_allActiveMetaData set [(_itemClassName#0), [_itemClassName#1, _data]];
missionNamespace setVariable["ALF_MetaData", _allActiveMetaData, true];

_itemClassName#0