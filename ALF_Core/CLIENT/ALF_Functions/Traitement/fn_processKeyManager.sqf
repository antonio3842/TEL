params [
    ["_display",displayNull],
    ["_key",-1,[0]],
    ["_shift",false,[false]],
    ["_ctrl",false,[false]],
    ["_alt",false,[false]]
];

if (uiNamespace getVariable ["ALF_QTE_Failure", false]) exitWith {};

_qteKeys = uiNamespace getVariable ["ALF_QTE", []];
if (_qteKeys isEqualTo []) exitWith {};

_qteRank = uiNamespace getVariable ["ALF_QTE_Rank", 0];

_display = findDisplay 46;
if (_key in _qteKeys) then {
    if (_key isEqualTo (_qteKeys select _qteRank)) then {
        uiNamespace setVariable ["ALF_QTE_Success", true];
        _idc = 20000 + _qteRank;
        _ctrl = _display displayCtrl _idc;
        _last_text = ctrlText _ctrl;
        _ctrl ctrlSetText ((_last_text select [0, (count _last_text) - 4]) + "_V.paa");
        uiNamespace setVariable ["ALF_QTE_Rank", _qteRank + 1];
    } else {
        uiNamespace setVariable ["ALF_QTE_Failure", true];
        for "_i" from 20000 to 20004 do {
            _ctrl = _display displayCtrl _i;
            _last_text = ctrlText _ctrl;

            _rank = _i - 20000;
            if (_rank < _qteRank) then {
                _ctrl ctrlSetText ((_last_text select [0, (count _last_text) - 6]) + "_R.paa" );
            } else {
                _ctrl ctrlSetText ((_last_text select [0, (count _last_text) - 4]) + "_R.paa" );
            };
            
        };
    };
    true
} else {
    false; 
};