/*
    GET YOUR PATH
    Code written by Association law 1901 "GET YOUR PATH" (RNA W252007073)
    Statement from the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403
    @Copyright GET YOUR PATH (https://www.getyourpath.fr)
    YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
    More informations : https://www.bistudio.com/community/game-content-usage-rules
    Contact : kainnon@getyourpath.fr
*/

if !(hasInterface) exitWith {false};

private _v = params[
    ["_arrayToClass", [], [[]]],
    "_defaultConfig"
];

if !(_v) exitWith {false};

private _Hashmap = ALF_Config_Core;

if !(isNil "_defaultConfig") then {
    _Hashmap = _defaultConfig
};

private _returnValue = false;

{
    /* -- Check if is the last of the array -- */
    if(_forEachIndex isEqualTo (count _arrayToClass) - 1) exitWith {
        if (_x in _Hashmap) then {
            private _dataVal = _Hashmap getOrDefault [_x, ""];
            if (_dataVal isEqualType createHashMap) then {_returnValue = true};
        };
    };

    _Hashmap = _Hashmap getOrDefault[_x, createHashMap];
}forEach _arrayToClass;

_returnValue