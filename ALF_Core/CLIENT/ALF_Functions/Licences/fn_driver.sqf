/*
params [
	["_mode",-1,[0]],
	["_license",false,[false]]
];

if (_mode isEqualTo -1) exitWith {};

switch (_mode) do {
	case 0: {
		[1,license_driver] remoteExecCall ["ALF_fnc_driver",remoteExecutedOwner];
	};

	case 1: {
		licence_driverTarget = _license;
	};

	case 2: {
		license_driver = true;
		life_permis = 12;
		[14] call SOCK_fnc_updatePartial;
		[1] call SOCK_fnc_updatePartial;
	};
		
	case 3: {
		license_driver = false;
		life_permis = 0;
		[14] call SOCK_fnc_updatePartial;
		[1] call SOCK_fnc_updatePartial;
	};
	
	case 4: {
		if (life_permis >= 12) exitWith {["ERREUR", "Cette personne a deja 12 points.", "danger", false] remoteExec ["ALF_fnc_doMsg",remoteExecutedOwner];};
		life_permis = life_permis + 1;
		["INFO", "Vous avez donné 1 point cette personne.", "success", false] remoteExec ["ALF_fnc_doMsg",remoteExecutedOwner];
		[14] call SOCK_fnc_updatePartial;
		[1] call SOCK_fnc_updatePartial;
	};
};

*/



params [
	["_mode",-1,[0]],
	["_license",false]
];

if (_mode isEqualTo -1) exitWith {};

switch (_mode) do {
	case 0: {
		[1,license_driver] remoteExecCall ["ALF_fnc_driver",remoteExecutedOwner];
	};

	case 1: {
		licence_driverTarget = _license;
	};

	case 2: {
		license_driver = true;
		life_permis = 12;
		[14] call SOCK_fnc_updatePartial;
		[1] call SOCK_fnc_updatePartial;
	};
		
	case 3: {
		license_driver = false;
		life_permis = 0;
		[14] call SOCK_fnc_updatePartial;
		[1] call SOCK_fnc_updatePartial;
	};
	
	case 4: {
		// _license peut être un nombre (nombre de points à ajouter) ou false (par défaut, ajoute 1 point)
		private _nbPoints = if (typeName _license == "SCALAR") then { _license } else { 1 };
		if (life_permis >= 12) exitWith {["ERREUR", "Cette personne a deja 12 points.", "danger", false] remoteExec ["ALF_fnc_doMsg",remoteExecutedOwner];};
		private _nouveauTotal = life_permis + _nbPoints;
		if (_nouveauTotal > 12) then {
			_nbPoints = 12 - life_permis;
			_nouveauTotal = 12;
		};
		life_permis = _nouveauTotal;
		if (life_permis >= 12) then {
			["INFO", format["Vous avez ajouté %1 point(s) à cette personne. Elle a maintenant 12 points (maximum).", _nbPoints], "success", false] remoteExec ["ALF_fnc_doMsg",remoteExecutedOwner];
		} else {
			["INFO", format["Vous avez ajouté %1 point(s) à cette personne. Elle a maintenant %2 point(s) sur son permis.", _nbPoints, life_permis], "success", false] remoteExec ["ALF_fnc_doMsg",remoteExecutedOwner];
		};
		["Permis", format["Vous avez reçu %1 point(s). Vous avez maintenant %2 point(s) sur votre permis.", _nbPoints, life_permis], "success", false] spawn ALF_fnc_doMsg;
		[14] call SOCK_fnc_updatePartial;
		[1] call SOCK_fnc_updatePartial;
	};
};
