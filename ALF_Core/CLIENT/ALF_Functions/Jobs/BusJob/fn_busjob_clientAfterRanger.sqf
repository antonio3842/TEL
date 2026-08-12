/*
    Fichier : fn_busjob_clientAfterRanger.sqf
    Client — apres rangement serveur au depot (bus supprime).
*/
private _bus = MRP_BusJob_Bus;
if (isNull _bus) then { _bus = player getVariable ["MRP_BusJob_Bus", objNull]; };

if (!isNull _bus) then {
    life_vehicles = life_vehicles - [_bus];
};

if (MRP_BusJob_MarkerNom isNotEqualTo "") then {
    deleteMarker MRP_BusJob_MarkerNom;
    MRP_BusJob_MarkerNom = "";
};
hintSilent "";

[] call ALF_fnc_busjob_stopAutoArret;

MRP_BusJob_EnService    = false;
MRP_BusJob_LigneActive  = "";
MRP_BusJob_ArretActuel  = 0;
MRP_BusJob_ArretTotal   = 0;
MRP_BusJob_Bus          = objNull;
MRP_BusJob_Parked       = true;
MRP_BusJob_Arrets       = [];
MRP_BusJob_Pending      = nil;

player setVariable ["MRP_BusJob_EnService",   false,   true];
player setVariable ["MRP_BusJob_LigneActive", "",      true];
player setVariable ["MRP_BusJob_Bus",         objNull, true];
player setVariable ["MRP_BusJob_Parked",     true,    true];

["Bus", "Bus range. Choix des lignes au PNJ pour repartir.", "info"] spawn ALF_fnc_doMsg;
