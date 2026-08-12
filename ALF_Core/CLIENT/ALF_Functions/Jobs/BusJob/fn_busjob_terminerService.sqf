/*
    Fichier : fn_busjob_terminerService.sqf
    Desc    : Fin de service chauffeur — nettoyage client (bus deja supprime par le serveur)
*/

if (isNil "MRP_BusJob_ServicePris") then { MRP_BusJob_ServicePris = false; };
if (!MRP_BusJob_ServicePris && {!MRP_BusJob_EnService}) exitWith {
    ["Bus", "Vous n'etes pas en service.", "danger"] spawn ALF_fnc_doMsg;
};

[] call ALF_fnc_busjob_stopAutoArret;

if (MRP_BusJob_MarkerNom isNotEqualTo "") then {
    deleteMarker MRP_BusJob_MarkerNom;
    MRP_BusJob_MarkerNom = "";
};
hintSilent "";

private _bus = MRP_BusJob_Bus;
if (isNull _bus) then { _bus = player getVariable ["MRP_BusJob_Bus", objNull]; };

if (!isNull _bus) then {
    if (vehicle player isEqualTo _bus) then {
        player action ["eject", _bus];
        uiSleep 1.2;
    };
    life_vehicles = life_vehicles - [_bus];
    deleteVehicle _bus;
};

private _arretsEffectues = if (isNil "MRP_BusJob_ArretsSession") then { MRP_BusJob_ArretActuel } else { MRP_BusJob_ArretsSession };
private _totalGagne      = if (isNil "MRP_BusJob_SalaireTotal") then { 0 } else { MRP_BusJob_SalaireTotal };

MRP_BusJob_ServicePris  = false;
MRP_BusJob_EnService    = false;
MRP_BusJob_LigneActive  = "";
MRP_BusJob_ArretActuel  = 0;
MRP_BusJob_ArretAffiche = 0;
MRP_BusJob_ArretTotal   = 0;
MRP_BusJob_Bus          = objNull;
MRP_BusJob_Parked       = false;
MRP_BusJob_SalaireTotal = 0;
MRP_BusJob_ArretsSession = 0;
MRP_BusJob_Arrets       = [];
MRP_BusJob_Pending      = nil;

player setVariable ["MRP_BusJob_ServicePris", false,   true];
player setVariable ["MRP_BusJob_EnService",   false,   true];
player setVariable ["MRP_BusJob_LigneActive", "",      true];
player setVariable ["MRP_BusJob_Bus",         objNull, true];
player setVariable ["MRP_BusJob_Parked",     false,   true];

["Bus", format [
    "Service termine — %1 arrets — %2 EUR gagnes.",
    _arretsEffectues, _totalGagne
], "info"] spawn ALF_fnc_doMsg;

diag_log format ["[MRP_BUSJOB] %1 a termine son service (%2 arrets — %3 EUR)", name player, _arretsEffectues, _totalGagne];
