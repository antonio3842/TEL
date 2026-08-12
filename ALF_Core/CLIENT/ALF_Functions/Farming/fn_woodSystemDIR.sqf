#include "\ALF_Client\script_macros.hpp"
/*
  File: fn_woodSystemDIR.sqf
*/

params ["_arbre"];
private["_tree","_treeModelNames","_obj"];

private _treeModelNames = [
    "t_ficusb2s_f.p3d","t_fraxinusav2s_f.p3d","t_ficusb1s_f.p3d",
    "t_pinuss2s_f.p3d","t_pinuss2s_b_f.p3d","t_Cocos_small_F.p3d",
    "t_ficus_medium_f.p3d","t_ficus_big_f_p3d","t_ficus_big_f.p3d"
];

private _str = toLower (str cursorObject);
private _fileName = _str splitString ": " select -1;

private _nom_Modele = getModelInfo cursorObject # 0;

private _cible_Est_Arbre = "t_" in _nom_Modele AND {!("t_f" in _nom_Modele)};
private _exit = false;
if !(_cible_Est_Arbre) then {
	if !(_fileName in _treeModelNames) then {
		_exit = true;
	};
};

if (_exit) exitWith {};

if (isNull _arbre) exitWith {};
if (isObjectHidden _arbre) exitWith {};

private _hauteur_Arbre = (0 boundingBoxReal _arbre) # 1 # 2;

private _nombre_Coup_Necessaire = round(floor((0 boundingBoxReal _arbre) # 2)/3);

if (_nombre_Coup_Necessaire >= 4) then 
{
    _nombre_Coup_Necessaire = 4;
};

private _position_Arbre = getPosATL _arbre;
_position_Arbre = [round (_position_Arbre # 0), round (_position_Arbre # 1)];
private _arbre_Id = str(_position_Arbre);
private _coups_Donnes = 0;
private _joueurs_Proches = _arbre nearEntities ["Man", 300] select {isPlayer _x};
private _degat_Objet = damage _arbre;

if (_degat_Objet < 1) then 
{
    // Effet de particules de feuillage uniquement quand l'arbre est encore debout
    private _pos = getPosATL _arbre;
    private _boundingBox = boundingBoxReal _arbre;
    private _hauteurMax = (_boundingBox select 1) select 2;
    private _largeurMax = (_boundingBox select 1) select 0;

    if (_hauteurMax <= 0) then { _hauteurMax = 2; };
    if (_largeurMax <= 0) then { _largeurMax = 1; };

    private _hauteurParticules = (_pos select 2) + (_hauteurMax * 1);
    private _largeurEffet = _largeurMax * 0.5;

    private _feuilles = "#particlesource" createVehicle [_pos select 0, _pos select 1, _hauteurParticules];

    _feuilles setParticleCircle [0, [_largeurEffet, _largeurEffet, 0]];
    _feuilles setParticleRandom [1, [_largeurEffet, _largeurEffet, 0], [0.2, 0.2, 0], 1, 0.2, [0, 0, 0, 0.1], 0, 0];
    _feuilles setParticleParams [
        ["\A3\data_f\cl_leaf", 1, 0, 1],
        "",
        "SpaceObject",
        1,
        4,
        [0, 0, 0],
        [0, 0, -3],
        0,
        10,
        7.9,
        0,
        [1.5, 1.5],
        [[1, 1, 1, 1], [1, 1, 1, 0]],
        [0.1],
        1,
        0,
        "",
        "",
        _feuilles
    ];
    _feuilles setDropInterval 0.009;

    [_feuilles] spawn {
        params ["_src"];
        sleep 1;

        for "_i" from 0 to 5 do {
            addCamShake [2, 0.1, 10];
            sleep 0.1;
        };
        sleep 1;
        deleteVehicle _src;
    };

    // Logique d'augmentation des dégâts
    _degat_Objet = _degat_Objet + (1 / _nombre_Coup_Necessaire);
    _arbre setDamage [_degat_Objet, TRUE, player];
} else 
{
    {
        private _info_Arbres = _x getVariable ["info_Arbres", []];
        private _trouve = false;

        {
            if (!_trouve AND _x # 0 == _arbre_Id) then 
            {
                _coups_Donnes = _x # 1;
                _trouve = true;
            };
        } forEach _info_Arbres;
    } forEach _joueurs_Proches;

    if (_coups_Donnes == 0) then 
    {
        {
            private _info_Arbres = _x getVariable ["info_Arbres", []];
            _info_Arbres pushBack [_arbre_Id, 0, _nombre_Coup_Necessaire];
            _x setVariable ["info_Arbres", _info_Arbres, TRUE];
        } forEach _joueurs_Proches;
    };

    _coups_Donnes = _coups_Donnes + 1;

    private _tas_Proche = objNull;
    private _trouve_Tas = false;

    {
        if (!_trouve_Tas AND _x isKindOf "groundweaponholder" AND _x distance player < 2) then 
        {
            _tas_Proche = _x;
            _trouve_Tas = true;
        };
    } forEach nearestObjects [player, ["groundweaponholder"], 2];

    if (!isNull _tas_Proche) then 
    {
        _tas_Proche addMagazineCargoGlobal ["ALF_Buche", 1];
    } else 
    {
        private _conteneur_Buche = "groundweaponholder" createVehicle [0,0,0];
        _conteneur_Buche setPosATL getPosATL player;
        _conteneur_Buche addMagazineCargoGlobal ["ALF_Buche", 1];
    };

    {
        private _info_Arbres = _x getVariable ["info_Arbres", []];
        private _trouve = false;

        {
            if (!_trouve AND _x # 0 == _arbre_Id) then 
            {
                _x set [1, _coups_Donnes];
                _trouve = true;
            };
        } forEach _info_Arbres;

        _x setVariable ["info_Arbres", _info_Arbres, TRUE];
    } forEach _joueurs_Proches;

    if (_coups_Donnes >= _nombre_Coup_Necessaire) then 
    {
        [_arbre] remoteExecCall ["hideObjectGlobal", 2];

        {
            private _info_Arbres = _x getVariable ["info_Arbres", []];
            private _new_Arbres = [];

            {
                if (_x # 0 != _arbre_Id) then { _new_Arbres pushBack _x;};
            } forEach _info_Arbres;

            _x setVariable ["info_Arbres", _new_Arbres, TRUE];
        } forEach _joueurs_Proches;
    };
};