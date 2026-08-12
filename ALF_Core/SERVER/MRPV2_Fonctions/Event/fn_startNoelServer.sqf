/*
if (!isServer) exitWith {};

diag_log "============================";
diag_log "[NOEL] 🎄 START EVENT SERVEUR (VERSION SIMPLE)";
diag_log "============================";

// ===============================
// 🌦 MÉTÉO NOËL
// ===============================

//0 setOvercast 0.8;
//0 setFog 0.3;
//forceWeatherChange;

diag_log "[NOEL] 🌦 Météo Noël appliquée";

// Neige client + icône (gérée dans le client)
[] remoteExec ["MRPV2_fnc_dropNoelGift", 0, true];


// ===============================
// CONFIG CADEAUX + ZONES
// ===============================

private _giftItems = [
    "MRP_Item_O2_Kdo_rouge","MRP_Item_O2_Kdo_Bleu","MRP_Item_O2_Kdo_Vert","MRP_Item_O2_Kdo_Rose",
    "MRP_Item_O2_Gros_Kdo_Rouge","MRP_Item_O2_Gros_Kdo_Bleu","MRP_Item_O2_Gros_Kdo_Vert","MRP_Item_O2_Gros_Kdo_Rose"
];

private _giftVisuals = [
    "Land_MRP_O2_Gros_Kdo","Land_MRP_O2_Kdo","Land_MRP_O2_Gros_Kdo_Bleu","Land_MRP_O2_Kdo_Bleu",
    "Land_MRP_O2_Gros_Kdo_Vert","Land_MRP_O2_Kdo_Vert","Land_MRP_O2_Gros_Kdo_Rose","Land_MRP_O2_Kdo_Rose"
];

private _dropZones = [
    [[6665.21, 3520.87, 0], 4000],
    [[4020.46, 8103.71, 0], 4000]
];

private _giftLifeTime = 1800;

diag_log format ["[NOEL] 🎁 DropZones=%1 | Items=%2 | Visuals=%3 | LifeTime=%4",
    count _dropZones, count _giftItems, count _giftVisuals, _giftLifeTime
];


// ===============================
// ✈️ TRAÎNEAU
// ===============================

private _flightStart = [10096, 10080, 120];
private _flightEnd   = [180, 417, 120];

private _grp = createGroup civilian;
private _heli = createVehicle ["C_Christmas_Heli_01_unarmed_F", _flightStart, [], 0, "FLY"];

if (isNull _heli) exitWith {
    diag_log "[NOEL] ❌ Traîneau NON créé (NULL) → vérifie le mod côté serveur";
};

_grp addVehicle _heli;
_heli setPosATL _flightStart;
_heli flyInHeight 120;
_heli move _flightEnd;

diag_log format ["[NOEL] ✈ Traîneau créé : %1 (pos=%2, dest=%3)", _heli, _flightStart, _flightEnd];

// Envoi de l'hélico aux clients pour DrawIcon3D
[_heli] remoteExec ["MRPV2_fnc_dropNoelGift", 0, true];


// ===============================
// 🎁 DROP CADEAU (avec params)
// ===============================

[_dropZones, _giftItems, _giftVisuals, _giftLifeTime] spawn {
    params ["_dropZones","_giftItems","_giftVisuals","_giftLifeTime"];

    diag_log "[NOEL] 🎁 DROP → attente 90s";
    sleep 90;

    private _zone   = selectRandom _dropZones;
    private _center = _zone#0;
    private _radius = _zone#1;

    diag_log format ["[NOEL] 🎁 Zone choisie : center=%1 radius=%2", _center, _radius];

    private _angle = random 360;
    private _dist  = sqrt (random 1) * _radius;

    private _dropPos = [
        _center#0 + (sin _angle) * _dist,
        _center#1 + (cos _angle) * _dist,
        180
    ];

    diag_log format ["[NOEL] 🎁 Position drop aérien = %1", _dropPos];

    private _giftItem  = selectRandom _giftItems;
    private _giftClass = selectRandom _giftVisuals;

    diag_log format ["[NOEL] 🎁 Objet tiré = %1 | Visuel = %2", _giftItem, _giftClass];

    private _para = createVehicle ["Steerable_Parachute_F", _dropPos, [], 0, "FLY"];
    private _gift = createVehicle [_giftClass, _dropPos, [], 0, "CAN_COLLIDE"];

    diag_log format ["[NOEL] 🎁 Parachute=%1 | Gift=%2", _para, _gift];

    _gift attachTo [_para,[0,0,-1.3]];
    _gift setVariable ["NOEL_GIFT_ITEM", _giftItem, true];

    waitUntil { sleep 0.2; (getPosATL _gift # 2) < 5 };

    diag_log "[NOEL] 🎁 Cadeau proche du sol → détachage";

    detach _gift;
    deleteVehicle _para;

    // --- Position sol fiable ---
    private _x = getPosATL _gift # 0;
    private _y = getPosATL _gift # 1;
    private _z = getTerrainHeightASL [_x,_y];

    if (surfaceIsWater [_x,_y,_z]) then {
        _z = 0.2;
    };

    private _pos = [_x,_y,_z];

    _gift setPosASL _pos;
    _gift setVectorUp [0,0,1];

    // 🔒 BLOQUE LA PHYSIQUE
    _gift enableSimulationGlobal false;

    diag_log format ["[NOEL] 🎁 Cadeau posé SOL = %1", _pos];

    // 📌 synchro position client
    _gift setVariable ["NOEL_GIFT_POS", _pos, true];


    [_gift,_giftLifeTime] spawn {
        params ["_gift","_life"];

        sleep _life;

        if (!isNull _gift) then {
            deleteVehicle _gift;
            diag_log "[NOEL] 🎁 Cadeau expiré → delete";
        };
    };
};


// ===============================
// 🧹 CLEANUP TRAÎNEAU
// ===============================

[_heli] spawn {
    params ["_heli"];
    diag_log "[NOEL] ✈ Cleanup traîneau dans 300s";
    sleep 300;
    if (!isNull _heli) then {
        deleteVehicle _heli;
        diag_log "[NOEL] ✈ Traîneau supprimé";
    };
};
*/























