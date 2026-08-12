/*
if (!hasInterface) exitWith {};

diag_log "[NOEL][CLIENT] INIT";

params [["_heli",objNull,[objNull]]];


// =====================================================================
// ❄️ NEIGE (1 fois)
// =====================================================================
if (isNil "MRPV2_NOEL_SNOW") then {
    MRPV2_NOEL_SNOW = true;

    [] spawn {
        private _src = "#particlesource" createVehicleLocal [0,0,0];

        _src setParticleParams [
            ["\A3\data_f\ParticleEffects\Universal\Universal",16,12,13,0],
            "", "Billboard",
            1,20,[0,0,0],[0,0,-0.8],
            0,10.5,7.9,0.5,
            [0.2,0.053],
            [[1,1,1,0.9],[1,1,1,0]],
            [0.1],1,0,"","",_src
        ];
        _src setParticleRandom [0,[35,35,2],[0.2,0.2,0],0,0.2,[0,0,0,0.05],0,0];
        _src setDropInterval 0.003;

        while {true} do {
            _src setPosASL ((getPosASL vehicle player) vectorAdd [0,0,20]);
            uiSleep 0.03;
        };
    };
};


// =====================================================================
// ✈️ ICÔNE TRAÎNEAU
// =====================================================================
if (!isNull _heli) then {
    MRPV2_NOEL_HELI = _heli;
};

if (isNil "MRPV2_NOEL_HELI_EH") then {
    MRPV2_NOEL_HELI_EH = addMissionEventHandler ["Draw3D", {
        if (isNil "MRPV2_NOEL_HELI") exitWith {};
        if (isNull MRPV2_NOEL_HELI) exitWith {};

        drawIcon3D [
            "\A3\ui_f\data\IGUI\Cfg\Actions\getin_ca.paa",
            [1,0,0,1],
            (getPosATL MRPV2_NOEL_HELI) vectorAdd [0,0,6],
            2.5,2.5,0,
            "TRAÎNEAU DE NOËL",
            2,0.045,"RobotoCondensedBold"
        ];
    }];
};


// =====================================================================
// 🎁 AUTOLOOT CADEAUX (SANS ICÔNE / SANS MAIN)
// =====================================================================

// AUTOLOOT (sans icône / sans main)
if (isNil "MRPV2_NOEL_LOOT") then {
    MRPV2_NOEL_LOOT = true;

    // stockage markers locaux par netId
    if (isNil "MRPV2_NOEL_GIFT_MK") then { MRPV2_NOEL_GIFT_MK = createHashMap; };

    [] spawn {
        private _classes = [
            "Land_MRP_O2_Kdo","Land_MRP_O2_Gros_Kdo",
            "Land_MRP_O2_Kdo_Bleu","Land_MRP_O2_Gros_Kdo_Bleu",
            "Land_MRP_O2_Kdo_Vert","Land_MRP_O2_Gros_Kdo_Vert",
            "Land_MRP_O2_Kdo_Rose","Land_MRP_O2_Gros_Kdo_Rose"
        ];

        while {true} do {

            private _gifts = [];
            { _gifts append (allMissionObjects _x); } forEach _classes;

            // create / update markers
            {
                private _gift = _x;
                if (isNull _gift) then { continue; };

                private _nid = netId _gift;
                if (_nid isEqualTo "") then { continue; };

                private _posASL = _gift getVariable ["NOEL_GIFT_POS", []];
                if (_posASL isEqualTo []) then { _posASL = getPosASL _gift; };

                private _mkName = MRPV2_NOEL_GIFT_MK getOrDefault [_nid, ""];

                if (_mkName isEqualTo "") then {
                    _mkName = format ["NOEL_G_%1", _nid];
                    createMarkerLocal [_mkName, ASLToATL _posASL];
                    _mkName setMarkerTypeLocal "mil_dot";
                    _mkName setMarkerColorLocal "ColorRed";
                    _mkName setMarkerTextLocal "Cadeau";
                    MRPV2_NOEL_GIFT_MK set [_nid, _mkName];
                } else {
                    _mkName setMarkerPosLocal (ASLToATL _posASL);
                };

                // autoloot
                if ((player distance _gift) < 3) then {
                    private _item = _gift getVariable ["NOEL_GIFT_ITEM",""];
                    if (_item isEqualTo "") then { continue; };

                    if (player canAdd _item) then {
                        player addItem _item;
                        ["INFO",format["Vous avez reçu : %1",_item],"success"] spawn ALF_fnc_doMsg;

                        // cleanup marker
                        if !(MRPV2_NOEL_GIFT_MK getOrDefault [_nid,""] isEqualTo "") then {
                            deleteMarkerLocal (MRPV2_NOEL_GIFT_MK get _nid);
                            MRPV2_NOEL_GIFT_MK deleteAt _nid;
                        };

                        deleteVehicle _gift;
                    } else {
                        ["INFO","Inventaire plein !","warning"] spawn ALF_fnc_doMsg;
                    };
                };

            } forEach _gifts;

            // cleanup markers orphelins
            {
                private _nid = _x;
                private _mk = _y;
                private _obj = objectFromNetId _nid;

                if (isNull _obj) then {
                    deleteMarkerLocal _mk;
                    MRPV2_NOEL_GIFT_MK deleteAt _nid;
                };
            } forEach MRPV2_NOEL_GIFT_MK;

            uiSleep 0.5;
        };
    };
};
*/







