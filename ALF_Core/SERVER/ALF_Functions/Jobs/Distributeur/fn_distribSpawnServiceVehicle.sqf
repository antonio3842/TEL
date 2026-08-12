/*
	File: fn_distribSpawnServiceVehicle.sqf
	Serveur — sortie véhicule distributeur.
*/
params [
	["_unit", objNull, [objNull]]
];

if (isNull _unit || {!isPlayer _unit}) exitWith {};

private _uid = getPlayerUID _unit;
private _varName = format ["MRP_DistribJobCar_%1", _uid];
private _existing = missionNamespace getVariable [_varName, objNull];

if (!isNull _existing) then {
	if (!alive _existing) then {
		deleteVehicle _existing;
		missionNamespace setVariable [_varName, nil];
		_existing = objNull;
	} else {
		if (_existing getVariable ["MRP_DistribServiceVehicle", false]) exitWith {
			["Distributeur", "Vous avez déjà un véhicule de service distributeur.", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
		};
		deleteVehicle _existing;
		missionNamespace setVariable [_varName, nil];
		_existing = objNull;
	};
};

private _posSpawn = [5698.27, 4164.12, 0];
private _nearCar = _posSpawn nearEntities [["Car", "Ship", "Air"], 10];

if (count _nearCar > 0) exitWith {
	[
		"Distributeur",
		"Impossible de sortir le véhicule : quelque chose bloque le point de sortie. Déplacez-le puis réessayez.",
		"warning"
	] remoteExec ["ALF_fnc_doMsg", _unit];
};

private _className = "V_ALF_Berlingo2019_MRPV2";
private _plaque = [] call MRPV2_fnc_Vehicule_Creation_Plaque;

private _vehicle = _className createVehicle [0, 0, 1000];
if (isNull _vehicle) exitWith {
	["Distributeur", "Impossible de créer le véhicule de service.", "danger"] remoteExec ["ALF_fnc_doMsg", _unit];
	diag_log "[DISTRIB] Échec createVehicle V_ALF_Berlingo2019_MRPV2";
};

_vehicle allowDamage false;
_vehicle setPosATL _posSpawn;
_vehicle setVectorUp (surfaceNormal _posSpawn);
_vehicle setDir 0;
_vehicle allowDamage true;

_vehicle lock 2;
_vehicle setVariable ["vehicle_info_owners", ["", _uid], true];
_vehicle setVariable ["dbInfo", [_uid, _plaque], true];
_vehicle setVariable ["MRP_DistribServiceVehicle", true, true];
_vehicle setVariable ["MRP_DistribNoPersistence", true, true];
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

[_vehicle] remoteExecCall ["ALF_fnc_addVehicle2Chain", _unit];
[getPlayerUID _unit, _vehicle, 1] call ALF_Server_fnc_keyManagement;

missionNamespace setVariable [_varName, _vehicle];
[_vehicle] remoteExecCall ["ALF_fnc_distrib_clientAfterSpawn", _unit];

["Distributeur", "Votre véhicule distributeur est prêt.", "success"] remoteExec ["ALF_fnc_doMsg", _unit];
diag_log format ["[DISTRIB] Véhicule service spawn pour %1 (%2).", name _unit, _uid];
