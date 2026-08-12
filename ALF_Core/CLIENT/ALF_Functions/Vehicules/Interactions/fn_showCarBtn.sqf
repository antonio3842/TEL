ALF_fnc_showCarBtn = {
private _veh = param [0,objnull];
life_vInact_curTarget = _veh;

disableSerialization;

_display = findDisplay 30200;
_R1 = _display displayCtrl 30411;
_R2 = _display displayCtrl 30412;
_R3 = _display displayCtrl 30413;
_R4 = _display displayCtrl 30414;
_R5 = _display displayCtrl 30415;
_R6 = _display displayCtrl 30416;

private _liste_Boutons = [_R1,_R2,_R3,_R4,_R5,_R6];
{_x ctrlShow false;} foreach _liste_Boutons;

if ("ALF_Boiteaoutils" in (magazines player)) then 
{
	private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
	_bouton ctrlSetText "Rep. moteur";
	_bouton ctrlShow true;
	_bouton buttonSetAction "[1,life_vInact_curTarget] spawn ALF_fnc_repairCar; closeDialog 0;";
};

if ("ALF_KitMecatechnic" in (magazines player)) then 
{
	private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
	_bouton ctrlSetText "Rep. technique";
	_bouton ctrlShow true;
	_bouton buttonSetAction "[2,life_vInact_curTarget] spawn ALF_fnc_repairCar; closeDialog 0;";
};

if ("ALF_Roue" in (magazines player)) then 
{
	private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
	_bouton ctrlSetText "Changer roues";
	_bouton ctrlShow true;
	_bouton buttonSetAction "[0,life_vInact_curTarget] spawn ALF_fnc_repairCar; closeDialog 0;";
};

if ((speed life_vInact_curTarget) isEqualTo 0 AND {life_gendarme_service OR {b_Depanneur OR {life_penit_service OR {b_18}}}}) then
{
	if ("_MRP_" in typeof life_vInact_curTarget) then 
	{
		if ((life_vInact_curTarget animationSourcePhase "sabot_source") isequalto 1) then 
		{
			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlShow true;
			_bouton ctrlSetText "Enlever le sabot";
			_bouton buttonSetAction "[life_vInact_curTarget,'Enlever'] call ALF_fnc_immobiliserVehicle; closeDialog 0;";		
		} else
		{
			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "Mettre un sabot";
			_bouton buttonSetAction "[life_vInact_curTarget,'Mettre'] call ALF_fnc_immobiliserVehicle; closeDialog 0;";
		};
	} else 
	{
		if ((life_vInact_curTarget animationSourcePhase "sabot") isequalto 0) then 
		{
			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlShow true;
			_bouton ctrlSetText "Enlever le sabot";
			_bouton buttonSetAction "[life_vInact_curTarget,'Enlever'] call ALF_fnc_immobiliserVehicle; closeDialog 0;";		
		} else
		{
			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "Mettre un sabot";
			_bouton buttonSetAction "[life_vInact_curTarget,'Mettre'] call ALF_fnc_immobiliserVehicle; closeDialog 0;";
		};
	};
};

if (b_6) then
{
	// Si le joueur a une valise -> bouton pour stocker
	if ((speed life_vInact_curTarget) isEqualTo 0 AND {!(isNull (player getVariable ["wallet_obj", objNull]))}) then
	{
		private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
		_bouton ctrlShow true;
		_bouton ctrlSetText "Stock. Valise";
		_bouton buttonSetAction "[life_vInact_curTarget,0] call ALF_fnc_bag_stock; closeDialog 0;";
	};

	// Si le joueur n'a pas de valise et véhicule en a -> bouton pour prendre
	if ((speed life_vInact_curTarget) isEqualTo 0 AND {isNull (player getVariable ["wallet_obj", objNull])} AND {(life_vInact_curTarget getVariable ["valise_stock", 0]) > 0}) then
	{
		private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
		_bouton ctrlShow true;
		_bouton ctrlSetText "Prendre. Valise";
		_bouton buttonSetAction "[life_vInact_curTarget,0] call ALF_fnc_bag_unstock; closeDialog 0;";
	};
};

if ("ALF_Tracker_i" in (magazines player)) then 
{
	private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
	_bouton ctrlEnable true;
	_bouton ctrlSetText "Poser un tracker";
	_bouton buttonSetAction "[""ALF_Tracker_i"",life_vInact_curTarget] spawn ALF_fnc_poserTracker; closeDialog 0;";
};
};