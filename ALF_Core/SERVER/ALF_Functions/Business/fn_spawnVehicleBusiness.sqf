//ALF_Server_fnc_spawnVehicleBusiness = {
private _vid = _this # 0;
private _sp = _this # 1;
private _dir = _this # 2;
private _unit = _this # 3;
private _siretstr = _this # 4;
private _membres = _this # 5;
private _uid = getPlayerUID _unit;

diag_log format ["[BUSINESS SPAWN] start vid=%1 unit=%2 uid=%3", _vid, name _unit, _uid];

private _query = format["SELECT classname, pid, alive, active, plate, gear, fuel, damage, insure, peinture FROM vehicles WHERE id='%1'",_vid];
private _queryResult = [_query,2] call ALF_Server_fnc_asyncCall;
if (_queryResult isEqualType "") exitWith {
    diag_log format ["[BUSINESS SPAWN] asyncCall failed for vid=%1", _vid];
};

private _vInfo = _queryResult;
if (isNil {_vInfo} OR {_vInfo isequalto []}) exitWith {
    diag_log format ["[BUSINESS SPAWN] vInfo empty for vid=%1", _vid];
};

private _className = _vInfo # 0;
private _pid = _vInfo # 1;
private _plaque = _vInfo # 4;
private _inventaire = _vInfo # 5;
private _fuel = _vInfo # 6;
private _liste_Degat = _vInfo # 7;
private _insure = _vInfo # 8;
private _peinture = _vInfo # 9;

private _batiment = ((nearestTerrainObjects [_unit, [], 30]) select {typeof _x isequalto "Land_ALF_Entreprise"}) # 0;

//Detection bat tropicAuto
if (_siretstr isEqualTo "732482693") then { 
	_batiment = ((nearestTerrainObjects [_unit, [], 30]) select {typeof _x isequalto "Land_MRP_Concessionnaire"}) # 0;
};

if (isNil {_batiment}) exitWith {
    diag_log "[BUSINESS SPAWN] building not found";
    ["INFO", "Erreur dans le système, batiment non trouvé.", "warning"] remoteExec ['ALF_fnc_doMsg',owner _unit];
};

private _veh = createVehicle [_className,[0,0,500 + random 500], [], 0, "NONE"];
waitUntil {sleep 0.3; !isNil {_veh} AND {!isNull _veh}};
_veh allowDamage false; 
diag_log format ["[BUSINESS SPAWN] vehicle created class=%1", _className];

// === HELIPAD OVERRIDE FOR SPECIFIC HELICOPTER CLASSES ===
private _placedOnHelipad = false;
private _heliClassesALF = [
    "V_ALF_Havok",
    "C_Heli_Light_01_civil_F",
    "V_ALF_PW207",
    "V_ALF_EC145",
    "V_ALF_EC135",
    "EC135Bleulu",
    "C_Plane_Civil_01_F"
];

if (_className in _heliClassesALF) then {
    private _centerPos = getPosATL _batiment; // center search around the building
    private _pads = nearestObjects [_centerPos, ["Land_HelipadCivil_F","Land_HelipadCircle_F","Land_HelipadSquare_F"], 100];
    diag_log format ["[BUSINESS SPAWN] helipads found=%1", count _pads];
    if !(_pads isEqualTo []) then {
        // sort by distance
        private _sorted = _pads apply { [_centerPos distance2D _x, _x] };
        _sorted sort true;
        {
            private _pad = _x # 1;
            // consider pad free if no units/vehicles within ~6m (ignore our own newly created vehicle)
            private _near = nearestObjects [getPosATL _pad, ["AllVehicles","Man"], 6];
            _near = _near select { _x != _veh };
            if ((count _near) isEqualTo 0) exitWith {
                private _posATL = getPosATL _pad;
                _veh setDir (getDir _pad);
                _veh setVectorUp (surfaceNormal _posATL);
                _veh setPosATL (_posATL vectorAdd [0,0,0.2]);
                _placedOnHelipad = true;
                diag_log "[BUSINESS SPAWN] placed on helipad";
            };
        } forEach _sorted;
    };
};
// === END HELIPAD OVERRIDE ===


