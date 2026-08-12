/*
    Fichier : fn_busjob_prendreService.sqf
    Desc    : Prise de service au depot (PNJ) — ouvre le menu des lignes
*/
if (!alive player) exitWith {};

if (isNil "license_busjob" || {!license_busjob}) exitWith {
    ["Bus", "Il vous faut la licence Chauffeur de Bus.\nRendez-vous a France Travail.", "warning"] spawn ALF_fnc_doMsg;
};

if (isNil "MRP_BusJob_ServicePris") then { MRP_BusJob_ServicePris = false; };
if (isNil "MRP_BusJob_EnService") then { MRP_BusJob_EnService = false; };

if (MRP_BusJob_EnService) exitWith {
    ["Bus", "Terminez votre ligne en cours avant.", "warning"] spawn ALF_fnc_doMsg;
};

if (!MRP_BusJob_ServicePris) then {
    MRP_BusJob_ServicePris = true;
    MRP_BusJob_SalaireTotal = 0;
    MRP_BusJob_ArretsSession = 0;
    player setVariable ["MRP_BusJob_ServicePris", true, true];
};

[] spawn {
    uiSleep 0.1;
    [] spawn ALF_fnc_busjob_openMenu;
    private _t0 = time;
    waitUntil {
        uiSleep 0.05;
        !isNull (findDisplay 9901) || {time > _t0 + 3}
    };
    if (!isNull (findDisplay 9901)) then {
        ["Bus", "Choisissez une ligne.", "info"] spawn ALF_fnc_doMsg;
    };
};
