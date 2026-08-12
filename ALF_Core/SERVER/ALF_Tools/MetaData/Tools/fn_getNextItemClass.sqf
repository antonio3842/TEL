/*
    GET YOUR PATH
    Code written by Association law 1901 "GET YOUR PATH" (RNA W252007073)
    Statement from the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403
    @Copyright GET YOUR PATH (https://www.getyourpath.fr)
    YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
    More informations : https://www.bistudio.com/community/game-content-usage-rules
    Contact : kainnon@getyourpath.fr

	Return : Next avalaible className
*/

private _v = params [
	["_itemClassName", "", [""]]
];

if !(_v) exitWith {["", ""]};

if !(isServer) exitWith {["", ""]};
if (hasInterface) exitWith {["", ""]};

private _allActiveMetaData = missionNamespace getVariable["ALF_MetaData", createHashMap];

private _defaultClass = [_itemClassName] call ALFTools_Server_MD_T_fnc_getDefaultClassName;
private _config = (configFile >> "ALF_ConfigClient_Core" >> "ALF_MetaData" >> _defaultClass);
private _maxItems = getNumber(_config >> "maxItems");

private _newItemClassName = "";
for "_i" from 0 to _maxItems do {
	private _stringFormat = format ["%1_%2", _defaultClass, _i];
	if !(_stringFormat in _allActiveMetaData) exitWith {
		_newItemClassName = _stringFormat;
	};
};

if (_newItemClassName isEqualTo "") exitWith {["", _defaultClass]};

[_newItemClassName, _defaultClass]