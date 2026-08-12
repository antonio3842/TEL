/*
    File: fn_tempMarker.sqf
    Tag  : MRPV2
    Env  : Client
    Desc : Crée un marqueur local temporaire pendant _duration secondes.
*/

params [
    ["_pos", [0,0,0], [[]]],
    ["_text", "Marqueur", [""]],
    ["_duration", 300, [0]]
];

private _mkrName = format ["mkr_temp_%1_%2", diag_tickTime, round (random 99999)];
private _mkr = createMarkerLocal [_mkrName, _pos];
_mkr setMarkerTypeLocal "mil_warning";
_mkr setMarkerColorLocal "ColorRed";
_mkr setMarkerTextLocal _text;
_mkr setMarkerAlphaLocal 1;

// Effet de pulsation (optionnel) + suppression
[_mkrName, _duration] spawn {
    params ["_name", "_dur"];
    private _t0 = time;
    while { time - _t0 < _dur } do {
        private _a = 0.6 + 0.4 * abs (sin time);
        _name setMarkerAlphaLocal _a;
        uiSleep 0.3;
    };
    deleteMarkerLocal _name;
};
