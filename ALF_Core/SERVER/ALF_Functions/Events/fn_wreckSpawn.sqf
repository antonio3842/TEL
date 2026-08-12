#include "\ALF_Core\SERVER\script_macros.hpp"
/*
    ALF_Server_fnc_wreckSpawn
    - Si spawn dans l'eau : épave visuelle + caisse avec items.
    - Si spawn sur terre : uniquement caisse au fond de l'eau avec items (pas d'épave visuelle).
    - COOLDOWN DE SPAWN = 20 min (évite les spams si start est appelé en boucle).
    - AUTO-DESPAWN après 20 min (épave + caisse).
    - AUCUN MARKER créé (cleanup rétro-compat au début si un ancien existe).
*/
if (!isServer) exitWith { diag_log "[WRECK EVENT] ABORT: not server"; objNull };

// === PARAMS debug: [[x,y,z]] call ALF_Server_fnc_wreckSpawn;
params [["_forcePosASL", objNull, [[], objNull]]];

// === COOLDOWN GLOBAL de spawn (même pour "force") ===
private _despawnDelaySec = 1200;                         // 20 min
private _now = time;
private _nextAllowed = missionNamespace getVariable ["ALF_wreckEvent_nextAllowedSpawn", 0];
if (_now < _nextAllowed) exitWith { objNull };
missionNamespace setVariable ["ALF_wreckEvent_nextAllowedSpawn", _now + _despawnDelaySec, true];

// === CONFIG épaves candidates (fallbacks) ===
private _wreckClassCandidates = [
    "Land_Wreck_Traw2_F",
    "Land_Wreck_Traw_F",
    "Land_Boat_04_wreck_F",
    "Land_Boat_05_wreck_F",
    "Land_Boat_06_wreck_F",
    "Land_UWreck_FishingBoat_F",
    "Land_UWreck_FishingBoat_01_F",
    "Land_ShipWreck_01_F"
];

private _possiblePosASL = [
    [798.311, 4594.279, -20.50],
    [6715.078,  482.870, -20.50]
];

// Configuration des items à mettre dans la caisse
private _magazines = [
    ["ALF_diamant_taille", [5, 15] call BIS_fnc_randomInt],
    ["ALF_diamant_precieux", [3, 10] call BIS_fnc_randomInt],
    ["bouteille_rhum", [8, 20] call BIS_fnc_randomInt]
];

// Items supplémentaires (optionnel, peut être étendu)
private _items = [
    // Ajoutez ici d'autres items si nécessaire
];

// Variables globales
private _gVarWreck  = "ALF_wreckEvent_currentWreck";
private _gVarCrate  = "ALF_wreckEvent_currentCrate";

// --- LOG
diag_log "[WRECK EVENT] ---- START wreckSpawn ----";

// CLEAN ancien (caisse + épave)
{
    private _name = _x;
    private _obj  = missionNamespace getVariable [_name, objNull];
    if (!isNull _obj) then { deleteVehicle _obj; diag_log format ["[WRECK EVENT] Deleted %1", _name]; };
    missionNamespace setVariable [_name, objNull, true];
} forEach ["ALF_wreckEvent_currentCrate", "ALF_wreckEvent_currentWreck"];

// CLEAN rétro-compat d'un ancien marker si présent (on n'en crée plus)
{
    private _oldMarker = missionNamespace getVariable [_x, ""];
    if (_oldMarker isEqualType "" && {_oldMarker != ""}) then {
        deleteMarker _oldMarker;
        missionNamespace setVariable [_x, "", true];
        diag_log format ["[WRECK EVENT] Deleted legacy marker %1", _oldMarker];
    };
} forEach ["ALF_wreckEvent_markerName"]; // ancien nom global

// Sélection position
private _posASL = if (_forcePosASL isEqualType [] && {count _forcePosASL == 3})
    then {_forcePosASL} else {selectRandom _possiblePosASL};
private _posATL  = ASLToATL _posASL;
private _isWater = surfaceIsWater _posATL;

diag_log format ["[WRECK EVENT] Candidate ASL pos: %1", _posASL];
diag_log format ["[WRECK EVENT] surfaceIsWater(ATL %1) = %2", _posATL, _isWater];

private _wreck = objNull;
private _cratePosATL = _posATL;
private _spawnInWater = false;

