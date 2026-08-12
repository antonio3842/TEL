/*
	File: fn_taxiSpawnServiceVehicle.sqf
	Server — sortie véhicule taxi (prêt, sans ligne SQL : disparaît au reboot).
*/
params [
	["_unit", objNull, [objNull]]
];

if (isNull _unit || {!isPlayer _unit}) exitWith {};

private _uid = getPlayerUID _unit;
private _existing = missionNamespace getVariable [format ["MRP_TaxiJobCar_%1", _uid], objNull];
if (!isNull _existing && {!alive _existing}) then {
	deleteVehicle _existing;
	missionNamespace setVariable [format ["MRP_TaxiJobCar_%1", _uid], nil];
	_existing = objNull;
};
if (!isNull _existing && {alive _existing}) exitWith {
	["TAXI", "Vous avez déjà un véhicule de service taxi.", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

/* Prêt taxi : hors BDD = aucune persistance au reboot (plus d’INSERT/UPDATE vehicles). */
private _posSpawn = [1360.708, 7345.915, 0];
private _nearCar = _posSpawn nearEntities [["Car", "Ship", "Air"], 10];
if (count _nearCar > 0) exitWith {
	[
		"TAXI",
		"Impossible de sortir le taxi : quelque chose bloque le point de sortie (véhicule ou engin à cet endroit). Déplacez-le puis réessayez.",
		"warning"
	] remoteExec ["ALF_fnc_doMsg", _unit];
};

private _className = "V_ALF_508_Taxi_MRPV2";
/* Prêt sans INSERT BDD : plaque visuelle uniquement (pas de collision SQL avec vehicles). */
private _plaque = [] call MRPV2_fnc_Vehicule_Creation_Plaque;

private _vehicle = _className createVehicle [0, 0, 1000];
_vehicle allowDamage false;
_vehicle setPosATL _posSpawn;
_vehicle setVectorUp (surfaceNormal _posSpawn);
_vehicle setDir 295.002;
_vehicle allowDamage true;

_vehicle lock 2;
/* Même format que getJobCar / spawn civil : #0 = tag garage (vide), #1 = Steam UID */
_vehicle setVariable ["vehicle_info_owners", ["", _uid], true];
_vehicle setVariable ["dbInfo", [_uid, _plaque], true];
_vehicle setVariable ["MRP_TaxiServiceVehicle", true, true];
_vehicle setVariable ["MRP_TaxiNoPersistence", true, true];
_vehicle setVariable ["Flashed", false, true];
_vehicle disableTIEquipment true;
_vehicle enableDynamicSimulation true;

clearItemCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearWeaponCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;

_vehicle setPlateNumber _plaque;

private _plaqueChars = _plaque splitString "";
_vehicle setObjectTextureGlobal [1, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa", _plaqueChars param [0, ""]]];
_vehicle setObjectTextureGlobal [2, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa", _plaqueChars param [1, ""]]];
_vehicle setObjectTextureGlobal [3, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa", _plaqueChars param [3, ""]]];
_vehicle setObjectTextureGlobal [4, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa", _plaqueChars param [4, ""]]];
_vehicle setObjectTextureGlobal [5, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa", _plaqueChars param [5, ""]]];
_vehicle setObjectTextureGlobal [6, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa", _plaqueChars param [7, ""]]];
_vehicle setObjectTextureGlobal [7, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa", _plaqueChars param [8, ""]]];

if !(_vehicle getVariable ["MRP_TaxiEpaveEH", false]) then {
	_vehicle setVariable ["MRP_TaxiEpaveEH", true, true];
	_vehicle addEventHandler ["Killed", {
		params ["_veh"];
		if (!isNull _veh && {_veh getVariable ["MRP_TaxiServiceVehicle", false]} && {!(_veh getVariable ["ALF_EpaveCasse", false])}) then {
			[_veh, 0] spawn ALF_Server_fnc_createEpaveVehicle;
		};
	}];
};

[_vehicle] remoteExecCall ["ALF_fnc_addVehicle2Chain", _unit];
[getPlayerUID _unit, _vehicle, 1] call ALF_Server_fnc_keyManagement;

missionNamespace setVariable [format ["MRP_TaxiJobCar_%1", _uid], _vehicle];
[_vehicle] remoteExecCall ["ALF_fnc_taxi_clientAfterSpawn", _unit];

["TAXI", "Votre véhicule taxi est prêt.", "success"] remoteExec ["ALF_fnc_doMsg", _unit];
