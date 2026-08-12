/*
    Détection sécurité (10 m) par mots-clés "security"
    - Un objet est valide si son classname, son modèle P3D ou son displayName contient:
      "security" / "sdsecurity" / "alf_security" (insensible à la casse)
    - Gestion des SimpleObjects (NOID) via recherche large + fallback par modèle .p3d
    - Reste du script: alarme, marker 10 min, notif, capture visages
*/

params [
    ["_refPosOrObj", [0,0,0], [[], objNull]],
    ["_unit", objNull, [objNull]]
];

// Position de référence et maison
private _pos = if (_refPosOrObj isEqualType objNull) then { position _refPosOrObj } else { _refPosOrObj };
// Détecter la maison : si c'est un objet, vérifier s'il est de type House/Building
private _house = objNull;
if (_refPosOrObj isEqualType objNull) then {
    if (_refPosOrObj isKindOf "House_F" || _refPosOrObj isKindOf "House" || _refPosOrObj isKindOf "Building") then {
        _house = _refPosOrObj;
    };
};

// ---- mots-clés acceptés
private _SEC_KEYWORDS = ["security","sdsecurity","alf_security"];

// ---- util : choisir le plus proche de _pos
private _selectNearest = {
    params ["_arr", "_ref"];
    private _best = objNull; private _bestD = 1e10;
    { private _d = _x distance _ref; if (_d < _bestD) then { _best = _x; _bestD = _d; }; } forEach _arr;
    _best
};

// ---- util : BIS_fnc_param like (sécurise getModelInfo)
private _safeGet = {
    params ["_arr","_idx","_def"];
    if (_idx < count _arr) then { _arr select _idx } else { _def }
};

// ---- util : filtre par mots-clés (classname / model / displayName)
private _isSecurity = {
    params ["_obj", "_keys"];

    private _cls = toLower (typeOf _obj);

    private _mi  = getModelInfo _obj;                 // ["\path\to\model.p3d","alt.p3d",...]
    private _m0  = toLower ([_mi,0,""] call _safeGet);
    private _m1  = toLower ([_mi,1,""] call _safeGet);

    // displayName si CfgVehicles existant (souvent vide pour NOID/SimpleObject)
    private _disp = "";
    private _classPath = configFile >> "CfgVehicles" >> typeOf _obj;
    if (isClass _classPath) then {
        _disp = toLower (getText (_classPath >> "displayName"));
    };

    // Match
    {
        private _k = toLower _x;
        if ( (_cls find _k) >= 0 || (_m0 find _k) >= 0 || (_m1 find _k) >= 0 || (_disp find _k) >= 0 ) exitWith { true };
    } forEach _keys;

    false
};

