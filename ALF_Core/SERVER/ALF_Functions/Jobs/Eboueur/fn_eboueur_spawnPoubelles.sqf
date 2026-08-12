/*
    File: fn_eboueur_spawnPoubelles.sqf
    Author: MRP
    Description: SERVEUR - Spawn des poubelles
    
    OPTIMISATIONS BOHEMIA APPLIQUÉES:
    - Variables déclarées directement
    - isEqualTo au lieu de ==
    - for optimisé (2x plus rapide que forEach pour itérations simples)
*/

if (!isServer) exitWith {};

MRP_EBOUEUR_POUBELLESAU = [];
MRP_EBOUEUR_POUBELLESVA = [];
MRP_EBOUEUR_POUBELLESFR = [];
MRP_EBOUEUR_POUBELLESTR = [];
MRP_EBOUEUR_POUBELLESLO = [];
MRP_EBOUEUR_POUBELLESMA = [];
MRP_EBOUEUR_POUBELLESST = [];
MRP_EBOUEUR_POUBELLESFD = [];
MRP_EBOUEUR_POUBELLESAN = [];
MRP_EBOUEUR_POUBELLESMR = [];

_positionsPoubellesMarin = +MRP_EBOUEUR_POSITIONS_POUBELLES_MARIN;
_positionsPoubellesAnses = +MRP_EBOUEUR_POSITIONS_POUBELLES_ANSES;
_positionsPoubellesFDF = +MRP_EBOUEUR_POSITIONS_POUBELLES_FDF;
_positionsPoubellesStPierre = +MRP_EBOUEUR_POSITIONS_POUBELLES_STPIERRE;
_positionsPoubellesMacouba = +MRP_EBOUEUR_POSITIONS_POUBELLES_MACOUBA;
_positionsPoubellesLorrain = +MRP_EBOUEUR_POSITIONS_POUBELLES_LORRAIN;
_positionsPoubellesTrinite = +MRP_EBOUEUR_POSITIONS_POUBELLES_TRINITE;
_positionsPoubellesFrancois = +MRP_EBOUEUR_POSITIONS_POUBELLES_FRANCOIS;
_positionsPoubellesVauclin = +MRP_EBOUEUR_POSITIONS_POUBELLES_VAUCLIN;
_positionsPoubellesAutoroute = +MRP_EBOUEUR_POSITIONS_POUBELLES_AUTOROUTE;


private _nbPositionsTotalMarin = count _positionsPoubellesMarin;
private _nbPositionsTotalAnses = count _positionsPoubellesAnses;
private _nbPositionsTotalFDF = count _positionsPoubellesFDF;
private _nbPositionsTotalStPierre = count _positionsPoubellesStPierre;
private _nbPositionsTotalMacouba = count _positionsPoubellesMacouba;
private _nbPositionsTotalLorrain = count _positionsPoubellesLorrain;
private _nbPositionsTotalTrinite = count _positionsPoubellesTrinite;
private _nbPositionsTotalFrancois = count _positionsPoubellesFrancois;
private _nbPositionsTotalVauclin = count _positionsPoubellesVauclin;
private _nbPositionsTotalAutoroute = count _positionsPoubellesAutoroute;

private _nbPositionsASpawnMR = ceil (_nbPositionsTotalMarin * (0.5 + random 0.5));
private _nbPositionsASpawnAN = ceil (_nbPositionsTotalAnses * (0.5 + random 0.5));
private _nbPositionsASpawnFD = ceil (_nbPositionsTotalFDF * (0.5 + random 0.5));
private _nbPositionsASpawnST = ceil (_nbPositionsTotalStPierre * (0.5 + random 0.5));
private _nbPositionsASpawnMA = ceil (_nbPositionsTotalMacouba * (0.5 + random 0.5));
private _nbPositionsASpawnLO = ceil (_nbPositionsTotalLorrain * (0.5 + random 0.5));
private _nbPositionsASpawnTR = ceil (_nbPositionsTotalTrinite * (0.5 + random 0.5));
private _nbPositionsASpawnFR = ceil (_nbPositionsTotalFrancois * (0.5 + random 0.5));
private _nbPositionsASpawnVA = ceil (_nbPositionsTotalVauclin * (0.5 + random 0.5));
private _nbPositionsASpawnAU = ceil (_nbPositionsTotalAutoroute * (0.5 + random 0.5));


private _positionsSelectionneesMR = [];
private _positionsSelectionneesAN = [];
private _positionsSelectionneesFD = [];
private _positionsSelectionneesST = [];
private _positionsSelectionneesMA = [];
private _positionsSelectionneesLO = [];
private _positionsSelectionneesTR = [];
private _positionsSelectionneesFR = [];
private _positionsSelectionneesVA = [];
private _positionsSelectionneesAU = [];

for "_i" from 1 to _nbPositionsASpawnMR do {
	private _randomPos = selectRandom _positionsPoubellesMarin;
	_positionsSelectionneesMR pushBack _randomPos;
	_positionsPoubellesMarin = _positionsPoubellesMarin - [_randomPos];
};

for "_i" from 1 to _nbPositionsASpawnAN do {
	private _randomPos = selectRandom _positionsPoubellesAnses;
	_positionsSelectionneesAN pushBack _randomPos;
	_positionsPoubellesAnses = _positionsPoubellesAnses - [_randomPos];
};

