/*
    File: fn_asyncCall.sqf
*/
params [
	["_queryStmt","",[""]],
	["_mode",1,[0]],
    ["_multiarr",false,[false]]
];

private _key = "extDB3" callExtension format ["%1:%2:%3",_mode,call life_sql_id,_queryStmt];

if (_mode isEqualTo 1) exitWith {true};

_key = call compile format ["%1",_key];
_key = (_key select 1);
private _queryResult = "extDB3" callExtension format ["4:%1", _key];

//Make sure the data is received
// Note: Pas de sleep possible ici (contexte non-scheduled via call)
// La boucle est protégée par un compteur max et extDB3 a sa propre latence I/O
if (_queryResult isEqualTo "[3]") then {
    private _maxIter = 100000;
    private _iter = 0;
    for "_i" from 0 to 1 step 0 do {
        _iter = _iter + 1;
        if (_iter > _maxIter) exitWith {diag_log "extDB3: asyncCall timeout waiting for result [3]"};
        if (!(_queryResult isEqualTo "[3]")) exitWith {};
        _queryResult = "extDB3" callExtension format ["4:%1", _key];
    };
};

// Multi-Part Message handling
// Note: Pas de sleep possible ici (contexte non-scheduled via call)
if (_queryResult isEqualTo "[5]") then {
    private _loop = true;
    private _maxIterOuter = 10000;
    private _iterOuter = 0;
    for "_i" from 0 to 1 step 0 do { // extDB3 returned that result is Multi-Part Message
        _iterOuter = _iterOuter + 1;
        if (_iterOuter > _maxIterOuter) exitWith {diag_log "extDB3: asyncCall timeout outer loop [5]"};
        _queryResult = "";
        private _maxIterInner = 100000;
        private _iterInner = 0;
        for "_i" from 0 to 1 step 0 do {
            _iterInner = _iterInner + 1;
            if (_iterInner > _maxIterInner) exitWith {_loop = false; diag_log "extDB3: asyncCall timeout inner loop [5]"};
            _pipe = "extDB3" callExtension format ["5:%1", _key];
            if (_pipe isEqualTo "") exitWith {_loop = false};
            _queryResult = _queryResult + _pipe;
        };
        if (!_loop) exitWith {};
    };
};

_queryResult = call compile _queryResult;
if ((_queryResult select 0) isEqualTo 0) exitWith {diag_log format ["extDB3: Protocol Error: %1", _queryResult]; []};

private _return = (_queryResult select 1);
if (!_multiarr && {count _return > 0}) then {
    _return = (_return select 0);
};

_return;