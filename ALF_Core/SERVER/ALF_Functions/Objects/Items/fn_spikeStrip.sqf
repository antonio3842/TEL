/*
	File: fn_spikeStrip.sqf
	Author: ALF TEAM
*/
params [
    ["_spikeStrip", objNull, [objNull]]
];
if (isNull _spikeStrip) exitWith {};

while {!isNull _spikeStrip} do {
    // Rayon de lineIntersectsSurfaces : ligne perpendiculaire au spike strip, taille basee sur la geo
    private _bb = boundingBoxReal _spikeStrip;
    private _halfWidth = abs (((_bb select 1) select 0) max ((_bb select 0) select 0));
    private _pos_Debut = AGLtoASL (_spikeStrip getRelPos [_halfWidth, 90]);
    private _pos_Fin = AGLtoASL (_spikeStrip getRelPos [-_halfWidth, 90]);
    _pos_Debut = _pos_Debut vectorAdd [0,0,0.1];
    _pos_Fin = _pos_Fin vectorAdd [0,0,0.1];

    // Fallback haute vitesse (>180 km/h) : lineIntersectsSurfaces peut rater
    private _liste_Veh_Rapide = vehicles select {
        _x isKindOf "Car_F" && {_x distance _spikeStrip < 5 && {speed _x > 180}}
    };

    {
        private _veh = _x;
        private _dans_Zone = _veh inArea [_spikeStrip, 2, 2.5, (getDir _spikeStrip) + 90, true, 10];

        if (_dans_Zone) exitWith {
            [_veh, ["HitLFWheel", 1.0]] remoteExecCall ["setHitPointDamage", _veh];
            [_veh, ["HitRFWheel", 1.0]] remoteExecCall ["setHitPointDamage", _veh];
            [_veh, ["HitLBWheel", 1.0]] remoteExecCall ["setHitPointDamage", _veh];
            [_veh, ["HitRBWheel", 1.0]] remoteExecCall ["setHitPointDamage", _veh];
            playSound3D ["A3\Sounds_F\arsenal\sfx\bullet_hits\tyre_08.wss", _veh, false, AGLtoASL (getPos _veh), 1, 1, 100];
            deleteVehicle _spikeStrip;
        };
    } forEach _liste_Veh_Rapide;

    if (isNull _spikeStrip) exitWith {};

    // Detection precise par rayon geometrique
    private _liste_Intersection = lineIntersectsSurfaces [_pos_Debut, _pos_Fin, _spikeStrip, objNull, true, 5, "GEOM", "NONE", false];

    {
        private _veh = _x # 2;
        private _selection = _x # 4;

        if (_veh isKindOf "Car_F" && {str _selection find "wheel" != -1}) exitWith {
            [_veh, ["HitLFWheel", 1.0]] remoteExecCall ["setHitPointDamage", _veh];
            [_veh, ["HitRFWheel", 1.0]] remoteExecCall ["setHitPointDamage", _veh];
            [_veh, ["HitLBWheel", 1.0]] remoteExecCall ["setHitPointDamage", _veh];
            [_veh, ["HitRBWheel", 1.0]] remoteExecCall ["setHitPointDamage", _veh];
            playSound3D ["A3\Sounds_F\arsenal\sfx\bullet_hits\tyre_08.wss", _veh, false, AGLtoASL (getPos _veh), 1, 1, 100];
            deleteVehicle _spikeStrip;
        };
    } forEach _liste_Intersection;

    sleep 0.01;
};