for "_i" from 1 to _nbPositionsASpawnFD do {
	private _randomPos = selectRandom _positionsPoubellesFDF;
	_positionsSelectionneesFD pushBack _randomPos;
	_positionsPoubellesFDF = _positionsPoubellesFDF - [_randomPos];
};

for "_i" from 1 to _nbPositionsASpawnST do {
	private _randomPos = selectRandom _positionsPoubellesStPierre;
	_positionsSelectionneesST pushBack _randomPos;
	_positionsPoubellesStPierre = _positionsPoubellesStPierre - [_randomPos];
};

for "_i" from 1 to _nbPositionsASpawnMA do {
	private _randomPos = selectRandom _positionsPoubellesMacouba;
	_positionsSelectionneesMA pushBack _randomPos;
	_positionsPoubellesMacouba = _positionsPoubellesMacouba - [_randomPos];
};

for "_i" from 1 to _nbPositionsASpawnLO do {
	private _randomPos = selectRandom _positionsPoubellesLorrain;
	_positionsSelectionneesLO pushBack _randomPos;
	_positionsPoubellesLorrain = _positionsPoubellesLorrain - [_randomPos];
};

for "_i" from 1 to _nbPositionsASpawnTR do {
	private _randomPos = selectRandom _positionsPoubellesTrinite;
	_positionsSelectionneesTR pushBack _randomPos;
	_positionsPoubellesTrinite = _positionsPoubellesTrinite - [_randomPos];
};

for "_i" from 1 to _nbPositionsASpawnFR do {
	private _randomPos = selectRandom _positionsPoubellesFrancois;
	_positionsSelectionneesFR pushBack _randomPos;
	_positionsPoubellesFrancois = _positionsPoubellesFrancois - [_randomPos];
};

for "_i" from 1 to _nbPositionsASpawnVA do {
	private _randomPos = selectRandom _positionsPoubellesVauclin;
	_positionsSelectionneesVA pushBack _randomPos;
	_positionsPoubellesVauclin = _positionsPoubellesVauclin - [_randomPos];
};

for "_i" from 1 to _nbPositionsASpawnAU do {
	private _randomPos = selectRandom _positionsPoubellesAutoroute;
	_positionsSelectionneesAU pushBack _randomPos;
	_positionsPoubellesAutoroute = _positionsPoubellesAutoroute - [_randomPos];
};




private _pairs = [
    [_positionsSelectionneesMR, MRP_EBOUEUR_POUBELLESMR,"MR"],
    [_positionsSelectionneesAN, MRP_EBOUEUR_POUBELLESAN,"AN"],
    [_positionsSelectionneesFD, MRP_EBOUEUR_POUBELLESFD,"FD"],
    [_positionsSelectionneesST, MRP_EBOUEUR_POUBELLESST,"ST"],
    [_positionsSelectionneesMA, MRP_EBOUEUR_POUBELLESMA,"MA"],
    [_positionsSelectionneesLO, MRP_EBOUEUR_POUBELLESLO,"LO"],
    [_positionsSelectionneesTR, MRP_EBOUEUR_POUBELLESTR,"TR"],
    [_positionsSelectionneesFR, MRP_EBOUEUR_POUBELLESFR,"FR"],
    [_positionsSelectionneesVA, MRP_EBOUEUR_POUBELLESVA,"VA"],
    [_positionsSelectionneesAU, MRP_EBOUEUR_POUBELLESAU,"AU"]
];



private _array = _pairs;

for "_i" from 1 to 5 do {
    if (count _array > 0) then {
        private _index = floor (random (count _array));
        _array deleteAt _index;
    };
};

private _prefixes = [];

{
    private _prefix = _x select 2;
    _prefixes pushBack _prefix;

} forEach _array;

missionNamespace setVariable ["MRP_Eboueur_ZoneDispo", _prefixes, true];

{
    _x params ["_positions", "_arrayCible", "_prefix"];	
	
    {
        private _pos = _x;

        private _poubelle = "MRP_Poubelle" createVehicle _pos;
        _poubelle setPosATL _pos;
        _poubelle setDir (random 360);

        private _nbOrdures = 1 + floor random 5;
        _poubelle setVariable ["MRP_Eboueur_NbOrdures", _nbOrdures, true];
		_poubelle setVariable ["MRP_Eboueur_Zone", _prefix, true];

        clearItemCargoGlobal _poubelle;
        clearMagazineCargoGlobal _poubelle;

        for "_i" from 1 to _nbOrdures do {
            _poubelle addItemCargoGlobal ["MRP_Ordure", 1];
        };

        _arrayCible pushBack _poubelle;

    } forEach _positions;

} forEach _array;

publicVariable "MRP_EBOUEUR_POUBELLESAU";
publicVariable "MRP_EBOUEUR_POUBELLESVA";
publicVariable "MRP_EBOUEUR_POUBELLESFR";
publicVariable "MRP_EBOUEUR_POUBELLESTR";
publicVariable "MRP_EBOUEUR_POUBELLESLO";
publicVariable "MRP_EBOUEUR_POUBELLESMA";
publicVariable "MRP_EBOUEUR_POUBELLESST";
publicVariable "MRP_EBOUEUR_POUBELLESFD";
publicVariable "MRP_EBOUEUR_POUBELLESAN";
publicVariable "MRP_EBOUEUR_POUBELLESMR";
