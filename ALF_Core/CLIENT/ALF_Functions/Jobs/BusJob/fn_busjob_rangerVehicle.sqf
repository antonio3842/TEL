/*
    Fichier : fn_busjob_rangerVehicle.sqf
    Client — demande rangement du bus de pret au depot (comme taxi).
*/

if (!alive player) exitWith {};

if (isNil "MRP_BusJob_ServicePris") then { MRP_BusJob_ServicePris = false; };
if (isNil "MRP_BusJob_EnService") then { MRP_BusJob_EnService = false; };
if (isNil "MRP_BusJob_Parked") then { MRP_BusJob_Parked = false; };

if (!MRP_BusJob_ServicePris) exitWith {
    ["Bus", "Prenez votre service au depot.", "warning"] spawn ALF_fnc_doMsg;
};

if (MRP_BusJob_Parked || {player getVariable ["MRP_BusJob_Parked", false]}) exitWith {
    ["Bus", "Bus deja range.", "info"] spawn ALF_fnc_doMsg;
};

private _pnj = missionNamespace getVariable ["MRP_BusJob_DepotPNJ", objNull];
if (isNull _pnj) then { _pnj = life_pInact_curObject; };
if (isNull _pnj) then { _pnj = cursorObject; };

[player, _pnj] remoteExecCall ["ALF_Server_fnc_busjobRangerVehicle", 2];
