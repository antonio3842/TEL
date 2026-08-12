if ("dev" in tolower str servername) exitwith {};

private _magasins = nearestObjects [[8000,8000,0], ["Land_ALF_Store"], 20000];

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
			
			(5*60) setOvercast 1;
			uiSleep (15*60);
			
			[toupper "TEMPÊTE TROPICALE","Une tempête tropicale s'apprête à frapper la Martinique. L'île vient d'être placée en alerte orange. Le gouvernement demande à tous les citoyens d'arrêter toute activité longue et de mettre à l'abri tout objet susceptible d'être emporté."] remoteExec ["ALF_fnc_doBfmO",playableUnits];
			(5*60) setRain 0.5;
			uiSleep (5*60);
			
			["CYCLONE TROPICAL","La tempête tropicale a été re-catégorisée en cyclone tropical de niveau 3. L'île vient d'être placée en alerte rouge. Le gouvernement demande à tous les citoyens de se mettre d'urgence à l'abri et de garer immédiatement leur véhicule sur le bas côté de la route."] remoteExec ["ALF_fnc_doBfmO",playableUnits];
			"MRPV2_Serv" serverCommand "#lock";

			setWind [30,30,true];
			[30,30,true] remoteExec ['setWind',0];
			(1*60) setRain 1;
			(1*60) setGusts 1;
			(1*60) setLightnings 1;
			(1*60) setFog 0.3;
			uiSleep 15;

			{_x animateSource ["Grille_source",0];} forEach _magasins;
			[15,5+random 60,30+random 60,TRUE,TRUE,TRUE] call TON_fnc_thunderbolt;
			["UPDATE reboot SET start='0' WHERE id='1'",1] call ALF_Server_fnc_asyncCall;

			uiSleep (3 * 60);

			if (isserver) then 
			{
				[] remoteExec ['SOCK_fnc_syncData',allplayers];
				[] spawn ALF_Server_fnc_vehicleAutoSync;
			};
			
			["UPDATE reboot SET start='1' WHERE id='1'",1] call ALF_Server_fnc_asyncCall;			
			
			MRPV2_Tempete_Demarree = FALSE;
		};
	};

	comment "Surveillance brume mis a 0 si trop présent";
	if (fog > 0.1)  then {60 setfog 0};

	false
};