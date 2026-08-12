/*
    File: fn_busjobEndServiceVehicle.sqf
    Server — fin de service (epave / restitution bus de pret).
*/
params [
    ["_vehicle", objNull, [objNull]],
    ["_unit", objNull, [objNull]]
];

if (isNull _unit || {!isPlayer _unit}) exitWith {};
if (isNull _vehicle) exitWith {
    [_unit] call ALF_Server_fnc_busjobFinishServiceParked;
};

private _uid = getPlayerUID _unit;
private _registered = missionNamespace getVariable [format ["MRP_BusJobCar_%1", _uid], objNull];

if (!isNull _registered && {!(_vehicle isEqualTo _registered)}) exitWith {
    ["Bus", "Ce n'est pas votre bus de service attribué.", "danger"] remoteExec ["ALF_fnc_doMsg", _unit];
};

{
    detach _x;
    deleteVehicle _x;
} forEach attachedObjects _vehicle;

if (!isNull _vehicle) then {
    deleteVehicle _vehicle;
};

missionNamespace setVariable [format ["MRP_BusJobCar_%1", _uid], nil];
[] remoteExecCall ["ALF_fnc_busjob_clientAfterEnd", _unit];
