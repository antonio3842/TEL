/*
	File: fn_taxiEndServiceVehicle.sqf
	Server — fin de service taxi (suppression véhicule prêt, sans persistance BDD).
*/
params [
	["_vehicle", objNull, [objNull]],
	["_unit", objNull, [objNull]]
];

if (isNull _unit || {!isPlayer _unit}) exitWith {};
if (isNull _vehicle) exitWith {
	["TAXI", "Aucun véhicule à restituer.", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

private _uid = getPlayerUID _unit;
private _registered = missionNamespace getVariable [format ["MRP_TaxiJobCar_%1", _uid], objNull];
if (!(_vehicle isEqualTo _registered)) exitWith {
	["TAXI", "Ce n'est pas votre véhicule de taxi attribué.", "danger"] remoteExec ["ALF_fnc_doMsg", _unit];
};

{
	detach _x;
	deleteVehicle _x;
} forEach attachedObjects _vehicle;

if (!isNull _vehicle) then {
	deleteVehicle _vehicle;
};

missionNamespace setVariable [format ["MRP_TaxiJobCar_%1", _uid], nil];
[] remoteExecCall ["ALF_fnc_taxi_clientAfterEnd", _unit];

["TAXI", "Service taxi terminé.", "info"] remoteExec ["ALF_fnc_doMsg", _unit];
