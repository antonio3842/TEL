/*
    File: fn_busjobFinishServiceParked.sqf
    Server — fin de service apres rangement au depot.
*/
params [
    ["_unit", objNull, [objNull]]
];

if (isNull _unit || {!isPlayer _unit}) exitWith {};

private _uid = getPlayerUID _unit;
missionNamespace setVariable [format ["MRP_BusJobCar_%1", _uid], nil];
[] remoteExecCall ["ALF_fnc_busjob_clientAfterEnd", _unit];
