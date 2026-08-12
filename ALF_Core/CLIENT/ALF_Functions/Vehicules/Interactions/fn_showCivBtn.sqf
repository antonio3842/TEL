//ALF_fnc_showCivBtn = { 
private _veh = _this # 0; 

life_vInact_curTarget = _veh;
disableSerialization; 
private _affichage = findDisplay 30200; 
private _liste_Boutons = [];

for "_i" from 0 to 6 do
{
	private _bouton = _affichage displayCtrl (30401 + _i);
	_liste_Boutons pushBack _bouton;
};

if (alive _veh AND {count crew _veh isEqualTo 0} AND {canMove _veh}) then  
{
	private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
	_bouton ctrlSetText "Bump"; 
	_bouton buttonSetAction "life_vInact_curTarget setPos [getPos life_vInact_curTarget # 0, getPos life_vInact_curTarget # 1, (getPos life_vInact_curTarget # 2)+0.5]; closeDialog 0;"; 
	_bouton ctrlshow true; 
};

if ((_veh in life_vehicles OR (currentWeapon player == primaryWeapon player AND primaryWeapon player != "")) AND speed _veh < 5 AND player distance _veh < 8) then  
{ 
	private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
	_bouton ctrlSetText "Ejecter du vehicule"; 	
	_bouton buttonSetAction "[life_vInact_curTarget] spawn ALF_fnc_pulloutAction; closeDialog 0;";
	_bouton ctrlshow true; 
}; 

if ("ALF_Lockpick" in (magazines player)) then  
{
	private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;	
	_bouton ctrlSetText "Crocheter"; 
	_bouton buttonSetAction "[life_vInact_curTarget] spawn ALF_fnc_lockpick; closeDialog 0;";
	_bouton ctrlShow true; 
}; 

private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
_bouton ctrlShow true;
_bouton ctrlSetText "SOS Dépanneur";
_bouton buttonSetAction "
    [life_vInact_curTarget] spawn MRPV2_fnc_SOS_Depanneur_Activer;
    closeDialog 0;
";
_bouton ctrlShow true;

private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
_bouton ctrlSetText "STOP Dépanneur";
_bouton buttonSetAction "
    [] call MRPV2_fnc_SOS_Depanneur_Arreter;
    closeDialog 0;
";
_bouton ctrlShow true;

if (b_Depanneur OR b_18) then  
{ 
	private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
	_bouton ctrlShow true;	
	private _locked = locked _veh; 
	if(_locked isEqualTo 2) then  
	{ 
		_bouton ctrlSetText "[DEP] Ouvrir véhicule"; 
		_bouton buttonSetAction "[life_vInact_curTarget,0] remoteExecCall [""ALF_fnc_lockVehicle"",life_vInact_curTarget]; closeDialog 0;"; 
	} else  
	{ 
		_bouton ctrlSetText "[DEP] Fermer véhicule"; 
		_bouton buttonSetAction "[life_vInact_curTarget,2] remoteExecCall [""ALF_fnc_lockVehicle"",life_vInact_curTarget]; closeDialog 0;"; 
	};

	if (b_Depanneur) then {
		private _atelier_Peinture_Proche = nearestObjects [player, ["Land_ALF_AtelierPeinture"], 20] # 0; 
		if !(isnil {_atelier_Peinture_Proche}) then	 
		{
			private _dans_Bat = life_vInact_curTarget inArea [getposatl _atelier_Peinture_Proche, 4, 7, getdir _atelier_Peinture_Proche, false]; 
			if (_dans_Bat) then  
			{ 
				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
				_bouton ctrlShow true;
				_bouton ctrlSetText "Faire la peinture"; 
				_bouton buttonSetAction  
				" 
					closeDialog 0; 
					ALF_Peinture_NearestVehicle = life_vInact_curTarget; 
					[0] call ALF_fnc_menuPeinture;  
				"; 
			}; 
		};
	};

	private _atelier_Peinture_Proche = nearestObjects [player, ["Land_Airport_01_hangar_F"], 20] # 0; 
	if !(isnil {_atelier_Peinture_Proche}) then	 
	{
		private _dans_Bat = life_vInact_curTarget inArea [getposatl _atelier_Peinture_Proche, 4, 7, getdir _atelier_Peinture_Proche, false]; 
		if (_dans_Bat) then  
		{ 
			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "Faire la peinture"; 
			_bouton buttonSetAction  
			" 
				closeDialog 0; 
				ALF_Peinture_NearestVehicle = life_vInact_curTarget; 
				[0] call ALF_fnc_menuPeinture;  
			"; 
		}; 
	}; 
}; 
//};
