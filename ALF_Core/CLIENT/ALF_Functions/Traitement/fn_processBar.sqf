params [
    "_totalTime", 
    "_args", 
    "_onFinish", 
    "_onFail", 
    ["_localizedTitle", ""]
];

private _barW = 0.5;
private _barH = 0.04;
private _barX = safeZoneX + (safeZoneW - _barW) / 2;
private _barY = safeZoneY + (safeZoneH - _barH) / 2;

private _display = findDisplay 46;
waitUntil { !isNull _display };
private _progressBar = _display ctrlCreate ["RscProgress", -1];
_progressBar ctrlSetPosition [_barX, _barY, _barW, _barH];
_progressBar ctrlSetBackgroundColor [0, 0, 0, 0.5];
_progressBar ctrlCommit 0;
_progressBar progressSetPosition 0;

private _frame = _display ctrlCreate ["RscFrame", -1];
_frame ctrlSetPosition [_barX, _barY, _barW, _barH];
_frame ctrlSetTextColor [0, 0, 0, 1]; // Couleur de la bordure (Blanc ici)
_frame ctrlCommit 0;

private _text = _display ctrlCreate ["RscStructuredText", -1];
_text ctrlSetPosition [_barX, _barY - 0.05, _barW*1.05, _barH*1.05];
_text ctrlSetStructuredText parseText format ["<t align='center' size='1.2'>%1 | %2 s</t>", _localizedTitle, ceil _totalTime];
_text ctrlCommit 0;

private _cP = 0;
_time_to_sleep = (_totalTime/1000);
for "_i" from 0 to 1000 do {
    if (!alive player || player != vehicle player) exitWith {};
    if (uiNamespace getVariable ["ALF_QTE_Success", false]) then {
        _i = _i + (1000*0.1);
        uiNamespace setVariable ["ALF_QTE_Success", false];
    };
    if (_i > 1000) then {_i = 1000};
    _cP = _i / 1000;
    _text ctrlSetStructuredText parseText format ["<t align='center' size='1.2'>%1 | %2 s</t>", _localizedTitle, ceil ((1000-_i)/1000*_totalTime)];
    _progressBar progressSetPosition _cP;
    uiSleep _time_to_sleep;
};

if (alive player and vehicle player isEqualTo player) then {
    [] call _onFinish;
} else {
    [] call _onFail;
};

ctrlDelete _frame;
ctrlDelete _progressBar;
ctrlDelete _text;
life_action_inUse = false;