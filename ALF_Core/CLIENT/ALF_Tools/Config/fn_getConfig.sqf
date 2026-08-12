/*
    GET YOUR PATH
    Code written by Association law 1901 "GET YOUR PATH" (RNA W252007073)
    Statement from the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403
    @Copyright GET YOUR PATH (https://www.getyourpath.fr)
    YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
    More informations : https://www.bistudio.com/community/game-content-usage-rules
    Contact : kainnon@getyourpath.fr
*/

if (isServer && !hasInterface) exitWith {""};

private _v = params[
    ["_type", "", [""]],
    ["_arrayPath", [], [[], createHashMap]],
    "_defaultConfig"
];

if !(_v) exitWith {""};

if (isNil "ALF_Config_Core") then {
    ALF_Config_Core = createHashMap;
};

private _hashMap = ALF_Config_Core;

if !(isNil "_defaultConfig") then {
    _hashMap = _defaultConfig
};

private _defaultValue = switch (_type) do {
    case "NUMBER": {0};
    case "getNumber": {0};
    case "STRING": {""};
    case "getText": {""};
    case "ARRAY": {[]};
    case "getArray": {[]};
    case "CLASSES": {createHashMap};
    case "CLASS": {createHashMap};
    default {""};
};

private _returnValue = _defaultValue;
{
    /* -- Check if is the last of the array -- */
    if(_forEachIndex isEqualTo (count _arrayPath) - 1) exitWith {
        _returnValue = _hashMap getOrDefault[_x, _defaultValue];
    };

    _hashMap = _hashMap getOrDefault[_x, createHashMap];
}forEach _arrayPath;

if (_type isEqualTo "CLASSES") then {
    if !(_returnValue isEqualType createHashMap) exitWith {_returnValue = _defaultValue};
    private _newHashmap = createHashMap;
    {
        if !(_y isEqualType createHashMap) then {continue};

        _newHashmap set[_x,_y];
    }forEach _returnValue;

    _returnValue = _newHashmap;
};

_returnValue