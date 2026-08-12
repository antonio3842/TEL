/*
	File: fn_distribFinishServiceParked.sqf
	Serveur — fin de service après rangement du véhicule.
*/
params [
	["_unit", objNull, [objNull]]
];

if (isNull _unit || {!isPlayer _unit}) exitWith {};

private _uid = getPlayerUID _unit;
missionNamespace setVariable [format ["MRP_DistribJobCar_%1", _uid], nil];
[] remoteExecCall ["ALF_fnc_distrib_clientAfterEnd", _unit];

["Distributeur", "Service terminé. À bientôt !", "info"] remoteExec ["ALF_fnc_doMsg", _unit];
