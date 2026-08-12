/*
    GET YOUR PATH
    Code written by Association law 1901 "GET YOUR PATH" (RNA W252007073)
    Statement from the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403
    @Copyright GET YOUR PATH (https://www.getyourpath.fr)
    YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
    More informations : https://www.bistudio.com/community/game-content-usage-rules
    Contact : kainnon@getyourpath.fr
*/

private _v = params[
	["_itemClassName", "",[""]]
];

if !(_v) exitWith {""};

if !(isServer) exitWith {""};
if (hasInterface) exitWith {""};

private _allMetaData = ("isClass _x" configClasses (configFile >> "ALF_ConfigClient_Core" >> "ALF_MetaData"));

private _activeConfig = configNull;

{
	private _className = configName _x;
	if ([_className, _itemClassName] call BIS_fnc_inString) exitWith {
		_activeConfig = _x;
	};
} forEach _allMetaData;

if (isNull _activeConfig) exitWith {""};

private _defaultClass = configName _activeConfig;
_defaultClass