/*
	File : fn_voitureMort.sqf
	Author: ALF NiiRoZz
*/
params [
	["_mode",-1,[0]]
];

if (_mode isEqualTo -1) exitWith {};

switch (_mode) do {
	//On met le mec dans la voiture
	case 0: {
		private _target = param [1, objNull, [objNull]];
		if (isNull _target) exitWith {};

		private _nearestVehicle = (nearestObjects [player, ["Car", "Ship", "Submarine", "Air"], 10]) select 0;
		if (isNil "_nearestVehicle") exitWith {
			["INFO", "Aucun véhicule proche.", "danger"] spawn ALF_fnc_doMsg;
		};

		[_nearestVehicle] remoteExecCall ["ALF_fnc_moveIn", _target];

		if (!(typeOf _nearestVehicle isEqualTo "ALF_Brancard_P") && {_target getVariable ["requestMedic", false]}) then {
			["INFO", "Vous déplacez maintenant le blessé. Ne déplacez pas la victime à plus de 100 mètres.", "warning"] spawn ALF_fnc_doMsg;
		};
	};

	//On enleve le mec de la voiture
	case 1: {
		private _veh = param [1, objNull, [objNull]];
		if (isNull _veh) exitWith {};

		{
			if (_x getVariable ["ReviveMedic",false] && {!(isNull _x)}) then {
				[_x] remoteExecCall ["ALF_fnc_pullOutVeh",_x];
			};
		} forEach (crew _veh);
	};
};