// ======================================================
// 🎅 FONCTION SERVEUR : DÉMARRAGE ÉVÉNEMENT NOËL
// ======================================================

if (!isServer) exitWith {
    diag_log "[NOEL] ❌ ERREUR: Fonction appelée côté client!";
};

diag_log "[NOEL] ✅ Fonction serveur appelée";

// ======================================================
// 🔒 LOCK EVENT (ATOMIQUE)
// ======================================================

// Définir le lock immédiatement pour éviter les appels multiples simultanés
if (isNil "MRPV2_NOEL_RUNNING") then {
    MRPV2_NOEL_RUNNING = false;
};

// Vérifier si l'événement est déjà en cours
if (MRPV2_NOEL_RUNNING) exitWith {
    diag_log "[NOEL] Event deja en cours -> abort";
};

// Activer le lock immédiatement
MRPV2_NOEL_RUNNING = true;
publicVariable "MRPV2_NOEL_RUNNING";

diag_log "[NOEL] Lock activé";

diag_log "============================";
diag_log "[NOEL] START EVENT SERVEUR";
diag_log "============================";

// ======================================================
// 🎁 CONFIG CADEAUX
// ======================================================

private _giftItems = [
    "MRP_Item_O2_Kdo_rouge","MRP_Item_O2_Kdo_Bleu","MRP_Item_O2_Kdo_Vert","MRP_Item_O2_Kdo_Rose",
    "MRP_Item_O2_Gros_Kdo_Rouge","MRP_Item_O2_Gros_Kdo_Bleu","MRP_Item_O2_Gros_Kdo_Vert","MRP_Item_O2_Gros_Kdo_Rose"
];

private _giftVisuals = [
    "Land_MRP_O2_Gros_Kdo","Land_MRP_O2_Kdo",
    "Land_MRP_O2_Gros_Kdo_Bleu","Land_MRP_O2_Kdo_Bleu",
    "Land_MRP_O2_Gros_Kdo_Vert","Land_MRP_O2_Kdo_Vert",
    "Land_MRP_O2_Gros_Kdo_Rose","Land_MRP_O2_Kdo_Rose"
];

private _dropZones = [
    [[6665.21,3520.87,0],4000],
    [[4020.46,8103.71,0],4000]
];

private _giftLifeTime = 1800;

// ======================================================
// 🎅 SYNC TRAÎNEAU (PARAMÈTRES UNIQUEMENT)
// ======================================================

// Appel direct au client pour initialiser le script
[] remoteExec ["MRPV2_fnc_dropNoelGift", 0];

MRPV2_NOEL_DATA = [
    [10096,10080,120],     // START ASL
    [180,417,120],         // END ASL
    serverTime + 5,        // départ synchro
    200                    // vitesse m/s
];
publicVariable "MRPV2_NOEL_DATA";

diag_log "[NOEL] Traineau sync (client only)";

// ======================================================
// 🎁 DROP CADEAU SERVEUR
// ======================================================

