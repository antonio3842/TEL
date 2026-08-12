/*
    Fichier : fn_busjob_clientAfterSpawn.sqf
    Client — bus de pret sorti par le serveur, demarrage de la ligne en attente.
*/
params [["_vehicle", objNull, [objNull]]];

if (isNull _vehicle) exitWith {
    ["Bus", "Erreur : bus de service introuvable.", "danger"] spawn ALF_fnc_doMsg;
    MRP_BusJob_Pending = nil;
    player setVariable ["MRP_BusJob_Pending", nil, false];
};

private _pending = MRP_BusJob_Pending;
if (isNil "_pending" || {_pending isEqualTo []}) then {
    _pending = player getVariable ["MRP_BusJob_Pending", []];
};
if (_pending isEqualTo []) exitWith {
    ["Bus", "Erreur : ligne en attente introuvable. Rechoisissez une ligne au depot.", "danger"] spawn ALF_fnc_doMsg;
    diag_log "[MRP_BUSJOB] clientAfterSpawn — Pending vide";
};

private _idLigne = _pending select 0;
private _nom     = _pending select 1;
private _arrets  = _pending select 2;
MRP_BusJob_Pending = nil;
player setVariable ["MRP_BusJob_Pending", nil, false];

if (!(_vehicle in life_vehicles)) then {
    life_vehicles pushBack _vehicle;
};

MRP_BusJob_EnService    = true;
MRP_BusJob_LigneActive  = _idLigne;
MRP_BusJob_ArretActuel  = 0;
MRP_BusJob_ArretAffiche = 1;
MRP_BusJob_ArretTotal   = count _arrets;
MRP_BusJob_Bus          = _vehicle;
MRP_BusJob_Parked       = false;
MRP_BusJob_Arrets       = _arrets;

player setVariable ["MRP_BusJob_EnService",   true,     true];
player setVariable ["MRP_BusJob_LigneActive", _idLigne, true];
player setVariable ["MRP_BusJob_Bus",         _vehicle, true];
player setVariable ["MRP_BusJob_Parked",     false,    true];

[] call ALF_fnc_busjob_stopAutoArret;
MRP_BusJob_ValidationLock = false;
MRP_BusJob_AutoHandle = [_vehicle] spawn ALF_fnc_busjob_autoArretLoop;

[] spawn ALF_fnc_busjob_gpsUpdate;

["Bus", format [
    "%1 — %2 arrets. Suivez le GPS.",
    _nom, count _arrets
], "info"] spawn ALF_fnc_doMsg;

diag_log format ["[MRP_BUSJOB] %1 demarre ligne '%2' (%3 arrets)", name player, _idLigne, count _arrets];
