/*
waitUntil { !isNull MRPV2_PNJ_CRIME_DEALER AND !isNull MRPV2_PNJ_CRIME_BRICO  AND !isNull MRPV2_PNJ_CRIME_CAGOULE };

// Placement initial de brico
private _r1 = selectRandom [1,2,3];
private _objet_Attacher = attachedTo MRPV2_PNJ_CRIME_BRICO;

switch (_r1) do 
{
	case 1 : { _objet_Attacher  setPosATL [8784.25,3654.08,0.00143909]; _objet_Attacher  setDir 16; };
	case 2 : { _objet_Attacher  setPosATL [5175.49,7105.02,0.00143909]; _objet_Attacher  setDir 22; };
	case 3 : { _objet_Attacher  setPosATL [323.242,8763.98,0.325512]; _objet_Attacher  setDir 99; };
};

// Placement fixe de cogoule
private _objet_Attacher = attachedTo MRPV2_PNJ_CRIME_CAGOULE;

// Position et direction fixes :
_objet_Attacher setPosATL [8335.67,931.017,0.00143814];
_objet_Attacher setDir 207;

/*
private _r2 = selectRandom [1,2];
private _objet_Attacher = attachedTo MRPV2_PNJ_CRIME_CAGOULE;

switch (_r2) do 
{ 
	case 1 : {_objet_Attacher setPosATL [8335.67,931.017,0.00143814]; _objet_Attacher setDir 207;};
	case 2 : {_objet_Attacher setPosATL [3006.67,4276.17,0.00143862]; _objet_Attacher setDir 128;};
};
*/
/*
// Position du labo
private _labPos = [6227.51, 7929.0, 1.0];

// Création du labo
private _lab = createVehicle ["ALF_LaboMeth", [0,0,0], [], 0, "NONE"];
_lab setDir 359;
_lab setPosATL _labPos;

// Création de la table
private _table = createVehicle ["ALF_TableMeth", [0,0,0], [], 0, "NONE"];
private _tablePos = _lab modelToWorld [-1.25, 2.7, -1.3];
_table setPosATL _tablePos;
_table setDir (getDir _lab - 90);
_table setVectorUp surfaceNormal getPosASL _table;

// deplace du trigger 
zone_decl_meth attachTo [_lab, [0, 0, 0]];
*/



// Pause de 1 heure (3600 secondes)
//sleep 1800;
/*
// Relocalisation du dealer après 1 heure
private _r = selectRandom [1];
private _objet_Attacher = attachedTo MRPV2_PNJ_CRIME_DEALER;

switch (_r) do 
{ 
	case 1 : {_objet_Attacher setPosATL [3300.97,8037.57,0.117535]; _objet_Attacher setDir 49;};
};


private _objet_Attacher = attachedTo MRPV2_PNJ_CRIME_DEALER;

// Position et direction fixes :
_objet_Attacher setPosATL [3300.97, 8037.57, 0.117535];
_objet_Attacher setDir 49;


/*
	case 1 : {_objet_Attacher setPosATL [1898.88,7019.41,0.00130463]; obj_dealer setDir 49;};
	case 1 : {_objet_Attacher setPosATL [7726.19,7274.18,0.00143814]; _objet_Attacher setDir 129;};
	case 2 : {_objet_Attacher setPosATL [3838.67,9329.14,4.17225]; _objet_Attacher setDir 40;};
	case 3 : {_objet_Attacher setPosATL [1254.03,7182.82,0.352113]; _objet_Attacher setDir 127;};
*/


/*
ALF_fnc_ALF_Dealer = { 
waitUntil {
};

private _r1 = selectRandom [1, 2, 3];

switch (_r1) do {
    case 1: { MRPV2_PNJ_CRIME_BRICO setPosATL [8784.25, 3654.08, 0.00143909]; MRPV2_PNJ_CRIME_BRICO setDir 16; };
    case 2: { MRPV2_PNJ_CRIME_BRICO setPosATL [5175.49, 7105.02, 0.00143909]; MRPV2_PNJ_CRIME_BRICO setDir 22; };
    case 3: { MRPV2_PNJ_CRIME_BRICO setPosATL [323.242, 8763.98, 0.325512]; MRPV2_PNJ_CRIME_BRICO setDir 99; };
};


MRPV2_PNJ_CRIME_CAGOULE setPosATL [8335.67, 931.017, 0.00143814]; MRPV2_PNJ_CRIME_CAGOULE setDir 207;

MRPV2_PNJ_CRIME_DEALER setPosATL [3300.97, 8037.57, 0.117535]; MRPV2_PNJ_CRIME_DEALER setDir 49;
};
*/


