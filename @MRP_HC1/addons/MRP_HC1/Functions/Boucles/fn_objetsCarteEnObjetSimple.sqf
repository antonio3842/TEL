/*
    File: fn_objetsCarteEnObjetSimple.sqf
    Author: ALF Team
    Desc: Convertit les objets terrain (murs, barrières) en Simple Objects (incassables + légers)
    hc_1 - Exécuté une fois au démarrage
    
    OPTIMISÉ: HashMap pour recherche O(1), traitement par batch
*/

[] spawn {
    // Attendre que le monde soit chargé
    waitUntil {sleep 1; time > 5};
    
    private _timeStart = diag_tickTime;
    diag_log "[MRP_HC1] [ObjetsSimple] Démarrage conversion objets terrain...";

    // HashMap pour recherche O(1) au lieu de O(n) avec "in"
    private _liste_Objets_A_Changer = createHashMapFromArray [
        ["guardrailing_01_f.p3d", true],
        ["plp_up_paversrectpatio.p3d", true],
        ["plp_up_paversbricksgrypatio.p3d", true],
        ["bollard_01_f.p3d", true],
        ["concretewall_01_m_8m_f_nocontact.p3d", true],
        ["concretewall_01_m_4m_f_nocontact.p3d", true],
        ["mrp_barriere_jardin.p3d", true],
        ["land_concretewall_01_l_4m_f.p3d", true],
        ["land_concretewall_01_l_8m_f.p3d", true],
        ["land_concretewall_01_l_pole_f.p3d", true],
        ["land_concretewall_01_m_pole_f.p3d", true],
        ["mrp_barriere_ville.p3d", true],
        ["land_pipefence_01_m_4m_f.p3d", true],
        ["land_pipefence_01_m_8m_f.p3d", true],
        ["land_pipefence_01_m_2m_f.p3d", true],
        ["land_concretewall_02_m_gate_f.p3d", true],
        ["land_concretekerb_01_2m_f.p3d", true],
        ["land_hedge_01_s_4m_f.p3d", true],
        ["land_hedge_01_s_2m_f.p3d", true],
        ["land_concretekerb_01_4m_f.p3d", true],
        ["land_concretekerb_01_8m_f.p3d", true],
        ["plp_up_paversbricksgrualley.p3d", true],
        ["plp_up_parkingblockconcretedark.p3d", true],
        ["land_netfence_02_m_pole_f.p3d", true],
        ["land_netfence_02_m_4m_f.p3d", true],
        ["land_netfence_02_m_2m_f.p3d", true],
        ["land_netfence_02_m_8m_f.p3d", true],
        ["land_pipefence_01_m_pole_f.p3d", true],
        ["land_pipefence_01_m_gate_v2_f.p3d", true],
        ["new_wiredfence_10m_f.p3d", true],
        ["plp_up_bollardroundred.p3d", true],
        ["o2_grillage_12m.p3d", true],
        ["o2_grillage_12m_antr.p3d", true],
        ["o2_grillage_24m.p3d", true],
        ["o2_grillage_24m_antr.p3d", true],
        ["o2_grillage_3m.p3d", true],
        ["o2_grillage_3m_antr.p3d", true],
        ["o2_grillage_6m.p3d", true],
        ["o2_grillage_6m_antr.p3d", true],
        ["o2_grillage_poto.p3d", true],
        ["o2_grillage_poto_antr.p3d", true],
        ["o2_grillage_poto_s.p3d", true],
        ["o2_grillage_poto_s_antr.p3d", true],
        ["mrp_pilier_barriere_jardin.p3d", true],
        ["brickwall_01_l_5m_f.p3d", true],
        ["brickwall_01_l_pole_f.p3d", true],
        ["brickwall_01_l_corner_f.p3d", true]
    ];

    // Récupération des objets terrain (une seule fois)
    diag_log "[MRP_HC1] [ObjetsSimple] Scan des objets terrain...";
    private _liste_Objets_Monde = nearestTerrainObjects [[worldSize / 2, worldSize / 2], ["wall","hide"], worldSize * sqrt 2 / 2, false, true];
    diag_log format ["[MRP_HC1] [ObjetsSimple] %1 objets terrain trouvés", count _liste_Objets_Monde];

    // Filtrage optimisé avec HashMap
    private _liste_Objets_Trier = _liste_Objets_Monde select {
        if (isObjectHidden _x) exitWith {false};
        private _modelPath = (getModelInfo _x) # 0;
        if (_modelPath == "") exitWith {false};
        private _parts = _modelPath splitString "\";
        private _fileName = toLower (_parts select (count _parts - 1));
        _fileName in _liste_Objets_A_Changer
    };

    private _totalObjets = count _liste_Objets_Trier;
    diag_log format ["[MRP_HC1] [ObjetsSimple] %1 objets à convertir", _totalObjets];

    if (_totalObjets == 0) exitWith {
        diag_log "[MRP_HC1] [ObjetsSimple] Aucun objet à convertir - Fin";
    };

    // Traitement par batch de 50 objets pour éviter les freezes
    private _batchSize = 50;
    private _converted = 0;
    private _errors = 0;

    {
        private _obj = _x;
        private _modelPath = (getModelInfo _obj) # 1;
        
        if (_modelPath != "") then {
            private _pos = getPosWorld _obj;
            private _dir = vectorDir _obj;
            private _vectorUp = vectorUp _obj;
            
            // hideObjectGlobal doit être exécuté sur le serveur
            [_obj] remoteExecCall ["hideObjectGlobal", 2];

            // createSimpleObject avec position directe
            // Simple Object = déjà indestructible par nature, pas de simulation
            private _obj_Simple = createSimpleObject [_modelPath, _pos, false];

            if (!isNull _obj_Simple) then {
                _obj_Simple setVectorDirAndUp [_dir, _vectorUp];
                _converted = _converted + 1;
            } else {
                _errors = _errors + 1;
                if (_errors <= 5) then {
                    diag_log format ["[MRP_HC1] [ObjetsSimple] Erreur création: %1", _modelPath];
                };
            };
        };
        
        // Pause tous les X objets pour laisser respirer
        if ((_forEachIndex mod _batchSize) isEqualTo 0 && _forEachIndex > 0) then {
            // Log de progression tous les 500 objets
            if ((_forEachIndex mod 500) isEqualTo 0) then {
                diag_log format ["[MRP_HC1] [ObjetsSimple] Progression: %1/%2 (%3%%)", _forEachIndex, _totalObjets, round(_forEachIndex / _totalObjets * 100)];
            };
            sleep 0.1;
        };
    } forEach _liste_Objets_Trier;

    private _timeEnd = diag_tickTime;
    diag_log format ["[MRP_HC1] [ObjetsSimple] Terminé: %1 convertis, %2 erreurs, temps: %3s", _converted, _errors, (_timeEnd - _timeStart) toFixed 2];
};
