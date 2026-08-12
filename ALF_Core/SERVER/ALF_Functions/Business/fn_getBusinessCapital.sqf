//ALF_Server_fnc_getBusinessCapital = {


params ["_siret"];

if (isNil "_siret" || {_siret isEqualTo ""}) exitWith {
    ["[SERVER][BUSINESS] ❌ SIRET vide"] remoteExec ["systemChat", -2];
    0
};

["[SERVER][BUSINESS] getBusinessCapital → SIRET : " + str _siret] remoteExec ["systemChat", -2];

private _query = format ["SELECT capital FROM business WHERE siret='%1' AND active='1'", _siret];
["[SERVER][BUSINESS] SQL QUERY : " + _query] remoteExec ["systemChat", -2];

private _result = [_query, 2] call ALF_Server_fnc_asyncCall;
["[SERVER][BUSINESS] SQL RAW RESULT : " + str _result] remoteExec ["systemChat", -2];

if (!(_result isEqualType []) || {count _result == 0}) exitWith {
    ["[SERVER][BUSINESS] ❌ Aucun résultat → return 0"] remoteExec ["systemChat", -2];
    0
};

// extDB3 structure : [["107500"]]
private _row = _result select 0;
private _capitalStr = _row select 0;

private _capital = parseNumber _capitalStr;
["[SERVER][BUSINESS] ✔ CAPITAL PARSÉ : " + str _capital] remoteExec ["systemChat", -2];

_capital



//};