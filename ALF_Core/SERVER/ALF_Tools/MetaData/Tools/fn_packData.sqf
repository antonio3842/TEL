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

params [
	["_className", "", [""]],
	//["_updateItem", false, [false]],
	["_removeGlobal", false, [false]]
];

if (_className isEqualTo "") exitWith {""};

private _allMetaData = missionNamespace getVariable ["ALF_MetaData", createHashMap];
if !(_className in _allMetaData) exitWith {_className};
private _metaDataVal = _allMetaData getOrDefault [_className, ["", []]];
private _data = _metaDataVal#1;
if (_data isEqualTo []) exitWith {_className};

if (_removeGlobal) then {
	_allActiveMetaData = missionNamespace getVariable ["ALF_MetaData", createHashMap];
	_allActiveMetaData deleteAt _className;
	missionNamespace setVariable ["ALF_MetaData", _allActiveMetaData,true];
};

private _finalData = toArray _data;

[(_metaDataVal#0), _finalData]