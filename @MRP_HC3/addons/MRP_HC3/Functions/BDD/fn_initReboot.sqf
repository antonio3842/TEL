/*
	File: fn_initReboot.sqf
	Author: ALF Team
	HC3: Systeme tempete/reboot
*/
if ("dev" in tolower str servername) exitwith {};

MRPV2_Tempete_Demarree = FALSE;
MRPV2_Derniere_Heure = -1;

private _horaires =
[
	[3,0],
	[14,0],
	[19,0]
];

waitUntil
{
	uiSleep 3*60;
	private _heure = systemTime # 3;
	private _minute = systemTime # 4;
	private _doit_Declencher = FALSE;

	{
		private _heure_Finale = _x # 0;
		private _minute_Finale = _x # 1;
		private _minute_Debut = _minute_Finale - 25;
		private _heure_Debut = _heure_Finale;

		if (_minute_Debut < 0) then
		{
			_minute_Debut = _minute_Debut + 60;
			_heure_Debut = _heure_Debut - 1;
			if (_heure_Debut < 0) then {_heure_Debut = 23;};
		};

		if (_heure isEqualTo _heure_Debut AND {_minute >= _minute_Debut AND {_minute < (_minute_Debut + 5)}}) then
		{
			_doit_Declencher = TRUE;
		};
	} forEach _horaires;

	if (!MRPV2_Tempete_Demarree AND _doit_Declencher) then
	{
		if (MRPV2_Derniere_Heure isNotEqualTo _heure) then
		{
			MRPV2_Tempete_Demarree = TRUE;
			MRPV2_Derniere_Heure = _heure;

			// Phase 0: Debut tempete - overcast (via serveur)
			[0] remoteExecCall ["ALF_Server_fnc_rebootWeather", 2];
			uiSleep (15*60);

			// Alerte orange
			[toupper "TEMPETE TROPICALE","Une tempete tropicale s'apprete a frapper la Martinique. L'ile vient d'etre placee en alerte orange. Le gouvernement demande a tous les citoyens d'arreter toute activite longue et de mettre a l'abri tout objet susceptible d'etre emporte."] remoteExec ["ALF_fnc_doBfmO",playableUnits];

			// Phase 1: Pluie legere (via serveur)
			[1] remoteExecCall ["ALF_Server_fnc_rebootWeather", 2];
			uiSleep (5*60);

			// Alerte rouge
			["CYCLONE TROPICAL","La tempete tropicale a ete re-categorisee en cyclone tropical de niveau 3. L'ile vient d'etre placee en alerte rouge. Le gouvernement demande a tous les citoyens de se mettre d'urgence a l'abri et de garer immediatement leur vehicule sur le bas cote de la route."] remoteExec ["ALF_fnc_doBfmO",playableUnits];

			// Phase 2: Cyclone conditions + server lock (via serveur)
			[2] remoteExecCall ["ALF_Server_fnc_rebootWeather", 2];

			// Sync vent sur tous les clients
			[30,30,true] remoteExec ['setWind',0];
			uiSleep 15;

			// Phase 4: Fermer les magasins (via serveur)
			[4] remoteExecCall ["ALF_Server_fnc_rebootWeather", 2];

			// Thunderbolt (via serveur)
			[15,5+random 60,30+random 60,TRUE,TRUE,TRUE] remoteExecCall ["TON_fnc_thunderbolt", 2];

			// Update BDD
			["UPDATE reboot SET start='0' WHERE id='1'",1] call ALF_Server_fnc_asyncCall;

			uiSleep (3 * 60);

			// Demander au serveur de sync les joueurs
			[] remoteExecCall ["ALF_Server_fnc_rebootSync", 2];

			["UPDATE reboot SET start='1' WHERE id='1'",1] call ALF_Server_fnc_asyncCall;

			MRPV2_Tempete_Demarree = FALSE;
		};
	};

	// Surveillance brume (via serveur)
	[3] remoteExecCall ["ALF_Server_fnc_rebootWeather", 2];

	false
};
