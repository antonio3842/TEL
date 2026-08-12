/*
    ALF_Server_fnc_spawnAlgues
    Système de spawn d'algues amélioré avec respawn immédiat
    
    Fonctionnalités:
    - Spawn initial de 60 algues
    - Respawn immédiat quand une algue est ramassée
    - Distance minimale entre algues
    - Gestion globale des positions
    - Logs pour le debug
*/
[] spawn {
    if !(isServer) exitWith {};

    // === CONFIGURATION ===
    private _magClass = "algues";
    private _center   = [5683.64, 1761.83, 0.2];
    private _radius   = 30;
    private _count    = 60;
    private _minDepth = 0.10;
    private _maxDepth = 1.00;
    private _maxTry   = 250;
    private _minDistBetween = 3; // Distance minimale entre deux algues

    private _avoidTypes = ["TREE","ROCK","BUSH"];
    private _avoidDist  = 2;

    private _enableSimAfter = true;
    private _epsZ          = 0.02;
    private _stabilizeTime = 0.10;
    private _nearTypesDyn  = ["Man","Ship","Car","Tank","Submarine","Air"];
    private _nearDynDist   = 5;

    // Délai entre spawns initiaux (évite les lags)
    private _spawnDelay = 0.1; // secondes

    // === VÉRIFICATIONS INITIALES ===
    if !(isClass (configFile >> "CfgMagazines" >> _magClass)) exitWith {
        diag_log format ["[ALGUES] ERREUR: Classe magazine '%1' introuvable", _magClass];
    };

    diag_log format ["[ALGUES] Initialisation: %1 algues à spawner dans un rayon de %2m", _count, _radius];

    // Liste globale des positions déjà utilisées
    ALGUE_spawnedPositions = [];
    missionNamespace setVariable ["ALGUE_spawnedPositions", ALGUE_spawnedPositions, true];

    // Configuration complète (stockée globalement pour le respawn)
    private _cfg = [
        _magClass,_center,_radius,_minDepth,_maxDepth,_maxTry,_avoidTypes,_avoidDist,
        _enableSimAfter,_epsZ,_stabilizeTime,_nearTypesDyn,_nearDynDist,_minDistBetween
    ];
    missionNamespace setVariable ["ALGUE_config", _cfg, true];

    // === FONCTIONS GLOBALES ===
    
    // Fonction optimisée pour vérifier si un holder est vide (vérifie seulement magazineCargo car c'est ce qu'on utilise)
    private _fnIsEmpty = {
        params ["_h"];
        if (isNull _h) exitWith {true};
        try {
            (magazineCargo _h isEqualTo [])
        } catch {
            true
        };
    };
    missionNamespace setVariable ["ALGUE_fnc_isEmpty", _fnIsEmpty, true];

    // Fonction optimisée pour vérifier si une position est valide (utilise exitWith pour sortir rapidement)
    private _fnIsPositionValid = {
        params ["_posATL", "_spawnedPositions", "_minDist"];
        if (_spawnedPositions isEqualTo []) exitWith { true };
        private _minDistSq = _minDist * _minDist; // Pré-calculer le carré pour éviter sqrt
        {
            private _dx = (_posATL#0) - (_x#0);
            private _dy = (_posATL#1) - (_x#1);
            if ((_dx*_dx + _dy*_dy) < _minDistSq) exitWith { false };
        } forEach _spawnedPositions;
        true
    };
    missionNamespace setVariable ["ALGUE_fnc_isPositionValid", _fnIsPositionValid, true];

    // Fonction optimisée pour trouver une position valide
    private _fnFindPos = {
        params ["_centerATL","_radius","_maxTry","_minDepth","_maxDepth","_avoidTypes","_avoidDist","_spawnedPositions","_minDistBetween"];
        private _fnIsPositionValid = missionNamespace getVariable ["ALGUE_fnc_isPositionValid", {}];
        private _radiusSq = _radius * _radius; // Pré-calculer pour optimisation
        private _centerX = _centerATL#0;
        private _centerY = _centerATL#1;
        private _tries = 0;
        private _posATL = [0,0,0];
        private _posASL = [0,0,0];
        private _zBottom = 0;

        while {_tries < _maxTry} do {
            _tries = _tries + 1;
            private _a = random 360;
            private _d = sqrt random 1 * _radius;
            private _sinA = sin _a;
            private _cosA = cos _a;
            _posATL = [_centerX + _sinA*_d, _centerY + _cosA*_d, 0];
            _posASL = ATLToASL _posATL;

            if !(surfaceIsWater _posASL) then { continue };
            _zBottom = getTerrainHeightASL [_posATL#0, _posATL#1];
            private _depth = 0 - _zBottom;
            if !(_depth >= _minDepth && {_depth <= _maxDepth}) then { continue };
            if !((nearestTerrainObjects [_posATL, _avoidTypes, _avoidDist, false, true]) isEqualTo []) then { continue };
            if !([_posATL, _spawnedPositions, _minDistBetween] call _fnIsPositionValid) then { continue };

            _posASL set [2, _zBottom];
            break;
        };

        if (_tries >= _maxTry) exitWith { [false, [0,0,0], [0,0,0]] };
        [true, _posATL, _posASL]
    };
    missionNamespace setVariable ["ALGUE_fnc_findPos", _fnFindPos, true];

    // Fonction optimisée pour spawner un holder stable
    private _fnSpawnStable = {
        params ["_mag","_posATL","_posASL","_epsZ","_stabilizeTime","_enableSimAfter","_nearTypesDyn","_nearDynDist"];

        private _holder = objNull;
        try {
            _holder = createVehicle ["GroundWeaponHolder_Scripted",[0,0,0],[],0,"NONE"];
            if (isNull _holder) exitWith { objNull };

            _holder allowDamage false;
            _holder enableSimulationGlobal false;

            private _dyn = nearestObjects [_posATL, _nearTypesDyn, _nearDynDist, false];
            { _holder disableCollisionWith _x } forEach _dyn;

            _holder setVectorUp (surfaceNormal _posATL);
            _holder setVelocityModelSpace [0,0,0];
            _holder setPosASL [_posASL#0, _posASL#1, (_posASL#2) + _epsZ];

            // On clear seulement ce qui est nécessaire puisqu'on utilise seulement magazines
            clearMagazineCargoGlobal _holder;
            _holder addMagazineCargoGlobal [_mag, 1];
            _holder setVariable ["ALF_persistent", true, true];
            _holder hideObjectGlobal false;

            // Stabilisation dans un spawn séparé (optimisé pour ne lancer que si nécessaire)
            if (_enableSimAfter || _stabilizeTime > 0) then {
                [_holder, _stabilizeTime, _enableSimAfter, _dyn] spawn {
                    params ["_h", "_stabilizeTime", "_enableSimAfter", "_dyn"];
                    if (_stabilizeTime > 0) then { uiSleep _stabilizeTime; };
                    if (!isNull _h) then {
                        _h setVelocityModelSpace [0,0,0];
                        if (_enableSimAfter) then { _h enableSimulationGlobal true; };
                        { _h enableCollisionWith _x } forEach _dyn;
                    };
                };
            };
        } catch {
            diag_log format ["[ALGUES] ERREUR lors du spawn stable: %1", _exception];
            if (!isNull _holder) then { deleteVehicle _holder; };
            _holder = objNull;
        };

        _holder
    };
    missionNamespace setVariable ["ALGUE_fnc_spawnStable", _fnSpawnStable, true];

    // Fonction principale optimisée pour spawner une algue (utilisable depuis le respawn)
    private _fnSpawnOne = {
        if (!isServer) exitWith { objNull };
        
        // Récupérer la configuration et les fonctions une seule fois (mise en cache)
        private _cfg = missionNamespace getVariable ["ALGUE_config", []];
        if (_cfg isEqualTo []) exitWith { objNull };
        
        _cfg params [
            "_magClass","_center","_radius","_minDepth","_maxDepth","_maxTry","_avoidTypes","_avoidDist",
            "_enableSimAfter","_epsZ","_stabilizeTime","_nearTypesDyn","_nearDynDist","_minDistBetween"
        ];

        // Récupérer les fonctions globales une seule fois
        private _fnFindPos = missionNamespace getVariable ["ALGUE_fnc_findPos", {}];
        private _fnSpawnStable = missionNamespace getVariable ["ALGUE_fnc_spawnStable", {}];
        
        if (_fnFindPos isEqualTo {} || _fnSpawnStable isEqualTo {}) exitWith { objNull };

        // Récupérer la liste globale des positions (référence directe)
        private _globalPositions = missionNamespace getVariable ["ALGUE_spawnedPositions", []];

        // Trouver une position valide
        private _res = [_center,_radius,_maxTry,_minDepth,_maxDepth,_avoidTypes,_avoidDist,_globalPositions,_minDistBetween] call _fnFindPos;
        if !(_res#0) exitWith { objNull };

        private _posATL = _res#1;
        private _posASL = _res#2;

        // Spawner le holder
        private _holder = [_magClass,_posATL,_posASL,_epsZ,_stabilizeTime,_enableSimAfter,_nearTypesDyn,_nearDynDist] call _fnSpawnStable;
        if (isNull _holder) exitWith { objNull };

        // Ajouter la position à la liste globale
        _globalPositions pushBack _posATL;
        ALGUE_spawnedPositions = _globalPositions; // Mettre à jour la référence globale

        // Script de respawn optimisé
        [_holder, _posATL] spawn {
            params ["_h","_posATL"];
            
            // Récupérer les fonctions une seule fois (mise en cache)
            private _fnIsEmpty = missionNamespace getVariable ["ALGUE_fnc_isEmpty", {}];
            private _fnSpawnOne = missionNamespace getVariable ["ALGUE_fnc_spawnOne", {}];
            
            if (_fnIsEmpty isEqualTo {} || _fnSpawnOne isEqualTo {}) exitWith {};

            // Attendre que l'algue soit ramassée (optimisé : vérification plus efficace)
            waitUntil { 
                uiSleep 0.3; // Intervalle légèrement augmenté pour réduire la charge CPU
                isNull _h || { 
                    try {
                        if (isNull _h) exitWith { true };
                        [_h] call _fnIsEmpty
                    } catch {
                        true
                    }
                } 
            };

            // Supprimer le holder et retirer la position
            if (!isNull _h) then { 
                deleteVehicle _h;
            };
            
            // Optimisation : utiliser directement la référence globale
            private _globalPositions = ALGUE_spawnedPositions;
            if (isNil "_globalPositions") then {
                _globalPositions = missionNamespace getVariable ["ALGUE_spawnedPositions", []];
            };
            
            private _index = _globalPositions findIf { 
                private _dx = (_x#0) - (_posATL#0);
                private _dy = (_x#1) - (_posATL#1);
                (_dx*_dx + _dy*_dy) < 1 // distance2D < 1 sans sqrt
            };
            if (_index >= 0) then {
                _globalPositions deleteAt _index;
            };

            // Spawn immédiat d'une nouvelle algue
            uiSleep 0.05; // Délai minimal pour éviter les problèmes
            private _newHolder = [] call _fnSpawnOne;
        };

        _holder
    };
    missionNamespace setVariable ["ALGUE_fnc_spawnOne", _fnSpawnOne, true];

    // === SPAWN INITIAL ===
    private _spawned = 0;
    private _failed = 0;
    private _fnSpawnOne = missionNamespace getVariable ["ALGUE_fnc_spawnOne", {}];
    
    for "_i" from 1 to _count do {
        private _holder = [] call _fnSpawnOne;
        if (!isNull _holder) then {
            _spawned = _spawned + 1;
        } else {
            _failed = _failed + 1;
        };
        
        if (_i < _count) then {
            uiSleep _spawnDelay;
        };
    };

    diag_log format ["[ALGUES] Spawn terminé: %1 réussis, %2 échoués sur %3 tentatives", _spawned, _failed, _count];
};