waitUntil {
  !isNull MRPV2_PNJ_CRIME_DEALER &&
  !isNull MRPV2_PNJ_CRIME_BRICO &&
  !isNull MRPV2_PNJ_CRIME_CAGOULE && 
  !isNull MRPV2_PNJ_CRIME_RECELEUR
};
    
{detach _x;} forEach [MRPV2_PNJ_CRIME_DEALER, MRPV2_PNJ_CRIME_BRICO, MRPV2_PNJ_CRIME_CAGOULE, MRPV2_PNJ_CRIME_RECELEUR];
    
private _r1 = selectRandom [1, 2, 3];
switch (_r1) do {
    case 1: { MRPV2_PNJ_CRIME_BRICO setPosATL [8784.25, 3654.08, 0.00143909]; MRPV2_PNJ_CRIME_BRICO setDir 16;};
    case 2: { MRPV2_PNJ_CRIME_BRICO setPosATL [5175.49, 7105.02, 0.00143909]; MRPV2_PNJ_CRIME_BRICO setDir 22;};
    case 3: { MRPV2_PNJ_CRIME_BRICO setPosATL [323.242, 8763.98, 0.325512]; MRPV2_PNJ_CRIME_BRICO setDir 99;};
};
    
MRPV2_PNJ_CRIME_CAGOULE setPosATL [8335.67, 931.017, 0.00143814]; MRPV2_PNJ_CRIME_CAGOULE setDir 207;


//MRPV2_PNJ_CRIME_DEALER setPosATL [3286.08,7985.32,0.00143814]; MRPV2_PNJ_CRIME_DEALER setDir 245;

private _r2 = selectRandom [1, 2, 3];
switch (_r2) do {
    case 1: { MRPV2_PNJ_CRIME_DEALER setPosATL [3423.16, 8647.1, 0.00147629]; MRPV2_PNJ_CRIME_DEALER setDir 240;};
    case 2: { MRPV2_PNJ_CRIME_DEALER setPosATL [3027.85,4173.7,0.00143886]; MRPV2_PNJ_CRIME_DEALER setDir 215;};
    case 3: { MRPV2_PNJ_CRIME_DEALER setPosATL [8372.15, 1805.62, 0.381769]; MRPV2_PNJ_CRIME_DEALER setDir 302;};
};


MRPV2_PNJ_CRIME_RECELEUR setPosATL [3361.764,4097.935,0]; MRPV2_PNJ_CRIME_RECELEUR setDir 177.028;


private _posHangar = [9445.8, 1387.0, 0.2];  
private _dirHangar = 100;  
  
private _hangar = createVehicle ["Land_i_Shed_Ind_F", _posHangar, [], 0, "NONE"];  
_hangar setDir _dirHangar;  
  
private _attachedObjects = [  
    ["Land_model_1", [3.25, 3.5, 0.6], 260],  
    ["Land_ALF_Plante_W", [9.5, 1, -0.5], 0],  
    ["Land_ALF_Plante_W", [8.5, 3, -0.5], 45],  
    ["Land_ALF_Plante_W", [6.1, 0, -0.5], 180],  
    ["Land_ALF_Plante_W", [5, 3, -0.5], 90],  
    ["Land_ALF_Plante_W", [2.3, 3, -0.5], 0],  
    ["Land_ALF_Plante_W", [2.5, 0, -0.5], 45],  
    ["Land_ALF_Plante_W", [-1.0, 3, -0.5], 180],  
    ["Land_ALF_Plante_W", [-0.5, 0.5, -0.5], 90]  
];  
 
{ 
    private _class = _x#0; 
    private _offset = _x#1; 
    private _dir = _x#2; 
 
    private _obj = createVehicle [_class, [0,0,0], [], 0, "NONE"]; 
    _obj attachTo [_hangar, _offset]; 
    _obj setDir (_dir + _dirHangar); 
    _obj setVectorUp [0,0,1]; 
} forEach _attachedObjects; 




private _posHangar1 = [2127.1,9115.92,0.1];
private _dirHangar1 = 10;

private _hangar1 = createVehicle ["Land_i_Shed_Ind_F", _posHangar1, [], 0, "NONE"];
_hangar1 setDir _dirHangar1;

private _attachedObjects1 = [
    ["Land_ALF_Coco", [3.60, 3.5, 0.6], 350]
];

{
    private _class = _x#0;
    private _offset = _x#1;
    private _dir = _x#2;

    private _obj = createVehicle [_class, [0,0,0], [], 0, "NONE"];
    _obj attachTo [_hangar1, _offset];
    _obj setDir (_dir + _dirHangar1);
    _obj setVectorUp [0,0,1];
} forEach _attachedObjects1;