// === BOAT OVERRIDE FOR SPECIFIC BOAT CLASSES ===
private _placedOnBoat = false;
private _BoatClassesALF = [
	"V_ALF_Racer_MRPV2",
	"C_Rubberboat_MRPV2",
	"C_Boat_Transport_02_F_MRPV2",
	"V_ALF_Speeder_MRPV2",
	"bateau_peche2",
	"bateau_peche1",
	"VEH_MRP_BM_Yatch",
	"Catamaran_CAMO",
	"class Catamaran_GY",
	"class Catamaran_Wiki_Tropic",
	"Catamaran_PI"
];

if (_className in _BoatClassesALF) then {
    private _centerPos = getPosATL player; // center search around the building
    private _pos = [[1596.314,10140.581,0],[1564.812,10139.439,0]]; //position Marine et rivière
	{
		if (_placedOnBoat) exitWith {};
		if (_x distance (getPosATL _batiment) < 100) then {
			private _near = nearestObjects [_x, ["AllVehicles","Man"], 6];
			_near = _near select { _x != _veh };
			if ((count _near) isEqualTo 0) then {
				_veh setPos (_x vectorAdd [0,0,0.2]);
				_placedOnBoat = true;
			};
		};
	} forEach _pos;
};
// === END BOAT OVERRIDE ===

// TROPIC AUTO
if (_siretstr isEqualTo "732482693") then {
    private _centerPos = getPosATL player; 
    private _pos = [[6812.728,7352.869,0],[6815.531,7358.358,0]]; //position Tropicauto
	{
		if (_placedOnBoat) exitWith {};
		if (_x distance (getPosATL _batiment) < 100) then {
			private _near = nearestObjects [_x, ["AllVehicles","Man"], 6];
			_near = _near select { _x != _veh };
			if ((count _near) isEqualTo 0) then {
				_veh setPos (_x vectorAdd [0,0,0.2]);
				_veh setdir 115.546;
				_placedOnBoat = true;
			};
		};
	} forEach _pos;
};




