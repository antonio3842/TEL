/*
    Patrouille de France - Fumigènes côté client
    Appelé via remoteExec depuis le serveur sur tous les clients
    Crée des sources de particules locales attachées aux avions

    Params: [_planes, _smokeColors]
*/

params [
    ["_planes", [], [[]]],
    ["_smokeColors", [], [[]]]
];

if (count _planes == 0) exitWith {};

{
    private _plane = _x;
    private _color = _smokeColors select _forEachIndex;
    if (isNull _plane) then { continue };

    private _source = "#particlesource" createVehicleLocal [0,0,0];
    _source attachTo [_plane, [0, -6, -1]];

    _source setParticleParams [
        ["\A3\data_f\ParticleEffects\Universal\Universal.p3d", 16, 12, 8, 1],
        "",
        "Billboard",
        1,
        12,
        [0, 0, 0],
        [0, 0, 0],
        0,
        1.275,
        0.66,
        0.15,
        [4, 8, 14],
        [
            [_color select 0, _color select 1, _color select 2, 0.8],
            [_color select 0, _color select 1, _color select 2, 0.5],
            [_color select 0, _color select 1, _color select 2, 0]
        ],
        [1000],
        0,
        0,
        "",
        "",
        _plane,
        0,
        false,
        -1,
        [[0, 0, 0, 0]]
    ];

    _source setParticleRandom [
        2,
        [1, 1, 0],
        [0.5, 0.5, 0],
        0,
        0.5,
        [0, 0, 0, 0],
        0,
        0,
        0
    ];

    _source setDropInterval 0.015;

    // Stocker la source pour nettoyage futur
    private _sources = player getVariable ["MRP_PAF_localSmoke", []];
    _sources pushBack _source;
    player setVariable ["MRP_PAF_localSmoke", _sources];
} forEach _planes;