/*
	File: fn_distrib_initAllMachines.sqf
	Au démarrage serveur — charge le stock BDD sur chaque distributeur de la mission.
*/
[] spawn {
	sleep 5;

	private _machines = (allMissionObjects "All") select { [_x] call ALF_Server_fnc_distrib_isMachine };

	{
		[_x, true] call ALF_Server_fnc_distrib_stockLoad;
	} forEach _machines;

	diag_log format ["[DISTRIB] %1 machine(s) synchronisée(s) avec distributeur_alimentaire.", count _machines];
};
