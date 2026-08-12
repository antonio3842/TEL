/*
    Fichier : fn_busjob_openMenu.sqf
    Desc    : Menu choix de ligne — via PNJ depot (service pris, pas de ligne en cours)
*/
if (!alive player) exitWith {};

if (!canSuspend) exitWith {
    [] spawn ALF_fnc_busjob_openMenu;
};

if (isNil "MRP_BusJob_ServicePris") then { MRP_BusJob_ServicePris = false; };
if (isNil "MRP_BusJob_EnService") then { MRP_BusJob_EnService = false; };

if (!MRP_BusJob_ServicePris) exitWith {
    ["Bus", "Prenez d'abord votre service aupres du gerant du depot de bus.", "warning"] spawn ALF_fnc_doMsg;
};

if (MRP_BusJob_EnService) exitWith {
    ["Bus", "Terminez d'abord votre ligne en cours.", "warning"] spawn ALF_fnc_doMsg;
};

private _pnjDepot = missionNamespace getVariable ["MRP_BusJob_DepotPNJ", objNull];
if (isNull _pnjDepot) then { _pnjDepot = life_pInact_curObject; };
if (!isNull _pnjDepot) then {
    missionNamespace setVariable ["MRP_BusJob_DepotPNJ", _pnjDepot];
};

// Fermer le menu interaction MRPV2 avant d'ouvrir le dialog bus
private _mrpDisp = uiNamespace getVariable ["MRPV2_Interface_Diverse", controlNull];
if (!isNull _mrpDisp) then {
    closeDialog 0;
    private _tLimite = time + 2;
    waitUntil {
        uiSleep 0.05;
        isNull (uiNamespace getVariable ["MRPV2_Interface_Diverse", controlNull]) || {time > _tLimite}
    };
    uiSleep 0.1;
};

private _oldMenu = findDisplay 9901;
if (!isNull _oldMenu) then {
    _oldMenu closeDisplay 1;
    uiSleep 0.1;
};

if (!createDialog "ALF_BusJob_Menu") then {
    ["Bus", "Menu bus introuvable : recompilez la mission MRP_Martinique (alfbusjob.hpp).", "danger"] spawn ALF_fnc_doMsg;
};
