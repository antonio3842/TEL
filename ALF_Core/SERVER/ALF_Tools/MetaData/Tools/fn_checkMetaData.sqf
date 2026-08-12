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

if !(isServer) exitWith {""};
if (hasInterface) exitWith {""};

private _v = params [
	["_arrayItem", ["",-1], [[], ""]]
];

if !(_v) exitWith {""};

private _className = "";
if (_arrayItem isEqualType []) then {
    _className = _arrayItem#0;
};
if (_arrayItem isEqualType "") then {
    _className = _arrayItem;
};
private _defaultClassName = [_className] call ALFTools_Server_MD_T_fnc_getDefaultClassName;
if (_defaultClassName isEqualTo "") exitWith {_className}; // N'est pas méta data
private _config = (configFile >> "ALF_ConfigClient_Core" >> "ALF_MetaData" >> _defaultClassName);
private _allowNodata = getNumber(_config >> "allowNoData");

if (_arrayItem isEqualType "") exitWith {
    if (_allowNodata isEqualTo 0) then {_className = -1};
    _className
};

/* -- Is meta data item -- */
private _data = _arrayItem#1;

if ((_data isEqualTo []) && (_allowNodata isEqualTo 0)) exitWith {-1}; // Is Meta data but no data -> Remove item

_data = (_data#0) createHashMapFromArray (_data#1);

private _newItemClass = [_defaultClassName, _data] call ALFTools_Server_MD_T_fnc_getNewItem;

_newItemClass