// Si la position n'est PAS dans l'eau, trouver une position dans l'eau proche
if (!_isWater) then {
    diag_log "[WRECK EVENT] Position sur terre détectée -> recherche position dans l'eau proche";
    
    // Chercher une position dans l'eau à proximité (rayon de 500m)
    private _waterPosFound = false;
    private _searchRadius = 500;
    private _attempts = 0;
    private _maxAttempts = 20;
    
    while {!_waterPosFound && _attempts < _maxAttempts} do {
        private _testPos = _posATL getPos [_searchRadius * (sqrt random 1), random 360];
        _testPos set [2, -20]; // Profondeur sous l'eau
        
        if (surfaceIsWater _testPos) then {
            _cratePosATL = _testPos;
            _posASL = ATLToASL _testPos;
            _waterPosFound = true;
            diag_log format ["[WRECK EVENT] Position dans l'eau trouvée: %1", _cratePosATL];
        };
        _attempts = _attempts + 1;
    };
    
    // Si aucune position dans l'eau trouvée, utiliser une position par défaut dans l'eau
    if (!_waterPosFound) then {
        private _defaultPosASL = selectRandom _possiblePosASL;
        _cratePosATL = ASLToATL _defaultPosASL;
        _posASL = _defaultPosASL;
        diag_log "[WRECK EVENT] Aucune position dans l'eau trouvée -> utilisation position par défaut";
    };
    
    _spawnInWater = true; // On va spawner dans l'eau mais sans épave visuelle
} else {
    // Position dans l'eau -> on spawn l'épave visuelle + caisse
    _spawnInWater = true;
    
    // Classe épave disponible
    private _selectedClass = "";
    {
        if (isClass (configFile >> "CfgVehicles" >> _x)) exitWith { _selectedClass = _x; };
    } forEach _wreckClassCandidates;
    
    if (_selectedClass isEqualTo "") then {
        diag_log "[WRECK EVENT] ERROR: no valid wreck class in CfgVehicles. Will spawn crate only.";
    } else {
        // Spawn épave (createVehicle -> fallback createSimpleObject)
        _wreck = createVehicle [_selectedClass, _posATL, [], 0, "CAN_COLLIDE"];
        if (isNull _wreck) then {
            diag_log format ["[WRECK EVENT] createVehicle failed for %1. Trying createSimpleObject ...", _selectedClass];
            private _model = getText (configFile >> "CfgVehicles" >> _selectedClass >> "model");
            if (_model isEqualType "" && {_model != ""}) then {
                _wreck = createSimpleObject [_model, _posASL];
                if (!isNull _wreck) then {
                    _wreck setPosASL _posASL;
                    _wreck setVectorUp [0,0,1];
                    _wreck setDir (random 360);
                };
            } else {
                diag_log format ["[WRECK EVENT] No model path for %1 -> cannot createSimpleObject.", _selectedClass];
            };
        } else {
            _wreck setPosASL _posASL;
            _wreck setVectorUp [0,0,1];
            _wreck setDir (random 360);
            _wreck enableSimulationGlobal true;
        };
        
        if (!isNull _wreck) then {
            _cratePosATL = getPosATL _wreck;
        };
    };
};

// Spawn de la caisse (toujours au fond de l'eau)
private _cratePosASL = ATLToASL _cratePosATL;
// Ajuster la profondeur pour que la caisse soit au fond
_cratePosASL set [2, (_cratePosASL select 2) - 5]; // 5 mètres sous la surface

private _crate = createVehicle ["GroundWeaponHolder_Scripted", [0,0,0], [], 0, "CAN_COLLIDE"];
_crate setPosASL _cratePosASL;
_crate allowDamage false;

// Ajout des magazines dans la caisse
{
    _x params ["_magClass","_count"];
    if (_count > 0) then { _crate addMagazineCargoGlobal [_magClass, _count]; };
} forEach _magazines;

// Ajout des items dans la caisse (si configurés)
{
    _x params ["_itemClass","_count"];
    if (_count > 0) then { _crate addItemCargoGlobal [_itemClass, _count]; };
} forEach _items;

missionNamespace setVariable [_gVarCrate, _crate, true];
if (!isNull _wreck) then {
    missionNamespace setVariable [_gVarWreck, _wreck, true];
};

diag_log format [
    "[WRECK EVENT] Result: wreck=%1 | crate @ %2 (profondeur: %3m) avec %4 types de magazines",
    !isNull _wreck, _cratePosATL, (_cratePosASL select 2), count _magazines
];

// Annonce BFM
private _title = if (!isNull _wreck) then {"FLASH : Épave en mer"} else {"FLASH : Caisse en mer"};
private _msg   = format [
    if (!isNull _wreck) then {
        "Une épave vient d'être repérée en mer. Coordonnées approx. : %1. Situation à suivre"
    } else {
        "Une caisse flottante vient d'être repérée en mer. Coordonnées approx. : %1. Situation à suivre"
    },
    mapGridPosition (if (!isNull _wreck) then { getPosWorld _wreck } else { ATLToASL _cratePosATL })
];
if (isMultiplayer) then {
    [_title,_msg] remoteExec ["ALF_fnc_doBfmO", -2, false];   // tous les clients
    diag_log "[WRECK EVENT] BFM broadcast -> -2 (all clients)";
} else {
    if !(isNil "ALF_fnc_doBfmO") then { [_title,_msg] call ALF_fnc_doBfmO; }
    else { titleText [format ["%1\n%2", _title, _msg], "PLAIN DOWN", 3]; systemChat _title; systemChat _msg; };
};

// AUTO-DESPAWN à T+20 min (épave + caisse)
[
    _despawnDelaySec, _wreck, _crate, _gVarWreck, _gVarCrate
] spawn {
    params ["_delay","_w","_c","_gvW","_gvC"];
    uiSleep _delay;

    // Si un nouveau spawn a eu lieu entre-temps, on ne supprime que nos propres objets (références directes)
    if (!isNull _c) then { deleteVehicle _c; };
    if (!isNull _w) then { deleteVehicle _w; };

    // Nettoyage des vars si elles pointent encore sur ces objets
    if ((missionNamespace getVariable [_gvW, objNull]) isEqualTo _w) then {
        missionNamespace setVariable [_gvW, objNull, true];
    };
    if ((missionNamespace getVariable [_gvC, objNull]) isEqualTo _c) then {
        missionNamespace setVariable [_gvC, objNull, true];
    };

    diag_log "[WRECK EVENT] Auto-despawn (20 min) completed.";
};

diag_log "[WRECK EVENT] ---- END wreckSpawn ----";
objNull
