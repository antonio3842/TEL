/*
	File: fn_taxiRangerVehicle.sqf
	Server — ranger le taxi près du PNJ (vérif distance).
*/
params [
	["_unit", objNull, [objNull]],
	["_pnj", objNull, [objNull]],
	["_orphanCleanup", false, [false]]
];

if (isNull _unit || {!isPlayer _unit}) exitWith {};
if (isNull _pnj) exitWith {
	["TAXI", "Erreur: PNJ introuvable.", "danger"] remoteExec ["ALF_fnc_doMsg", _unit];
};

if ((_unit distance _pnj) > 8) exitWith {
	["TAXI", "Vous êtes trop loin du PNJ pour ranger le véhicule.", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

private _uid = getPlayerUID _unit;
private _veh = missionNamespace getVariable [format ["MRP_TaxiJobCar_%1", _uid], objNull];

if (isNull _veh) exitWith {
	["TAXI", "Aucun véhicule de taxi à ranger.", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

if (!alive _veh) exitWith {
	if (_orphanCleanup) then {
		/* Hors service : on libère uniquement le slot serveur ; l'épave reste sur la carte (pas de suppression auto à la reco). */
		missionNamespace setVariable [format ["MRP_TaxiJobCar_%1", _uid], nil];
		[] remoteExecCall ["ALF_fnc_taxi_clientAfterOrphanRanger", _unit];
		["TAXI", "Enregistrement du taxi effacé. Vous pouvez reprendre un service (l'épave peut rester sur place).", "info"] remoteExec ["ALF_fnc_doMsg", _unit];
	} else {
		["TAXI", "Véhicule en épave : utilisez « Fin de service » sans ranger.", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
	};
};

private _rayon = 50;
if ((_veh distance _pnj) > _rayon) exitWith {
	["TAXI", format ["Votre taxi est trop loin (max %1 m).", _rayon], "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

{
	detach _x;
	deleteVehicle _x;
} forEach attachedObjects _veh;

if (!isNull _veh) then {
	deleteVehicle _veh;
};

missionNamespace setVariable [format ["MRP_TaxiJobCar_%1", _uid], nil];

if (_orphanCleanup) then {
	[] remoteExecCall ["ALF_fnc_taxi_clientAfterOrphanRanger", _unit];
	["TAXI", "Véhicule rangé au point de rendu. Vous pouvez reprendre votre service.", "success"] remoteExec ["ALF_fnc_doMsg", _unit];
} else {
	[] remoteExecCall ["ALF_fnc_taxi_clientAfterRanger", _unit];
	["TAXI", "Véhicule rangé. Terminez votre service.", "success"] remoteExec ["ALF_fnc_doMsg", _unit];
};
