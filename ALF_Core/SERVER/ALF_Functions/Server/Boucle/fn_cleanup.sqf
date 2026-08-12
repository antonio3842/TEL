// ALF_Server_fnc_cleanup = {
private _liste_Exeptions = ["ALF_RoadCone_F","ALF_Blue","ALF_Relique_1","ALF_Relique_2","ALF_Relique_3"];

waituntil 
{
	uiSleep 1440;
	["COMMUNE","LES SERVICES DE LA VOIRIE PASSERONT DANS 5 MINUTES.","warning"] remoteExec ["ALF_fnc_doMsg",playableUnits];
	uiSleep 240;
	["COMMUNE","LES SERVICES DE LA VOIRIE PASSERONT DANS 1 MINUTE.","warning"] remoteExec ["ALF_fnc_doMsg",playableUnits];
	uiSleep 30;
	["COMMUNE","LES SERVICES DE LA VOIRIE PASSERONT DANS 30 SECONDES.","warning"] remoteExec ["ALF_fnc_doMsg",playableUnits];
	uiSleep 15;

	{
		private _groundWeaponHolder = _x;
		private _joueur_Pas_Proche = (allplayers select {_x distance _groundWeaponHolder < 40}) isequalto [];

		if (_joueur_Pas_Proche) then 
		{
			if (_liste_Exeptions select {(_x in magazineCargo _groundWeaponHolder)} isEqualTo []) then {deleteVehicle _x;};
		};
	} forEach ("GroundWeaponHolder" allObjects 0);

	deleteVehicle allDeadMen;

	FALSE
};
// };[] spawn ALF_Server_fnc_cleanup;