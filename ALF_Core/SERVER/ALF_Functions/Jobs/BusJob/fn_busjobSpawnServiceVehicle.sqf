/*
    File: fn_busjobSpawnServiceVehicle.sqf
    Server — sortie bus de service (pret, hors BDD, disparait au reboot).
*/
params [
    ["_unit", objNull, [objNull]],
    ["_spawnPos", [9126.66, 2857.93, 0], [[]]],
    ["_spawnDir", 333, [0]],
    ["_reuseAtDepot", false, [false]],
    ["_depotPos", [], [[]]]
];

if (isNull _unit || {!isPlayer _unit}) exitWith {};

private _uid = getPlayerUID _unit;
private _varName = format ["MRP_BusJobCar_%1", _uid];
private _existing = missionNamespace getVariable [_varName, objNull];

private _depotRayon = 100;
private _checkPos = if (count _depotPos >= 2) then { _depotPos } else { _spawnPos };

// Epave enregistree : suppression puis nouveau spawn autorise
if (!isNull _existing && {!alive _existing}) then {
    {
        detach _x;
        deleteVehicle _x;
    } forEach attachedObjects _existing;
    deleteVehicle _existing;
    missionNamespace setVariable [_varName, nil];
    _existing = objNull;
    ["Bus", "Epave retiree. Sortie d'un nouveau bus...", "info"] remoteExec ["ALF_fnc_doMsg", _unit];
};

// Bus vivant : reutiliser au depot, sinon avertissement et fin (exitWith au niveau fonction)
if (!isNull _existing && {alive _existing}) exitWith {
    private _nearDepot = (_existing distance _checkPos) <= _depotRayon;
    private _nearSpawn = (_existing distance _spawnPos) <= _depotRayon;
    private _nearJoueur = (_existing distance _unit) <= _depotRayon;

    if (_reuseAtDepot || _nearDepot || _nearSpawn || _nearJoueur) exitWith {
        if !(_existing getVariable ["MRP_BusJob_EpaveEH", false]) then {
            _existing setVariable ["MRP_BusJob_EpaveEH", true, true];
            _existing addEventHandler ["Killed", {
                params ["_veh"];
                if (!isNull _veh && {_veh getVariable ["MRP_BusJobServiceVehicle", false]} && {!(_veh getVariable ["ALF_EpaveCasse", false])}) then {
                    [_veh, 0] spawn ALF_Server_fnc_createEpaveVehicle;
                };
            }];
        };
        [_existing] remoteExecCall ["ALF_fnc_busjob_clientAfterSpawn", _unit];
        ["Bus", "Nouvelle ligne demarree avec votre bus.", "success"] remoteExec ["ALF_fnc_doMsg", _unit];
    };

    [
        "Bus",
        format ["Vous avez deja un bus (ramenez-le a moins de %1 m du depot).", _depotRayon],
        "warning"
    ] remoteExec ["ALF_fnc_doMsg", _unit];
    diag_log format ["[MRP_BUSJOB] Spawn refuse — bus vivant loin du depot pour %1", _uid];
};

private _nearCar = (_spawnPos nearEntities [["Car", "Truck", "Bus"], 12]) select {
    !(_x getVariable ["MRP_BusJobServiceVehicle", false])
};

if (count _nearCar > 0) exitWith {
    [
        "Bus",
        "Impossible de sortir le bus : le point de sortie est bloque. Deplacez le vehicule puis reessayez.",
        "warning"
    ] remoteExec ["ALF_fnc_doMsg", _unit];
    diag_log format ["[MRP_BUSJOB] Spawn bloque — point occupe pour %1", _uid];
};

private _className = "V_ALF_Bus";
private _plaque = [] call ALF_Server_fnc_busjob_generatePlaque;

private _vehicle = createVehicle [_className, [0, 0, 1000], [], 0, "NONE"];

if (isNull _vehicle) exitWith {
    [
        "Bus",
        "Erreur spawn : classe V_ALF_Bus introuvable (addon alf_truck manquant sur le serveur).",
        "danger"
    ] remoteExec ["ALF_fnc_doMsg", _unit];
    diag_log "[MRP_BUSJOB] ERREUR createVehicle V_ALF_Bus — classe absente";
};

_vehicle allowDamage false;
_vehicle setPosATL _spawnPos;
_vehicle setVectorUp (surfaceNormal _spawnPos);
_vehicle setDir _spawnDir;
_vehicle allowDamage true;

_vehicle lock 2;
_vehicle setVariable ["vehicle_info_owners", ["", _uid], true];
_vehicle setVariable ["dbInfo", [_uid, _plaque], true];
_vehicle setVariable ["MRP_BusJobServiceVehicle", true, true];
_vehicle setVariable ["MRP_BusJobNoPersistence", true, true];
_vehicle setVariable ["Flashed", false, true];
_vehicle disableTIEquipment true;
_vehicle enableDynamicSimulation true;

clearItemCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearWeaponCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;

_vehicle setVariable ["plate", _plaque, true];
_vehicle setPlateNumber _plaque;
[_vehicle, _plaque] remoteExec ["setPlateNumber", _unit];

private _plaqueChars = _plaque splitString "";
_vehicle setObjectTextureGlobal [1, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa", _plaqueChars param [0, ""]]];
_vehicle setObjectTextureGlobal [2, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa", _plaqueChars param [1, ""]]];
_vehicle setObjectTextureGlobal [3, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa", _plaqueChars param [3, ""]]];
_vehicle setObjectTextureGlobal [4, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa", _plaqueChars param [4, ""]]];
_vehicle setObjectTextureGlobal [5, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa", _plaqueChars param [5, ""]]];
_vehicle setObjectTextureGlobal [6, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa", _plaqueChars param [7, ""]]];
_vehicle setObjectTextureGlobal [7, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa", _plaqueChars param [8, ""]]];
_vehicle setObjectTextureGlobal [0, "\alf_truck\alf_bus\data\textures\buscacem.paa"];

if !(_vehicle getVariable ["MRP_BusJob_EpaveEH", false]) then {
    _vehicle setVariable ["MRP_BusJob_EpaveEH", true, true];
    _vehicle addEventHandler ["Killed", {
        params ["_veh"];
        if (!isNull _veh && {_veh getVariable ["MRP_BusJobServiceVehicle", false]} && {!(_veh getVariable ["ALF_EpaveCasse", false])}) then {
            [_veh, 0] spawn ALF_Server_fnc_createEpaveVehicle;
        };
    }];
};

[_vehicle] remoteExecCall ["ALF_fnc_addVehicle2Chain", _unit];
[getPlayerUID _unit, _vehicle, 1] call ALF_Server_fnc_keyManagement;

missionNamespace setVariable [_varName, _vehicle];
[_vehicle] remoteExecCall ["ALF_fnc_busjob_clientAfterSpawn", _unit];

["Bus", "Votre bus de service est pret.", "success"] remoteExec ["ALF_fnc_doMsg", _unit];
diag_log format ["[MRP_BUSJOB] Bus spawn OK pour %1 — %2", _uid, _plaque];
