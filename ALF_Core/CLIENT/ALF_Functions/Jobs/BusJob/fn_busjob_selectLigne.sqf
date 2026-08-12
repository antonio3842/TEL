/*
    Fichier : fn_busjob_selectLigne.sqf
    Auteur  : MRP
    Desc    : Selectionner une ligne et demander le bus de pret au serveur
*/

params ["_idLigne"];

[] call ALF_fnc_busjob_ensureConfig;

if (isNil "MRP_BusJob_ServicePris" || {!MRP_BusJob_ServicePris}) exitWith {
    ["Bus", "Prenez d'abord votre service au depot de bus.", "warning"] spawn ALF_fnc_doMsg;
    closeDialog 2;
};

if (_idLigne isEqualTo "busjob_wip") exitWith {
    ["Bus", "Cette ligne est en cours de developpement. Revenez bientot !", "warning"] spawn ALF_fnc_doMsg;
    closeDialog 2;
};

if (player getVariable ["MRP_BusJob_EnService", false]) then {
    MRP_BusJob_EnService = true;
};
if (MRP_BusJob_EnService) exitWith {
    ["Bus", "Terminez votre ligne en cours (ou fin de service au PNJ) avant d'en choisir une autre.", "danger"] spawn ALF_fnc_doMsg;
    private _dlg = findDisplay 9901;
    if (!isNull _dlg) then { _dlg closeDisplay 1; };
};

if (!license_busjob) exitWith {
    ["Bus", "Il vous faut la licence Chauffeur de Bus.\nRendez-vous a France Travail pour l'obtenir.", "danger"] spawn ALF_fnc_doMsg;
    closeDialog 2;
};

private _ligneData = [];
{ if ((_x select 0) isEqualTo _idLigne) exitWith { _ligneData = _x; }; } forEach MRP_BusJob_Config;

if (count _ligneData isEqualTo 0) exitWith {
    ["Bus", "Ligne introuvable. Contactez un administrateur.", "danger"] spawn ALF_fnc_doMsg;
    closeDialog 2;
};

private _nom = _ligneData select 1;

private _arrets = [];
private _coordsGPS = [_idLigne] call ALF_fnc_busjob_getArretsCoords;

{
    private _num = _forEachIndex + 1;
    _arrets pushBack [_x, format ["%1_%2", _idLigne, _num], _num];
} forEach _coordsGPS;

if (count _arrets isEqualTo 0) exitWith {
    ["Bus", "Cette ligne est en cours de developpement. Revenez bientot !", "warning"] spawn ALF_fnc_doMsg;
    closeDialog 2;
};

private _dlgMenu = findDisplay 9901;
if (!isNull _dlgMenu) then { _dlgMenu closeDisplay 1; };

MRP_BusJob_Pending = [_idLigne, _nom, _arrets];
player setVariable ["MRP_BusJob_Pending", MRP_BusJob_Pending, false];

private _spawnPos = (MRP_BusJob_SpawnGPS select 0) select 0;
private _spawnDir = (MRP_BusJob_SpawnGPS select 0) select 1;
{
    private _pos = _x select 0;
    if (count (nearestObjects [_pos, ["Car", "Truck", "Bus"], 8]) isEqualTo 0) exitWith {
        _spawnPos = _pos;
        _spawnDir = _x select 1;
    };
} forEach MRP_BusJob_SpawnGPS;

private _pnjDepot = missionNamespace getVariable ["MRP_BusJob_DepotPNJ", objNull];
if (isNull _pnjDepot) then { _pnjDepot = life_pInact_curObject; };
if (isNull _pnjDepot) then {
    {
        private _nom = toLowerANSI str _x;
        if ("MRPV2_PNJ_Emploi_BusJob" in _nom) exitWith { _pnjDepot = _x; };
    } forEach (allMissionObjects "Man");
};

private _busDepot = MRP_BusJob_Bus;
if (isNull _busDepot) then { _busDepot = player getVariable ["MRP_BusJob_Bus", objNull]; };

// Epave ou ref invalide : on force un nouveau spawn
if (!isNull _busDepot && {!alive _busDepot}) then {
    MRP_BusJob_Bus = objNull;
    player setVariable ["MRP_BusJob_Bus", objNull, true];
    _busDepot = objNull;
};

private _reuseBus = (!isNull _busDepot) && {alive _busDepot};
private _depotPos = if (!isNull _pnjDepot) then { getPosATL _pnjDepot } else { _spawnPos };

diag_log format ["[MRP_BUSJOB] selectLigne %1 — reuse:%2 — pending:%3", _idLigne, _reuseBus, MRP_BusJob_Pending];

[player, _spawnPos, _spawnDir, _reuseBus, _depotPos] remoteExecCall ["ALF_Server_fnc_busjobSpawnServiceVehicle", 2];
