/*
    File: fn_copBreakDoor.sqf
    Author: ALF NiiRoZz
    Modifié: signature tolérante + fixes serveur
*/


params [
    // Maison/coffre obligatoire
    ["_house", objNull, [objNull]],
    // Peut être un OBJET (unité) ou un SCALAR (index)
    ["_arg2", objNull, [objNull, 0]]
];
if (isNull _house) exitWith {};


private _GN_En_Service = (((groups civilian) select {groupId _x isEqualto "Gendarmerie"}) # 0);

// Si le joueur EST gendarme mais qu'ils sont trop peu → blocage RP
if (!isNil {_GN_En_Service} AND {count (units _GN_En_Service) < 2 AND {life_gendarme_service}}) exitWith {
    closeDialog 2;
    ["Mec suspect", "T'es de la maison… va bosser !", "danger", false] spawn alf_fnc_doMsg;
};

// Si PAS gendarme → trop risqué, dealer refuse
if (isNil {_GN_En_Service} OR {count (units _GN_En_Service) < 2}) exitWith {
    closeDialog 2;
    ["Cambriolage", "Lâche l'affaire, c'est pas un bon moment.", "danger", false] spawn alf_fnc_doMsg;
};


private _unit = objNull;
private _doorIdx = missionNamespace getVariable ["ALF_PoserDoorIndex", 1];

// Déduire l'unité vs l'index selon le type passé
if (_arg2 isEqualType objNull) then {
    _unit = _arg2;          // appel du style [_house, player]
} else {
    _doorIdx = _arg2;       // appel du style [_house, 0]
};

private _mobs = _house getVariable ["mobiliers", []];
if (_mobs isEqualTo []) exitWith {};

private _ss = objNull;
{
    if (!isNull _x) then {
        private _mi = getModelInfo _x;
        if (count _mi > 1) then {
            private _modelPath = _mi select 1;
            if (_modelPath isEqualTo "alf_mobiliers\alf_security\alf_security.p3d") exitWith {
                _ss = _x;
            };
        };
    };
} forEach _mobs;
if (isNull _ss) exitWith {};

// Si on a une unité, on vérifie la distance ; sinon on autorise (appel serveur “index only”)
private _distOK = isNull _unit || { _unit distance _ss < 30 };
if (_distOK) then {
    // Son alarme (exécuté côté serveur → OK)
    playSound3D ["ALF_Client2\sounds\banque_alarm.ogg", _ss, false, position _ss, 3, 1, 150];

    // Marqueur maison (serveur) - récupérer l'UID du propriétaire
    private _owner = _house getVariable ["house_owner", []];
    private _uid = "";
    if (_owner isNotEqualTo []) then {
        _uid = _owner select 0;
    };
    [_house, _uid] call ALF_Server_fnc_copHouseMarker;

    // Détection des joueurs proches
    private _nearPlayers = (position _ss) nearEntities [["Man"], 20];
    private _nearPlayersFace = [];

    {
        // IMPORTANT : on n'utilise PAS 'player' côté serveur, on utilise l’itérateur _x
        private _hd = headgear _x;
        private _gg = goggles _x;

        // Liste des équipements qui MASQUENT le visage
        private _maskOrHelmetList = [
            "ALF_Casque_PMO","ALF_Bike","ALF_H_Moto_2_Violet","ALF_H_Moto_2_Vert","ALF_H_Moto_2_RougeFonce",
            "ALF_H_Moto_2_Orange","ALF_H_Moto_2_Jaune","ALF_H_Moto_2_Bleu","ALF_H_Moto_2_Blanc","ALF_H_Moto_2_Noir",
            "ALF_H_Moto_Violet","ALF_H_Moto_Vert","ALF_H_Moto_RougeFonce","ALF_H_Moto_Orange","ALF_H_Moto_Jaune",
            "ALF_H_Moto_Bleu","ALF_H_Moto_Blanc","ALF_H_Moto_Noir","UR_Bag1","UR_Bag2","UR_Bag3","UR_Bag4","UR_Bag5",
            "UR_Bag6","UR_Bag7","UR_Bag8","UR_Bag9","UR_Bag10","UR_Bag11","UR_Bag12","UR_Bag13","UR_Bag14","UR_Bag15",
            "UR_Bag16","UR_Bag17","ALF_G_Balaclava_blk","ALF_G_Bandanna_beast","UR_Owl","UR_Fox","UR_Dino_Brown",
            "UR_Hawk_Brown","UR_Hawk_White","ALF_G_Bandanna_blk","UR_Pig","UR_Pig_Bloody","UR_Cat_Gray","UR_monkey",
            "UR_monkey_darkbrown","UR_monkey_lightbrown","UR_monkey_grey","UR_Skull_Bone",
            "UR_Hockey_Mask_4_CIRCUIT","ALF_Masque","UR_ShirtMask_01"
        ];

        // Goggle “balaclava” tolérée dans ton code d’origine
        private _gogglesPassList = ["ALF_G_Balaclava_blk"];

        // Si le joueur n’a PAS de masque/helmet bloquant, OU bien ses goggles sont dans la pass-list, on prend le visage
        private _isMasked = (_hd in _maskOrHelmetList) || (_gg in _maskOrHelmetList);
        private _passesGoggles = (_gg in _gogglesPassList);

        if ( !_isMasked || _passesGoggles ) then {
            private _adn = _x getVariable ["adnface", []];
            if (_adn isEqualType [] && {count _adn > 1}) then {
                _nearPlayersFace pushBack (_adn select 1);
            };
        };
    } forEach _nearPlayers;

    // Heure formattée HH:MM
    private _hour = date select 3;
    private _min  = date select 4;
    private _minStr = str _min;
    if (_min < 10) then { _minStr = format ["0%1", _min]; };
    private _time = format ["%1:%2", _hour, _minStr];

    // Côté serveur : appel direct
    [_ss, _time, _nearPlayersFace] call ALF_Server_fnc_setCameraVar;
};