private _posHangar2 = [5500.73,3823.31,0.8];
private _dirHangar2 = 360;

private _hangar2 = createVehicle ["Land_i_Shed_Ind_F", _posHangar2, [], 0, "NONE"];
_hangar2 setDir _dirHangar2;

private _attachedObjects2 = [
    ["Land_ALF_Coco", [3.60, 3.5, 0.5], 360]
];

{
    private _class = _x#0;
    private _offset = _x#1;
    private _dir = _x#2;

    private _obj = createVehicle [_class, [0,0,0], [], 0, "NONE"];
    _obj attachTo [_hangar2, _offset];
    _obj setDir (_dir + _dirHangar2);
    _obj setVectorUp [0,0,1];
} forEach _attachedObjects2;

private _posHangar3 = [5623.63, 7714.61, 0.6];  
private _dirHangar3 = 360;  
  
private _hangar3 = createVehicle ["Land_i_Shed_Ind_F", _posHangar3, [], 0, "NONE"];  
_hangar3 setDir _dirHangar3;  
  
private _attachedObjects3 = [  
    ["Land_model_1", [3.25, 3.5, 0.6], 0],  
    ["Land_ALF_Plante_W", [9.5, 1, -0.5], 0],  
    ["Land_ALF_Plante_W", [8.5, 3, -0.5], 45],  
    ["Land_ALF_Plante_W", [6.1, 0, -0.5], 180],  
    ["Land_ALF_Plante_W", [5, 3, -0.5], 90],  
    ["Land_ALF_Plante_W", [2.3, 3, -0.5], 0],  
    ["Land_ALF_Plante_W", [2.5, 0, -0.5], 45],  
    ["Land_ALF_Plante_W", [-1.0, 3, -0.5], 180],  
    ["Land_ALF_Plante_W", [-0.5, 0.5, -0.5], 90]  
];  
 
{ 
    private _class = _x#0; 
    private _offset = _x#1; 
    private _dir = _x#2; 
 
    private _obj = createVehicle [_class, [0,0,0], [], 0, "NONE"]; 
    _obj attachTo [_hangar3, _offset]; 
    _obj setDir (_dir + _dirHangar3); 
    _obj setVectorUp [0,0,1]; 
} forEach _attachedObjects3;

// Position du labo
private _labPos = [6390.76, 2459.50, 1.5];

// Création du labo
private _lab = createVehicle ["ALF_LaboMeth", [0,0,0], [], 0, "NONE"];
_lab setDir 0;
_lab setPosATL _labPos;

// Création de la table
private _table = createVehicle ["ALF_TableMeth", [0,0,0], [], 0, "NONE"];
private _tablePos = _lab modelToWorld [-1.25, 2.7, -1.3];
_table setPosATL _tablePos;
_table setDir (getDir _lab - 90);
_table setVectorUp surfaceNormal getPosASL _table;

// deplace du trigger 
zone_decl_meth attachTo [_lab, [0, 0, 0]];

// Position de la zone de craft 1
private _craftPos = [1440.26, 8705.24, 0.4];

// création du hangar
private _hang = createVehicle ["Land_shed_03_F", [0,0,0], [], 0, "NONE"];
_hang setDir 0;
_hang setPosATL _craftPos;

// création de la table
private _tableCraft = createVehicle ["Land_table_weed", [0,0,0], [], 0, "NONE"];

// position relative dans le hangar
private _tableCraftPos = _hang modelToWorld [2, 0.3, 0];
_tableCraft setPosATL _tableCraftPos;

// orientation
_tableCraft setDir (getDir _hang - 90);

// alignement au sol
_tableCraft setVectorUp (surfaceNormal (getPosASL _tableCraft));

// Position de la zone de craft 2
private _craftPos1 = [7507.71, 1599.17, 0];

// création du hangar
private _hang = createVehicle ["Land_shed_03_F", [0,0,0], [], 0, "NONE"];
_hang setDir 0;
_hang setPosATL _craftPos1;

// création de la table
private _tableCraft1 = createVehicle ["Land_table_weed", [0,0,0], [], 0, "NONE"];

// position relative dans le hangar
private _tableCraftPos1 = _hang modelToWorld [2, 0, 0];
_tableCraft1 setPosATL _tableCraftPos1;

// orientation
_tableCraft1 setDir (getDir _hang - 90);

// alignement au sol
_tableCraft1 setVectorUp (surfaceNormal (getPosASL _tableCraft1));

