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

private _v = params [
	["_className", "", [""]],
	["_data", createHashMap, [createHashMap]]
];

if !(_v) exitWith {};

private _allDatas = missionNamespace getVariable ["ALF_MetaData", createHashMap];
if !(_className in _allDatas) exitWith {};

private _mataDataInfos = _allDatas getOrDefault [_className, ["", []]];

_mataDataInfos set [1, _data];
_allDatas set [_className, _mataDataInfos];
missionNamespace setVariable["ALF_MetaData", _allDatas, true];