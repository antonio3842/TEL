/*
	File: fn_distribRangerVehicle.sqf
	Serveur — ranger le véhicule distributeur près du PNJ.
*/
params [
	["_unit", objNull, [objNull]],
	["_pnj", objNull, [objNull]]
];

if (isNull _unit || {!isPlayer _unit}) exitWith {};
if (isNull _pnj) exitWith {
	["Distributeur", "Erreur : PNJ introuvable.", "danger"] remoteExec ["ALF_fnc_doMsg", _unit];
};

if ((_unit distance _pnj) > 8) exitWith {
	["Distributeur", "Vous êtes trop loin du PNJ pour ranger le véhicule.", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

private _uid = getPlayerUID _unit;
private _veh = missionNamespace getVariable [format ["MRP_DistribJobCar_%1", _uid], objNull];

if (isNull _veh) exitWith {
	["Distributeur", "Aucun véhicule distributeur à ranger.", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

if (!alive _veh) exitWith {
	["Distributeur", "Véhicule en épave : utilisez « Fin de service » sans ranger.", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

private _rayon = 50;
if ((_veh distance _pnj) > _rayon) exitWith {
	["Distributeur", format ["Votre véhicule est trop loin (max %1 m).", _rayon], "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

{
	detach _x;
	deleteVehicle _x;
} forEach attachedObjects _veh;

if (!isNull _veh) then {
	deleteVehicle _veh;
};

missionNamespace setVariable [format ["MRP_DistribJobCar_%1", _uid], nil];
[] remoteExecCall ["ALF_fnc_distrib_clientAfterRanger", _unit];

["Distributeur", "Véhicule rangé. Vous pouvez terminer votre service.", "success"] remoteExec ["ALF_fnc_doMsg", _unit];