/*
ALF_fnc_ALF_Dealer = {
    
    waitUntil {
        !isNil "MRPV2_PNJ_CRIME_DEALER" &&
        !isNil "MRPV2_PNJ_CRIME_BRICO" &&
        !isNil "MRPV2_PNJ_CRIME_CAGOULE" &&
        {!isNull MRPV2_PNJ_CRIME_DEALER} &&
        {!isNull MRPV2_PNJ_CRIME_BRICO} &&
        {!isNull MRPV2_PNJ_CRIME_CAGOULE}
    };

    
    systemChat "[DEBUG] ALF_Dealer lancé correctement";

    
    {
        if (!isNull _x) then { detach _x; };
    } forEach [MRPV2_PNJ_CRIME_DEALER, MRPV2_PNJ_CRIME_BRICO, MRPV2_PNJ_CRIME_CAGOULE];

    
    private _r1 = selectRandom [1, 2, 3];
    private _posDirList = [
        [[8784.25, 3654.08, 0.00143909], 16],
        [[5175.49, 7105.02, 0.00143909], 22],
        [[323.242, 8763.98, 0.325512], 99]
    ];

    private _data = _posDirList select (_r1 - 1);
    MRPV2_PNJ_CRIME_BRICO setPosATL (_data select 0);
    MRPV2_PNJ_CRIME_BRICO setDir (_data select 1);

    
    MRPV2_PNJ_CRIME_CAGOULE setPosATL [8335.67, 931.017, 0.00143814];
    MRPV2_PNJ_CRIME_CAGOULE setDir 207;

    
    sleep 1800;

    
    MRPV2_PNJ_CRIME_DEALER setPosATL [3300.97, 8037.57, 0.117535];
    MRPV2_PNJ_CRIME_DEALER setDir 49;
};

private _posHangar = [8775.2, 1655.61, 0.2]; 
private _dirHangar = 180; 
 
private _hangar = createVehicle ["Land_i_Shed_Ind_F", _posHangar, [], 0, "NONE"]; 
_hangar setDir _dirHangar; 
 
private _attachedObjects = [ 
    ["Land_model_1", [3.25, 3.5, 0.6], 180], 
    ["Land_ALF_Plante_W", [9.5, 1, -0.5], 0], 
    ["Land_ALF_Plante_W", [8.5, 3, -0.5], 45], 
    ["Land_ALF_Plante_W", [6.1, 0, -0.5], 180], 
    ["Land_ALF_Plante_W", [5, 3, -0.5], 90], 
    ["Land_ALF_Plante_W", [2.3, 3, -0.5], 0], 
    ["Land_ALF_Plante_W", [2.5, 0, -0.5], 45], 
    ["Land_ALF_Plante_W", [-1.0, 3, -0.5], 180], 
    ["Land_ALF_Plante_W", [-0.5, 0.5, -0.5], 90] 
]; 
 
{ 
    private _class = _x#0; 
    private _offset = _x#1; 
    private _dir = _x#2; 
 
    private _obj = createVehicle [_class, [0,0,0], [], 0, "NONE"]; 
    _obj attachTo [_hangar, _offset]; 
    _obj setDir (_dir + _dirHangar); 
    _obj setVectorUp [0,0,1]; 
} forEach _attachedObjects; 




nomBotTS = "JackyRondel";
classeObjet = "Land_DataTerminal_01_F";
distanceAudible = 20;

boomboxMusique = createVehicle [classeObjet, getPosATL player, [], 0, "NONE"];
boomboxMusique setDir (getDir player);
boomboxMusique setPosATL getPosATL player;

systemChat "[BOOMBOX] 🎶 Créée. Bot audible selon la distance.";

[] spawn {
    waitUntil {!isNull player};
    botMuted = true;

    while {true} do {
        sleep 2;

        if (isNil "boomboxMusique" || {isNull boomboxMusique}) exitWith {
            systemChat "[BOOMBOX] Supprimée.";
        };

        inZone = player distance boomboxMusique < distanceAudible;

        if (inZone && botMuted) then {
            botMuted = false;
            [nomBotTS, getPosASL boomboxMusique] call TFAR_fnc_setClientPosition;
            systemChat "[BOOMBOX] 🔊 Tu entres dans la zone : musique audible.";
        };

        if (!inZone && !botMuted) then {
            botMuted = true;
            [nomBotTS, [0,0,0]] call TFAR_fnc_setClientPosition;
            systemChat "[BOOMBOX] 🔇 Tu quittes la zone : musique coupée.";
        };
    };
};


private _posCentre = position player;
private _rayon = 20;

{
    if (lifestate _x isEqualTo "INCAPACITATED") then {
        _x setUnconscious false;
        [_x] spawn ALF_fnc_revivePlayer;
    };
} forEach (allPlayers select {(_x distance _posCentre) < _rayon});


*/
