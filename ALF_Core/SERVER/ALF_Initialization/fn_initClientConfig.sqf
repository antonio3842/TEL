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

if (isNil "ALF_Config_Core") then {
    ALF_Config_Core = createHashMap;
};

private _manageClass = {
    params["_aConfigPatern", "_aConfig"];

    private _newHashMap = createHashMap;
    {
        _x params["_name", "_type"];
        if (_type isEqualTo "CLASS") then {
            private _newPatern = (_x#2);
            if (_name isEqualTo "ANY") then {
                {
                    private _retHashMap = [_newPatern, _x] call _manageClass;
                    _newHashMap set[_retHashMap#0, _retHashMap#1];
                }forEach ("true" configClasses (_aConfig));
            }else{
                private _newConfig = (_aConfig >> _name);
                private _retHashMap = [_newPatern, _newConfig] call _manageClass;
                _newHashMap set[_retHashMap#0, _retHashMap#1];
            };
            continue;
        };
        private _aValueN = (_aConfig >> _name);
        private _aValue = switch(_type) do {
            case "STRING": {getText(_aValueN)};
            case "NUMBER": {getNumber(_aValueN)};
            case "ARRAY": {getArray(_aValueN)};
            default {getText(_aValueN)};
        };
        _newHashMap set[_name, _aValue];
    }forEach _aConfigPatern;

    [(configName _aConfig), _newHashMap]
};

/* -- Manage allConfig -- */
private _aConfig = (configFile >> "ALF_ConfigClient_Core");
{
    private _getPatern = getArray(_x >> "ALF_ConfigToClient_Patern");
    private _finalHashMap = [_getPatern, _x] call _manageClass;

    ALF_Config_Core set[_finalHashMap#0, _finalHashMap#1];
}forEach ("isClass _x" configClasses (_aConfig));

publicVariable "ALF_Config_Core";