// ==== GÉOMÉTRIE / GARAGE ====
private _bbox = boundingBoxReal [_veh,"firegeometry"];
private _taille_X = abs (_bbox # 0 # 2);
private _taille_Y = abs (_bbox # 1 # 2);
private _rayon_Detection = _taille_X + _taille_Y;
private _pos_Garage_Externe = (_batiment getRelPos [18,-157]);
private _pos_Garage = (_batiment getRelPos [8,-70]);
private _pos_Garage_Z = getPosATL _unit # 2;
private _quitter_veh_Gene = FALSE;

if (_rayon_Detection > 3.1) then {_pos_Garage = _pos_Garage_Externe;};

// Véhicules dont la taille n'est pas correctement détectée
private _vehicules_Trop_Gros = [
    "VEH_Mercura_MRP_Man_TGS_Dep"
];
// Si le véhicule est dans le tableau, on force la position externe
if (_className in _vehicules_Trop_Gros) then {_pos_Garage = _pos_Garage_Externe;};

private _objets_Proches = _pos_Garage nearEntities [["Car","Air","Tank"],_rayon_Detection];
diag_log format ["[BUSINESS SPAWN] near garage objects=%1 radius=%2", count _objets_Proches, _rayon_Detection];

// ---- Garage/Helipad finalisation (NO 'else if' in SQF) ----
if (_placedOnHelipad || _placedOnBoat) then {
    // Already placed on helipad: finalize setup only (no garage placement)
    _veh lock 2;
    [_veh,TRUE] remoteExec ["lockInventory",0];
    _veh setVariable ["vehicle_info_owners",[name _unit,getPlayerUID _unit],true];
    _veh disableTIEquipment true;
    _veh animateSource ["tracker", 1, true];
    _veh setFuel _fuel;
    _veh setPlateNumber _plaque;
    _veh setVariable ["business_veh",[_siretstr],true];
    _veh setVariable ["dbInfo", [_pid, _plaque, _insure, 0, 0], true];
    [_veh] spawn {params ["_veh"]; sleep 2; _veh allowDamage true;};
    if !(isNil "_color") then { if (_color isNotEqualTo "") then { _veh setObjectTextureGlobal [0,_color]; }; };
    private _um = [];
    {_um pushBack (_x # 1);} forEach _membres;
    [_veh] remoteExecCall ["ALF_fnc_addVehicle2Chain",(playableUnits select {(getPlayerUID _x) in _um})];
    private _arr = missionNamespace getVariable [format["%1_KEYSB",_siretstr],[]];
    _arr pushBack _veh;
    _arr = _arr - [objNull];
    missionNamespace setVariable[format["%1_KEYSB",_siretstr],_arr,true];
    diag_log "[BUSINESS SPAWN] finalized on helipad/BOAT";
} else {
    if (_objets_Proches isEqualTo []) then {
        _veh setposatl (_pos_Garage vectorAdd [0,0,_pos_Garage_Z + 0.3]);
        _veh setVectorUp (surfaceNormal _pos_Garage);
        _veh setdir (getdir _batiment) + 180;

        _veh lock 2;
        [_veh,TRUE] remoteExec ["lockInventory",0];
        _veh setVariable ["vehicle_info_owners",[name _unit,getPlayerUID _unit],true];
        _veh disableTIEquipment true;
        // _veh animateSource ["assu", 1, true];
        _veh animateSource ["tracker", 1, true];
        _veh setFuel _fuel;
        _veh setPlateNumber _plaque;
        
        _veh setVariable ["business_veh",[_siretstr],true];
        _veh setVariable ["dbInfo", [_pid, _plaque, _insure, 0, 0], true];
        [_veh] spawn {params ["_veh"]; sleep 2; _veh allowDamage true;};

        if !(isNil "_color") then { if (_color isNotEqualTo "") then { _veh setObjectTextureGlobal [0,_color]; }; };

        private _um2 = [];
        {_um2 pushBack (_x # 1);} forEach _membres;

        [_veh] remoteExecCall ["ALF_fnc_addVehicle2Chain",(playableUnits select {(getPlayerUID _x) in _um2})];

        private _arr2 = missionNamespace getVariable [format["%1_KEYSB",_siretstr],[]];
        _arr2 pushBack _veh;
        _arr2 = _arr2 - [objNull];
        missionNamespace setVariable[format["%1_KEYSB",_siretstr],_arr2,true];   
        diag_log "[BUSINESS SPAWN] placed at garage";
    } else {
        ["INFO", "Un véhicule gène le point de sortie du garage.", "warning"] remoteExec ['ALF_fnc_doMsg',owner _unit];
        _quitter_veh_Gene = TRUE;
        diag_log "[BUSINESS SPAWN] garage exit blocked";
    };
};
if (_quitter_veh_Gene) exitWith {
    diag_log "[BUSINESS SPAWN] exit because blocked";
};

// Flag active en BDD (inchangé)
_query = format["UPDATE vehicles SET active='1' WHERE id='%1';", _vid];
diag_log format ["[BUSINESS SPAWN] SQL activate: %1", _query];
[_query, 1] spawn ALF_Server_fnc_asyncCall;

{
    private _degat = _x;
    private _parts = getAllHitPointsDamage _veh;
    [_veh,[(_parts # 0) # _foreachindex,_degat]] remoteExec ['setHitPointDamage',0];
} foreach _liste_Degat;

if (_insure > 0) then 
{
    ["Garage","Votre véhicule est disponible et assuré.","success"] remoteExec ["ALF_fnc_doMsg",owner _unit];
    _veh animateSource ["assu", 0, true];
} else 
{
    ["Garage","Votre véhicule est disponible et non assuré, attention vous n'êtes pas en règle.","warning"] remoteExec ["ALF_fnc_doMsg",owner _unit];
    _veh animateSource ["assu", 1, true];
};

if (_inventaire isNotEqualTo []) then {[_veh,_inventaire] call MRPV2_Server_fnc_Vehicule_Inventaire_Chargement;};

_veh animateSource ["tracker", 1, true];
_veh setVariable ["business_veh",[_siretstr],true];

if (_peinture isNotEqualTo []) then 
{
    private _classname = toLower (typeOf _veh);
    private _textureIndex = if ("_mrp_" in _classname) then {[11,12]} else {[0,0]};
    
    _veh setObjectTextureGlobal [_textureIndex # 0,(_peinture # 0)];
    _veh setObjectMaterialGlobal [_textureIndex # 1,(_peinture # 1)];
};

_plaque = _plaque splitString "";
_veh setObjectTextureGlobal [1, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plaque # 0]];
_veh setObjectTextureGlobal [2, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plaque # 1]];
_veh setObjectTextureGlobal [3, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plaque # 3]];
_veh setObjectTextureGlobal [4, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plaque # 4]];
_veh setObjectTextureGlobal [5, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plaque # 5]];
_veh setObjectTextureGlobal [6, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plaque # 7]];
_veh setObjectTextureGlobal [7, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plaque # 8]];
//};