if (!hasInterface) exitWith {};

systemChat "[NOEL][CLIENT] INIT";

params [["_heli",objNull,[objNull]]];


// =====================================================================
// ❄️ NEIGE DANS LES ZONES DE DROP (sources fixes réparties)
// =====================================================================
if (isNil "MRPV2_NOEL_SNOW") then {
    MRPV2_NOEL_SNOW = true;

    [] spawn {
        // Zones de drop (doit correspondre au serveur)
        private _dropZones = [
            [[6665.21,3520.87,0],4000],
            [[4020.46,8103.71,0],4000]
        ];
        
        // Créer des sources fixes réparties dans chaque zone (grid de 40m pour neige dense)
        private _allSnowSources = [];
        private _spacing = 40; // Espacement très dense pour neige partout
        
        {
            _x params ["_center","_radius"];
            private _gridSize = floor (_radius / _spacing);
            
            for "_x" from -_gridSize to _gridSize do {
                for "_y" from -_gridSize to _gridSize do {
                    private _pos = [
                        (_center#0) + (_x * _spacing),
                        (_center#1) + (_y * _spacing),
                        _center#2
                    ];
                    
                    // Vérifier si dans le cercle
                    if ((_pos distance2D _center) <= _radius) then {
                        private _src = "#particlesource" createVehicleLocal [0,0,0];
                        // Positionner la source plus basse (comme le code original qui suivait le joueur à 20m)
                        private _terrainHeight = getTerrainHeightASL _pos;
                        _src setPosASL [_pos#0, _pos#1, _terrainHeight + 20];
                        
                        // Paramètres identiques au code original pour que la neige tombe bien
                        _src setParticleParams [
                            ["\A3\data_f\ParticleEffects\Universal\Universal",16,12,13,0],
                            "", "Billboard",
                            1,50,[0,0,0],[0,0,-0.8], // Durée 50s pour s'assurer qu'elle tombe jusqu'au sol
                            0,10.5,7.9,0.5,
                            [0.2,0.053],
                            [[1,1,1,0.9],[1,1,1,0]],
                            [0.1],1,0,"","",_src
                        ];
                        _src setParticleRandom [0,[35,35,2],[0.2,0.2,0],0,0.2,[0,0,0,0.05],0,0];
                        _src setDropInterval 0.003;
                        
                        _allSnowSources pushBack _src;
                    };
                };
            };
        } forEach _dropZones;
        
        systemChat format ["[NOEL] Neige activée : %1 sources créées", count _allSnowSources];
        
        // Nettoyer à la fin (si besoin)
        waitUntil { false };
        { deleteVehicle _x; } forEach _allSnowSources;
    };
};


// =====================================================================
// 🎅 FONCTION : CRÉER ET ANIMER LE TRAÎNEAU
// =====================================================================
MRPV2_fnc_createAnimatedSleigh = {
    params ["_start","_end","_t0","_spd"];
    
    // Supprimer l'ancien traîneau s'il existe
    if (!isNil "MRPV2_NOEL_HELI" && !isNull MRPV2_NOEL_HELI) then {
        deleteVehicle MRPV2_NOEL_HELI;
    };
    
    private _heli = createVehicleLocal ["C_Christmas_Heli_01_unarmed_F", _start, [], 0, "CAN_COLLIDE"];
    if (isNull _heli) exitWith {
        systemChat "[NOEL] ERREUR: Impossible de créer le traîneau !";
    };
    
    systemChat format ["[NOEL] Traîneau créé: Start=%1 → End=%2", _start, _end];
    _heli enableSimulation false;
    _heli allowDamage false;
    _heli setPosASL _start;
    _heli setVectorUp [0,0,1];
    MRPV2_NOEL_HELI = _heli;
    
    private _dist = _start distance2D _end;
    // Vitesse très rapide pour traîneau fluide (70 m/s = ~250 km/h)
    private _visualSpeed = 70; // m/s pour une vitesse réaliste de traîneau volant
    // Calculer la durée basée sur la vitesse visuelle
    private _dur = (_dist / _visualSpeed) max 15; // Minimum 15 secondes pour bien voir le traîneau
    
    // Animation fluide avec interpolation réaliste
    [_start, _end, _t0, _dur, _heli] spawn {
        params ["_start","_end","_t0","_dur","_heli"];
        
        // Attendre le démarrage
        waitUntil { (serverTime - _t0) >= 0 };
        
        private _prevPos = _start;
        private _prevDir = (_start getDir _end);
        _heli setDir _prevDir;
        
        // Variables pour interpolation fluide
        private _lastUpdateTime = serverTime;
        private _currentT = 0;
        
        while { !isNull _heli && _currentT < 1 } do {
            private _currentTime = serverTime;
            private _deltaTime = _currentTime - _lastUpdateTime;
            _lastUpdateTime = _currentTime;
            
            // Avancer progressivement (basé sur le temps écoulé)
            _currentT = ((_currentTime - _t0) / _dur) min 1;
            
            // Ease-in-out cubic pour mouvement très fluide
            private _tt = _currentT;
            private _ease = if (_tt < 0.5) then {
                // Ease-in
                _tt = _tt * 2;
                ((_tt * _tt * _tt) / 2)
            } else {
                // Ease-out
                _tt = (_tt * 2) - 1;
                (((_tt * _tt * _tt) + 2) / 2)
            };
            
            // Position interpolée avec easing
            private _pos = [
                (_start#0) + ((_end#0 - _start#0) * _ease),
                (_start#1) + ((_end#1 - _start#1) * _ease),
                (_start#2) + ((_end#2 - _start#2) * _ease)
            ];
            
            // Direction fluide avec lissage important
            if (_pos distance _prevPos > 0.01) then {
                private _targetDir = _prevPos getDir _pos;
                private _dirDiff = (_targetDir - _prevDir) call {
                    if (_this > 180) then { _this - 360 } else { 
                        if (_this < -180) then { _this + 360 } else { _this }
                    };
                };
                // Lissage à 40% pour mouvement très fluide
                _prevDir = _prevDir + (_dirDiff * 0.4);
                if (_prevDir < 0) then { _prevDir = _prevDir + 360 };
                if (_prevDir >= 360) then { _prevDir = _prevDir - 360 };
            };
            
            _heli setPosASL _pos;
            _heli setDir _prevDir;
            
            _prevPos = _pos;
            
            // Mise à jour très fréquente pour fluidité maximale
            sleep 0.016; // ~60 FPS
        };
        
        // Fin du trajet - position finale
        if (!isNull _heli) then {
            _heli setPosASL _end;
            _heli setDir (_start getDir _end);
            sleep 2;
            if (!isNull _heli) then {
                deleteVehicle _heli;
            };
            if (!isNil "MRPV2_NOEL_HELI") then {
                MRPV2_NOEL_HELI = objNull;
            };
        };
    };
};

// =====================================================================
// ✈️ TRAÎNEAU ANIMÉ (via MRPV2_NOEL_DATA)
// =====================================================================
if (isNil "MRPV2_NOEL_DATA_EH") then {
    MRPV2_NOEL_DATA_EH = "MRPV2_NOEL_DATA" addPublicVariableEventHandler {
        if (isNil "MRPV2_NOEL_DATA") exitWith {
            systemChat "[NOEL] ERREUR: MRPV2_NOEL_DATA est nil";
        };
        
        MRPV2_NOEL_DATA call MRPV2_fnc_createAnimatedSleigh;
    };
    
    // Si MRPV2_NOEL_DATA existe déjà
    if (!isNil "MRPV2_NOEL_DATA") then {
        MRPV2_NOEL_DATA call MRPV2_fnc_createAnimatedSleigh;
    };
};

// Support ancien code si _heli passé en paramètre
if (!isNull _heli) then {
    MRPV2_NOEL_HELI = _heli;
};

// =====================================================================
// ✈️ ICÔNE TRAÎNEAU
// =====================================================================
if (isNil "MRPV2_NOEL_HELI_EH") then {
    MRPV2_NOEL_HELI_EH = addMissionEventHandler ["Draw3D", {
        if (isNil "MRPV2_NOEL_HELI") exitWith {};
        if (isNull MRPV2_NOEL_HELI) exitWith {};
        
        private _pos = getPosATL MRPV2_NOEL_HELI;
        if (_pos isEqualTo [0,0,0]) exitWith {};

        drawIcon3D [
            "\A3\ui_f\data\IGUI\Cfg\Actions\getin_ca.paa",
            [1,0,0,1],
            _pos vectorAdd [0,0,6],
            2.5,2.5,0,
            "TRAÎNEAU DE NOËL",
            2,0.045,"RobotoCondensedBold"
        ];
    }];
    systemChat "[NOEL] Handler Draw3D pour icône traîneau créé";
};


// =====================================================================
// 🎁 AUTOLOOT CADEAUX (SANS ICÔNE / SANS MAIN)
// =====================================================================

// AUTOLOOT (sans icône / sans main)
if (isNil "MRPV2_NOEL_LOOT") then {
    MRPV2_NOEL_LOOT = true;

    // stockage markers locaux par netId
    if (isNil "MRPV2_NOEL_GIFT_MK") then { MRPV2_NOEL_GIFT_MK = createHashMap; };

    [] spawn {
        while {true} do {
            // Chercher tous les GroundWeaponHolder_Scripted avec la variable NOEL_GIFT_ITEM
            private _gifts = allMissionObjects "GroundWeaponHolder_Scripted" select {
                !isNull _x && 
                !(_x getVariable ["NOEL_GIFT_ITEM", ""] isEqualTo "")
            };

            // create / update markers
            {
                private _gift = _x;
                if (isNull _gift) then { continue; };

                private _nid = netId _gift;
                if (_nid isEqualTo "") then { continue; };

                private _posASL = _gift getVariable ["NOEL_GIFT_POS", []];
                if (_posASL isEqualTo []) then { _posASL = getPosASL _gift; };

                private _mkName = MRPV2_NOEL_GIFT_MK getOrDefault [_nid, ""];

                if (_mkName isEqualTo "") then {
                    _mkName = format ["NOEL_G_%1", _nid];
                    createMarkerLocal [_mkName, ASLToATL _posASL];
                    _mkName setMarkerTypeLocal "mil_dot";
                    _mkName setMarkerColorLocal "ColorRed";
                    _mkName setMarkerTextLocal "Cadeau";
                    MRPV2_NOEL_GIFT_MK set [_nid, _mkName];
                } else {
                    _mkName setMarkerPosLocal (ASLToATL _posASL);
                };

                // autoloot
                if ((player distance _gift) < 3) then {
                    private _item = _gift getVariable ["NOEL_GIFT_ITEM",""];
                    if (_item isEqualTo "") then { continue; };

                    if (player canAdd _item) then {
                        player addItem _item;
                        ["INFO",format["Vous avez reçu : %1",_item],"success"] spawn ALF_fnc_doMsg;

                        // cleanup marker
                        if !(MRPV2_NOEL_GIFT_MK getOrDefault [_nid,""] isEqualTo "") then {
                            deleteMarkerLocal (MRPV2_NOEL_GIFT_MK get _nid);
                            MRPV2_NOEL_GIFT_MK deleteAt _nid;
                        };

                        [_gift] remoteExec ["MRPV2_Server_fnc_noelDeleteGift", 2];
                    } else {
                        ["INFO","Inventaire plein !","warning"] spawn ALF_fnc_doMsg;
                    };
                };

            } forEach _gifts;

            // cleanup markers orphelins
            {
                private _nid = _x;
                private _mk = _y;
                private _obj = objectFromNetId _nid;

                if (isNull _obj) then {
                    deleteMarkerLocal _mk;
                    MRPV2_NOEL_GIFT_MK deleteAt _nid;
                };
            } forEach MRPV2_NOEL_GIFT_MK;

            uiSleep 0.5;
        };
    };
};
