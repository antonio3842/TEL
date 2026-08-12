/*
    Fichier : fn_busjob_endService.sqf
    Desc    : Fin de service — bus range obligatoire si encore en vie (comme taxi)
*/

if (!alive player) exitWith {};

if (isNil "MRP_BusJob_ServicePris") then { MRP_BusJob_ServicePris = false; };
if (isNil "MRP_BusJob_EnService") then { MRP_BusJob_EnService = false; };
if (isNil "MRP_BusJob_Parked") then { MRP_BusJob_Parked = false; };

if (!MRP_BusJob_ServicePris) exitWith {
    ["Bus", "Vous n'etes pas en service.", "warning"] spawn ALF_fnc_doMsg;
};

private _parked = MRP_BusJob_Parked || {player getVariable ["MRP_BusJob_Parked", false]};
private _bus = MRP_BusJob_Bus;
if (isNull _bus) then { _bus = player getVariable ["MRP_BusJob_Bus", objNull]; };

if (_parked) exitWith {
    [player] remoteExecCall ["ALF_Server_fnc_busjobFinishServiceParked", 2];
};

if (!isNull _bus && {alive _bus}) exitWith {
    ["Bus", "Rangez votre bus au depot avant de terminer votre service.", "warning"] spawn ALF_fnc_doMsg;
};

if (!isNull _bus && {!alive _bus}) then {
    ["Bus", "Bus en epave : suppression au depot.", "info"] spawn ALF_fnc_doMsg;
};

if (!isNull _bus) then {
    [_bus, player] remoteExecCall ["ALF_Server_fnc_busjobEndServiceVehicle", 2];
} else {
    [player] remoteExecCall ["ALF_Server_fnc_busjobFinishServiceParked", 2];
};