// ==== Recherche de la maison la plus proche (si pas déjà fournie) ====
if (isNull _house) then {
    private _candsHouse = nearestObjects [_pos, ["House","House_F","Building"], 25];
    if !(_candsHouse isEqualTo []) then { _house = _candsHouse # 0; };
};

// ==== Détection sécurité : PRIORITÉ aux mobiliers de la maison ====
private _securityObj = objNull;

// 1) D'abord chercher dans les mobiliers de la maison (méthode la plus fiable)
if (!isNull _house) then {
    private _mobs = _house getVariable ["mobiliers", []];
    if (_mobs isNotEqualTo []) then {
        {
            private _mi = getModelInfo _x;
            private _modelPath = [_mi, 1, ""] call _safeGet;
            if (_modelPath isEqualTo "alf_mobiliers\alf_security\alf_security.p3d") exitWith {
                _securityObj = _x;
            };
        } forEach _mobs;
    };
    
    // 1b) Si pas trouvé dans mobiliers, chercher directement les SimpleObjects avec le modèle sécurité dans un rayon de 10m autour de la maison
    if (isNull _securityObj) then {
        private _housePos = getPosATL _house;
        private _allSimpleObjs = allSimpleObjects [];
        {
            if (_x distance _housePos <= 10) then {
                private _mi = getModelInfo _x;
                private _modelPath = [_mi, 1, ""] call _safeGet;
                if (_modelPath isEqualTo "alf_mobiliers\alf_security\alf_security.p3d") exitWith {
                    _securityObj = _x;
                };
            };
        } forEach _allSimpleObjs;
    };
};

// 2) Si pas trouvé dans les mobiliers, chercher dans les objets proches (10 m)
if (isNull _securityObj) then {
    for "_t" from 1 to 10 do {
        // 1) Recherche "large"
        private _cands = nearestObjects [_pos, ["All"], 10];

        // 2) Ajout des objets "terrain"/éditeurs (souvent SimpleObjects placés)
        {
            _cands pushBackUnique _x;
        } forEach (nearestTerrainObjects [_pos, [], 10]);

        // 3) Objets de mission (placés via éditeur/scripts)
        {
            if (_x distance _pos <= 10) then { _cands pushBackUnique _x; };
        } forEach (allMissionObjects "");

        // 4) *** SimpleObjects dynamiques (meubles chargés DB) ***
        {
            if (_x distance _pos <= 10) then { _cands pushBackUnique _x; };
        } forEach (allSimpleObjects []);

        // 5) Filtrage par mots-clés (classname, model, displayName)
        private _secCands = _cands select { [_x, _SEC_KEYWORDS] call _isSecurity };

        if (_secCands isNotEqualTo []) exitWith {
            _securityObj = [_secCands, _pos] call _selectNearest;
        };

        uiSleep 0.2;
    };

    // Fallback : recherche directe par modèle .p3d (utile pour "NOID alf_security.p3d")
    if (isNull _securityObj) then {
        {
            private _k = toLower _x;

            // Priorité aux SimpleObjects (meubles DB) – match sur le chemin modèle
            private _hitsSO = (allSimpleObjects []) select {
                private _mi = getModelInfo _x;
                private _m0 = toLower ([_mi,0,""] call _safeGet);
                (_x distance _pos) <= 10 && { _m0 find _k >= 0 }
            };
            if (_hitsSO isNotEqualTo []) exitWith { _securityObj = [_hitsSO, _pos] call _selectNearest; };

            // Sinon, tentative générique par nom de fichier
            private _modelName = format ["%1.p3d", _k];
            private _o = nearestObject [_pos, _modelName];
            if (!isNull _o && { _o distance _pos <= 10 }) exitWith { _securityObj = _o; };
        } forEach _SEC_KEYWORDS;
    };
};

if (isNull _securityObj) exitWith {
    ["Perceuse", "Maison sans protection .", "warning"] spawn ALF_fnc_doMsg;
};

["Sécurité", "Système de sécurité détecté : alarme en attente...", "success"] spawn ALF_fnc_doMsg;

// ==== Notification b_6 et propriétaire (appelé dès la détection) ====
// Toujours appeler copHouseMarker si on a une maison ou si on a une position
if (!isNull _house) then {
    private _owner = _house getVariable ["house_owner", []];
    private _uid = "";
    if (_owner isNotEqualTo []) then {
        _uid = _owner select 0;
    };
    // Appeler même si pas de propriétaire pour que b_6 reçoive la notification
    // Si pas de propriétaire, _uid sera "" et seul b_6 recevra la notification
    // Passer par le serveur pour garantir l'envoi à tous les joueurs
    [_house, _uid] remoteExecCall ["ALF_Server_fnc_copHouseMarker", 2, false];
} else {
    // Si pas de maison trouvée mais qu'on a une position, chercher à nouveau
    private _candsHouse = nearestObjects [_pos, ["House","House_F","Building"], 50];
    if !(_candsHouse isEqualTo []) then {
        private _foundHouse = _candsHouse # 0;
        private _owner = _foundHouse getVariable ["house_owner", []];
        private _uid = "";
        if (_owner isNotEqualTo []) then {
            _uid = _owner select 0;
        };
        [_foundHouse, _uid] remoteExecCall ["ALF_Server_fnc_copHouseMarker", 2, false];
    };
};

// ==== Lecture du son d'alarme ====
sleep 5;

// Calculer la position et l'objet pour le son
private _playObj = objNull;
private _playPos = _pos;
private _doorIdx = missionNamespace getVariable ["ALF_PoserDoorIndex", 1];

if (!isNull _house) then {
    _playObj = _house;
    private _pMem = [0,0,0];
    {
        private _pp = _house selectionPosition [_x, "Memory"];
        if !(_pp isEqualTo [0,0,0]) exitWith { _pMem = _pp; };
    } forEach [
        format ["Door_%1_trigger", _doorIdx],
        format ["Door_%1_axis", _doorIdx],
        format ["Door_%1_rot", _doorIdx]
    ];
    if !(_pMem isEqualTo [0,0,0]) then {
        _playPos = _house modelToWorld _pMem;
    } else {
        private _bb = boundingBoxReal _house;
        private _min = _bb # 0; private _max = _bb # 1;
        private _center = [((_min # 0)+(_max # 0))/2, ((_min # 1)+(_max # 1))/2, ((_min # 2)+(_max # 2))/2];
        _playPos = _house modelToWorld _center;
    };
};

// Envoyer le son à tous les joueurs
[
    "ALF_Client2\sounds\banque_alarm.ogg",
    _playObj,
    false,
    _playPos,
    6,
    1,
    600
] remoteExecCall ["ALF_fnc_playSound3D", 0, false];

// ==== Marker de zone supprimé après 5 minutes ====
private _radius = 250;
private _centerRef = if (!isNull _house) then { getPosATL _house } else { _pos };

// choix d'un centre sûr dans le rayon
private _markerCenter = [0,0,0];
for "_i" from 0 to 20 do {
    private _cand = [_centerRef, 0, _radius, 5, 0, 20, 0, [], [_centerRef]] call BIS_fnc_findSafePos;
    if ( (_cand distance2D _centerRef) <= _radius && (_cand distance2D _centerRef) >= 30 && {!surfaceIsWater _cand} ) exitWith {
        _markerCenter = _cand;
    };
};
if (_markerCenter isEqualTo [0,0,0]) then {
    private _ang = random 360;
    private _dist = 30 + random (_radius - 30);
    _markerCenter = _centerRef getPos [_dist, _ang];
};

// --- Envoi du marqueur et notification gendarmerie uniquement si alarm_gendarmerie == 1
private _alarmGend = if (!isNull _house) then { _house getVariable ["alarm_gendarmerie", 0] } else { 0 };
if (_alarmGend isEqualTo 1) then {
	[_markerCenter, _radius] remoteExecCall ["ALF_Server_fnc_createRobberyMarker", 2];

	private _locs = nearestLocations [_markerCenter, ["NameLocal","NameVillage","NameCity","NameCityCapital"], 1000];
	private _villeProche = if (_locs isEqualTo []) then {"Zone inconnue"} else { text (_locs # 0) };
	["Crime", format ["Cambriolage en cours dans %1.", _villeProche]] remoteExecCall ["ALF_Server_fnc_doRobberyCall", 2];
};

// ==== Caméra / visages ====
if (_securityObj distance _pos > 100) exitWith {};

private _nearPlayers = (position _securityObj) nearEntities [["Man"], 15];
private _nearPlayersFace = [];
private _masques = [
    "UR_Bag1","UR_Bag2","UR_Bag3","UR_Bag4","UR_Bag5","UR_Bag6","UR_Bag7","UR_Bag8",
    "UR_Bag9","UR_Bag10","UR_Bag11","UR_Bag12","UR_Bag13","UR_Bag14","UR_Bag15",
    "UR_Bag16","UR_Bag17","ALF_G_Balaclava_blk","ALF_G_Bandanna_beast","UR_Owl",
    "UR_Fox","UR_Dino_Brown","UR_Hawk_Brown","UR_Hawk_White","ALF_G_Bandanna_blk",
    "UR_Pig","UR_Pig_Bloody","UR_Cat_Gray","UR_monkey","UR_monkey_darkbrown",
    "UR_monkey_lightbrown","UR_monkey_grey","UR_Skull_Bone","UR_Hockey_Mask_4_CIRCUIT",
    "ALF_Masque","ALF_Casque_PMO","ALF_Bike","ALF_H_Moto_2_Violet","ALF_H_Moto_2_Vert",
    "ALF_H_Moto_2_RougeFonce","ALF_H_Moto_2_Orange","ALF_H_Moto_2_Jaune",
    "ALF_H_Moto_2_Bleu","ALF_H_Moto_2_Blanc","ALF_H_Moto_2_Noir","ALF_H_Moto_Violet",
    "ALF_H_Moto_Vert","ALF_H_Moto_RougeFonce","ALF_H_Moto_2_Orange","ALF_H_Moto_2_Jaune",
    "ALF_H_Moto_Bleu","ALF_H_Moto_Blanc","ALF_H_Moto_Noir","UR_ShirtMask_01"
];

{
    private _g = goggles _x;
    if (_g in _masques) then {
        _nearPlayersFace pushBack "Cagoule";
    } else {
        private _adn = _x getVariable ["adnface", ["Inconnu","Inconnu"]];
        _nearPlayersFace pushBack (_adn # 1);
    };
} forEach _nearPlayers;

// Horodatage HH:MM
private _hour = date select 3;
private _min = date select 4;
if (_min < 10) then { _min = format ["0%1", _min]; };
private _time = format ["%1:%2", _hour, _min];

// Envoi infos caméra au serveur
[_securityObj, _time, _nearPlayersFace] remoteExecCall ["ALF_Server_fnc_setCameraVar", 2];
