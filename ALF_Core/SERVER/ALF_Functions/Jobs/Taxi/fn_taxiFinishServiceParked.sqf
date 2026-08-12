/*
	File: fn_taxiFinishServiceParked.sqf
	Server — fin de service après rangement (plus de véhicule au monde).
*/
params [
	["_unit", objNull, [objNull]]
];

if (isNull _unit || {!isPlayer _unit}) exitWith {};

private _uid = getPlayerUID _unit;
missionNamespace setVariable [format ["MRP_TaxiJobCar_%1", _uid], nil];
[] remoteExecCall ["ALF_fnc_taxi_clientAfterEnd", _unit];

["TAXI", "Service taxi terminé.", "info"] remoteExec ["ALF_fnc_doMsg", _unit];
