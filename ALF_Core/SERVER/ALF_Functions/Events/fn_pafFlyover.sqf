#include "\ALF_Core\SERVER\script_macros.hpp"
/*
    Patrouille de France - Flyover Event
    Spawn 7 Alpha Jets en formation flèche (chevron)
    Fumigènes Bleu Blanc Rouge visibles depuis le sol
    2 gauche = BLEU | 3 centre = BLANC | 2 droite = ROUGE

    Console debug (F4, Server) : [] spawn ALF_Server_fnc_pafFlyover;
*/

if (!isServer) exitWith {};

params [
    ["_altitude", 260, [0]]
];

// --- Anti-spam : un seul flyover à la fois ---
if (!isNil "MRP_PAF_active" && {MRP_PAF_active}) exitWith {
    diag_log "[PAF] Flyover déjà en cours, annulé.";
};
MRP_PAF_active = true;

// --- Configuration ---
private _speed = 80;            // m/s (environ 290 km/h)
private _spacing = 35;          // Espacement entre avions (mètres)
private _despawnDist = 100;     // Distance du dernier waypoint pour despawn

// Trajet multi-waypoints (2D, l'altitude est gérée séparément)
private _waypoints = [
    [10773.5, -337.75],   // Spawn
    [5639.8, 4886.5],     // WP1
    [4406.29, 7565.16],   // WP2
    [2410.16, 11360]      // WP3 (despawn)
];

private _startPos = _waypoints select 0;
private _lastPos = _waypoints select (count _waypoints - 1);

// Classnames des 7 avions PAF
private _classnames = [
    "MRP_PAF",   // 1 - Leader
    "MRP_PAF2",  // 2 - Droite rang 1
    "MRP_PAF3",  // 3 - Gauche rang 1
    "MRP_PAF4",  // 4 - Droite rang 2
    "MRP_PAF5",  // 5 - Gauche rang 2
    "MRP_PAF6",  // 6 - Droite rang 3
    "MRP_PAF7"   // 7 - Gauche rang 3
];

// --- Formation flèche (chevron) ---
//        1 (leader)
//      3   2
//    5       4
//  7           6
private _formationOffsets = [
    [0, 0],                                         // 1 - Leader (centre)
    [_spacing, -_spacing],                           // 2 - Droite rang 1
    [-_spacing, -_spacing],                          // 3 - Gauche rang 1
    [_spacing * 2, -_spacing * 2],                   // 4 - Droite rang 2
    [-_spacing * 2, -_spacing * 2],                  // 5 - Gauche rang 2
    [_spacing * 3, -_spacing * 3],                   // 6 - Droite rang 3
    [-_spacing * 3, -_spacing * 3]                   // 7 - Gauche rang 3
];

// Couleurs fumigène par avion : [R, G, B, A]
// 7, 5 = BLEU | 3, 1, 2 = BLANC | 4, 6 = ROUGE
private _smokeColors = [
    [1, 1, 1, 1],             // 1 - Leader : BLANC
    [1, 1, 1, 1],             // 2 - Droite rang 1 : BLANC
    [1, 1, 1, 1],             // 3 - Gauche rang 1 : BLANC
    [0.8, 0.05, 0.05, 1],    // 4 - Droite rang 2 : ROUGE
    [0.05, 0.15, 0.8, 1],    // 5 - Gauche rang 2 : BLEU
    [0.8, 0.05, 0.05, 1],    // 6 - Droite rang 3 : ROUGE
    [0.05, 0.15, 0.8, 1]     // 7 - Gauche rang 3 : BLEU
];

// Direction initiale (spawn → premier WP)
private _dir = _startPos getDir (_waypoints select 1);

diag_log "[PAF] Démarrage du flyover Patrouille de France";

// --- Dégager le ciel avec transition rapide ---
0 setOvercast 0;
0 setFog 0;
uiSleep 15;

// --- Spawn des avions ---
private _planes = [];

{
    private _idx = _forEachIndex;
    private _offset = _formationOffsets select _idx;
    private _latOff = _offset select 0;
    private _lonOff = _offset select 1;

    private _spawnX = (_startPos select 0) + (_lonOff * (sin _dir)) + (_latOff * (cos _dir));
    private _spawnY = (_startPos select 1) + (_lonOff * (cos _dir)) - (_latOff * (sin _dir));
    private _spawnPos = [_spawnX, _spawnY, _altitude];

    private _plane = createVehicle [_x, _spawnPos, [], 0, "FLY"];
    _plane allowDamage false;
    _plane flyInHeight _altitude;
    _plane setDir _dir;
    _plane engineOn true;
    _plane lock true;
    _plane setFuel 1;

    createVehicleCrew _plane;
    {_x allowDamage false} forEach crew _plane;

    private _grp = group (driver _plane);
    _grp setBehaviourStrong "CARELESS";

    _planes pushBack _plane;
    diag_log format ["[PAF] Avion %1 (#%2) spawné pos [%3, %4, %5] dir %6", _x, _idx + 1, round _spawnX, round _spawnY, _altitude, round _dir];
} forEach _classnames;

// --- Waypoints : chaque avion a ses propres WP avec offset de formation ---
{
    private _planeIdx = _forEachIndex;
    private _offset = _formationOffsets select _planeIdx;
    private _latOff = _offset select 0;
    private _lonOff = _offset select 1;
    private _grp = group (driver _x);

    {
        if (_forEachIndex > 0) then {
            private _wpDir = (_waypoints select (_forEachIndex - 1)) getDir _x;
            private _wpX = (_x select 0) + (_lonOff * (sin _wpDir)) + (_latOff * (cos _wpDir));
            private _wpY = (_x select 1) + (_lonOff * (cos _wpDir)) - (_latOff * (sin _wpDir));
            private _wp = _grp addWaypoint [[_wpX, _wpY, 0], 0];
            _wp setWaypointType "MOVE";
            _wp setWaypointSpeed "FULL";
        };
    } forEach _waypoints;
} forEach _planes;

// --- Lancer tous les avions en même temps ---
{_x setVelocityModelSpace [0, _speed, 0]} forEach _planes;

diag_log format ["[PAF] Flyover lancé - %1 avions, %2 waypoints", count _planes, count _waypoints];

// --- Fumigènes ---
uiSleep 2;
[_planes, _smokeColors] remoteExec ["ALF_fnc_pafSmoke", 0, true];
diag_log "[PAF] Fumigènes envoyés aux clients";

// --- Boucle principale : formation forcée + vitesse + despawn ---
private _active = true;

while {_active} do {
    private _leader = _planes select 0;
    if (isNull _leader) exitWith { _active = false; };

    // Despawn si le leader est proche du dernier waypoint
    if ((_leader distance2D _lastPos) < _despawnDist) exitWith {
        _active = false;
    };

    // Maintenir la vitesse sur chaque avion
    {
        if (!isNull _x) then {
            _x setVelocityModelSpace [0, _speed, 0];
        };
    } forEach _planes;

    uiSleep 0.5;
};

diag_log "[PAF] Fin du survol - Nettoyage en cours";

// --- Despawn ---
uiSleep 5;

{
    if (!isNull _x) then {
        {deleteVehicle _x} forEach crew _x;
        deleteVehicle _x;
    };
} forEach _planes;

MRP_PAF_active = false;

diag_log "[PAF] Nettoyage terminé - Event PAF fini";
