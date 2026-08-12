/*
    Fichier : fn_initClientBusJob.sqf
    Auteur  : MRP
    Desc    : Init client BusJob — variables + config
    Appelé  : fn_initClient.sqf (après les autres inits de jobs)

    Mission : le PNJ gérant doit avoir la variable éditeur MRPV2_PNJ_Emploi_BusJob
              (remplacer l'ancienne variable job_bus si présente).
    Menu lignes : PNJ depot uniquement (prise de service / choix des lignes).
*/
if (!hasInterface) exitWith {};

if (isNil "license_busjob") then { license_busjob = false; };

// ── Variables globales ─────────────────────────────────────────────────────
MRP_BusJob_ServicePris      = false;
MRP_BusJob_EnService        = false;
MRP_BusJob_LigneActive      = "";
MRP_BusJob_ArretActuel      = 0;
MRP_BusJob_ArretAffiche     = 1;
MRP_BusJob_ArretTotal       = 0;
MRP_BusJob_Bus              = objNull;
MRP_BusJob_Parked           = false;
MRP_BusJob_MarkerNom        = "";
MRP_BusJob_SalaireTotal     = 0;
MRP_BusJob_ArretsSession    = 0;
MRP_BusJob_Arrets           = [];
MRP_BusJob_ValidationLock   = false;
MRP_BusJob_AutoHandle       = scriptNull;
MRP_BusJob_Pending          = nil;
MRP_BusJob_DepotRayon       = 100;
MRP_BusJob_ArretDist        = 25;
MRP_BusJob_ArretDistTol     = 3;

// ── Véhicule + spawn bus (GPS) ─────────────────────────────────────────────
MRP_BusJob_VehClass = "V_ALF_Bus";
// [position ATL, cap (axe Z / setDir)]
MRP_BusJob_SpawnGPS = [
    [[9126.66, 2857.93, 0], 333],
    [[9116.79, 2853.07, 0], 333]
];

// Config lignes + coordonnees arrets
[] call ALF_fnc_busjob_ensureConfig;

waitUntil { !isNull player };

player setVariable ["MRP_BusJob_ServicePris", false, true];
player setVariable ["MRP_BusJob_EnService", false, true];
player setVariable ["MRP_BusJob_LigneActive", "", true];
player setVariable ["MRP_BusJob_Bus", objNull, true];
player setVariable ["MRP_BusJob_Parked", false, true];
player setVariable ["MRP_BusJob_Pending", nil, false];

diag_log "[MRP_BUSJOB] Init client OK — menu via PNJ depot";
