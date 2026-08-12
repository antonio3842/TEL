/*
    File: fn_busjobRangerVehicle.sqf
    Server — ranger le bus de pret pres du PNJ depot.
*/
params [
    ["_unit", objNull, [objNull]],
    ["_pnj", objNull, [objNull]]
];

if (isNull _unit || {!isPlayer _unit}) exitWith {};
if (isNull _pnj) exitWith {
    ["Bus", "Erreur : PNJ introuvable.", "danger"] remoteExec ["ALF_fnc_doMsg", _unit];
};

if ((_unit distance _pnj) > 8) exitWith {
    ["Bus", "Vous êtes trop loin du gérant pour ranger le bus (8 m max).", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

private _uid = getPlayerUID _unit;
private _veh = missionNamespace getVariable [format ["MRP_BusJobCar_%1", _uid], objNull];

if (isNull _veh) exitWith {
    ["Bus", "Aucun bus de service à ranger.", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

if (!alive _veh) exitWith {
    ["Bus", "Bus en épave : utilisez « Fin de service » sans ranger.", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

private _rayon = 50;
if ((_veh distance _pnj) > _rayon) exitWith {
    ["Bus", format ["Votre bus est trop loin du depot (max %1 m).", _rayon], "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

{
    detach _x;
    deleteVehicle _x;
} forEach attachedObjects _veh;

if (!isNull _veh) then {
    deleteVehicle _veh;
};

missionNamespace setVariable [format ["MRP_BusJobCar_%1", _uid], nil];
[] remoteExecCall ["ALF_fnc_busjob_clientAfterRanger", _unit];
["Bus", "Bus rangé au dépôt. Vous pouvez terminer votre service.", "success"] remoteExec ["ALF_fnc_doMsg", _unit];