[_dropZones,_giftItems,_giftVisuals,_giftLifeTime] spawn {
    params ["_zones","_items","_visuals","_life"];

    sleep 90;

    private _zone = selectRandom _zones;
    private _center = _zone#0;
    private _radius = _zone#1;

    private _dropPos = [];
    for "_i" from 1 to 80 do {
        private _a = random 360;
        private _d = sqrt (random 1) * _radius;

        private _p = [
            (_center#0) + (sin _a) * _d,
            (_center#1) + (cos _a) * _d,
            0
        ];

        if (!surfaceIsWater _p) exitWith {
            _dropPos = [_p#0,_p#1,180];
        };
    };

    if (_dropPos isEqualTo []) then {
        diag_log "[NOEL] ❌ Aucun point terrestre trouvé";
    } else {
        private _item  = selectRandom _items;
    private _class = selectRandom _visuals;

    diag_log format [
        "[NOEL] 🎯 Zone sélectionnée | Centre=%1 | Rayon=%2",
        _center,_radius
    ];

    diag_log format ["[NOEL] 🎁 Création cadeau | Classe=%1 | Pos=%2", _class, _dropPos];
    
    // Utiliser GroundWeaponHolder avec l'item car les objets Land ne peuvent pas être créés dynamiquement
    private _gift = createVehicle ["GroundWeaponHolder_Scripted", _dropPos, [], 0, "CAN_COLLIDE"];
    
    if (isNull _gift) then {
        diag_log "[NOEL] ❌ ERREUR création GroundWeaponHolder";
    } else {
        _gift setPosATL _dropPos;
        _gift addItemCargoGlobal [_item, 1];
        _gift setVariable ["NOEL_GIFT_ITEM", _item, true];
        _gift setVariable ["NOEL_GIFT_VISUAL", _class, true]; // Stocker la classe visuelle pour référence
        diag_log format ["[NOEL] ✅ GroundWeaponHolder créé avec item: %1", _item];
    };
    
    if (!isNull _gift) then {
        // Créer le parachute
        private _para = createVehicle ["Steerable_Parachute_F", _dropPos, [], 0, "FLY"];
        
        if (!isNull _para) then {
            _gift attachTo [_para,[0,0,-1.3]];
            _gift setVariable ["NOEL_GIFT_ITEM", _item, true];

            diag_log "[NOEL] 🎁 Cadeau attaché au parachute, descente...";

            // attendre descente
            private _timeout = 0;
            waitUntil { 
                sleep 0.2; 
                _timeout = _timeout + 0.2;
                (getPosATL _para # 2) < 5 || _timeout > 120
            };

            if (_timeout > 120) then {
                diag_log "[NOEL] ❌ Timeout descente parachute";
            };

            private _giftPosBefore = getPosATL _gift;
            diag_log format ["[NOEL] 🎁 Position avant détachement: %1", _giftPosBefore];

            detach _gift;
            deleteVehicle _para;

            // Attendre que le cadeau touche le sol (avec timeout)
            _timeout = 0;
            waitUntil { 
                sleep 0.1; 
                _timeout = _timeout + 0.1;
                private _pos = getPosATL _gift;
                (_pos # 2) < 1 || isTouchingGround _gift || _timeout > 30
            };

            private _giftPosAfter = getPosATL _gift;
            diag_log format ["[NOEL] 🎁 Position après chute: %1", _giftPosAfter];

            // Position finale fiable
            private _x = _giftPosAfter # 0;
            private _y = _giftPosAfter # 1;
            
            // Vérifier si le cadeau est dans une position valide
            if (_x == 0 && _y == 0) then {
                diag_log "[NOEL] ❌ Cadeau à [0,0,0], utilisation position de drop";
                _x = _dropPos # 0;
                _y = _dropPos # 1;
            };
            
            private _z = getTerrainHeightASL [_x, _y];
            
            // Si le terrain est sous l'eau ou invalide, utiliser la hauteur du cadeau
            if (_z < -10 || surfaceIsWater [_x, _y]) then {
                _z = (_giftPosAfter # 2) max 0.2;
                diag_log format ["[NOEL] ⚠️ Terrain invalide, utilisation hauteur cadeau: %1", _z];
            };

            private _posASL = [_x, _y, _z];
            private _posATL = ASLToATL _posASL;

            _gift setPosASL _posASL;
            _gift setVectorUp [0,0,1];
            _gift enableSimulationGlobal false;
            _gift setVariable ["NOEL_GIFT_POS", _posASL, true];

            diag_log format [
                "[NOEL] 🎁 Cadeau posé | Class=%1 | ATL=%2 | ASL=%3",
                _class,_posATL,_posASL
            ];

            sleep _life;

            if (!isNull _gift) then {
                deleteVehicle _gift;
                diag_log "[NOEL] 🎁 Cadeau supprimé";
            };
        } else {
            diag_log "[NOEL] ❌ Erreur création parachute";
            if (!isNull _gift) then {
                deleteVehicle _gift;
            };
        };
    } else {
        diag_log "[NOEL] ❌ Impossible de créer le cadeau, abandon";
    };
    }; // fin du if (_dropPos isEqualTo [])
};

// ======================================================
// 🧹 CLEANUP EVENT
// ======================================================

[] spawn {
    sleep 300;

    MRPV2_NOEL_RUNNING = false;
    publicVariable "MRPV2_NOEL_RUNNING";

    diag_log "[NOEL] Event termine (cleanup OK)";
};

// ======================================================
// 🗑️ FONCTION SERVEUR : SUPPRESSION CADEAU
// ======================================================

MRPV2_Server_fnc_noelDeleteGift = {
    if (!isServer) exitWith {};
    params [["_gift", objNull, [objNull]]];
    
    if (!isNull _gift) then {
        deleteVehicle _gift;
        diag_log format ["[NOEL] 🎁 Cadeau supprimé par joueur: %1", _gift];
    };
};





