// MRPV2_fnc_Petrole_Baril_Crea_Boutons_Inter = {
private _MRPV2_Interface_Base = uiNamespace getVariable ["MRPV2_Interface_Diverse",controlnull];

// Bouton pour déplacer le baril vide du coté gauche au milieu
private _ctrlButton = _MRPV2_Interface_Base ctrlCreate ["MRP_Bouton",-1];

uinamespace setVariable ["MRPV2_Petrole_Baril_Bouton_Tas_Gauche",_ctrlButton];
private _longueur_Bouton = count MRPV2_Petrole_Liste_Baril_Vide_Interface * (0.012 * safeZoneW);

_ctrlButton ctrlSetPosition [safeZoneX,safezoneY + 0.7 * safezoneh,(0.1 * safeZoneW) + _longueur_Bouton,0.3 * safezoneh];
_ctrlButton ctrlCommit 0;

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_ctrl"];
	if (MRPV2_Petrole_Baril_Au_Milieu isNotequalto []) exitwith 
	{
		[MRPV2_Petrole_Liste_Baril_Vide_Interface] call MRPV2_fnc_Petrole_Baril_Anim_Tremblement;
	};

	// Verif si le joueur peut transporter un baril plein
	player removemagazine "ALF_Barile_P_E";

	if !(player canAdd "ALF_Barile_P_F") exitwith 
	{
		[MRPV2_Petrole_Liste_Baril_Vide_Interface] call MRPV2_fnc_Petrole_Baril_Anim_Tremblement;
		["PETROLE", "Vous ne pouvez pas transporter plus de baril remplis.", "warning"] spawn ALF_fnc_doMsg;
		player addMagazine "ALF_Barile_P_E";
	};

	player addMagazine "ALF_Barile_P_E";

	player setvariable ["MRPV2_Petrole_Baril","Baril en mouvement"];

	private _liste_Ctrl_Baril = MRPV2_Petrole_Liste_Baril_Vide_Interface # 0;
	private _ctrlGrp_Baril = _liste_Ctrl_Baril # 0;
	private _ctrl_Baril = _liste_Ctrl_Baril # 1;

	private _pos_GrpCtrl_Baril = ctrlPosition _ctrlGrp_Baril;
	_ctrlGrp_Baril ctrlSetPosition [safeZonew * 0.35,safezoneh * 0.4,(_pos_GrpCtrl_Baril # 2) + 0.4,(_pos_GrpCtrl_Baril # 3) + 0.7];
	_ctrlGrp_Baril ctrlCommit 1;

	(_liste_Ctrl_Baril # 1) ctrlsetscale 2.3;
	(_liste_Ctrl_Baril # 1) ctrlCommit 1;

	MRPV2_Petrole_Baril_Au_Milieu pushback [_ctrlGrp_Baril,_ctrl_Baril];
	MRPV2_Petrole_Liste_Baril_Vide_Interface deleteat 0;	

	[MRPV2_Petrole_Liste_Baril_Vide_Interface] call MRPV2_fnc_Petrole_Baril_Anim_Tremblement;

	[] spawn 
	{
		sleep 1;

		// on fait la transition baril vide a baril pour pompe par un fade
		private _MRPV2_Interface_Base = uiNamespace getVariable ["MRPV2_Interface_Diverse",controlnull];
		private _liste_Ctrl_Baril = MRPV2_Petrole_Baril_Au_Milieu # 0;
		private _ctrlGrp_Baril = _liste_Ctrl_Baril # 0;
		private _ctrl_Baril = _liste_Ctrl_Baril # 1;

		private _ctrl_Baril_Temp = _MRPV2_Interface_Base ctrlCreate ["Rscpicture",-1,_ctrlGrp_Baril];
	 	_ctrl_Baril_Temp ctrlcommit 0;
		_ctrl_Baril_Temp ctrlSetText "MRPV2_Farm_Petrole\Data\Baril_Vide.paa";

		private _pos_Temp = ctrlposition _ctrl_Baril;
		private _scale_Temp = ctrlscale _ctrl_Baril;
		_ctrl_Baril_Temp ctrlSetPosition _pos_Temp;
		_ctrl_Baril_Temp ctrlSetScale _scale_Temp;
		_ctrl_Baril_Temp ctrlCommit 0;				
		
		_ctrl_Baril_Temp ctrlsetfade 1;
		_ctrl_Baril_Temp ctrlcommit 0.8;
		_ctrl_Baril ctrlSetText "MRPV2_Farm_Petrole\Data\Baril_Pour_Pompe.paa";

		sleep 0.8;

		ctrlDelete _ctrl_Baril_Temp;
		player setvariable ["MRPV2_Petrole_Baril","Baril en pos"];		
	};
}];

// Bouton pour déplacer le baril au milieu vers la droite
private _ctrl_Bouton_Milieu = _MRPV2_Interface_Base ctrlCreate ["MRP_Bouton",-1];
uinamespace setVariable ["MRPV2_Petrole_Baril_Ctrl_Bouton_Milieu",_ctrl_Bouton_Milieu];
_ctrl_Bouton_Milieu ctrlSetPosition [safeZoneX + 0.35 * safeZoneW,safezoneY + 0.5 * safezoneh,0.25 * safeZoneW,0.5 * safezoneh];
_ctrl_Bouton_Milieu ctrlCommit 0;

_ctrl_Bouton_Milieu ctrlAddEventHandler ["ButtonClick",
{
	private _etat_Pompe = player getvariable ["MRPV2_Petrole_Pompe",""];
	private _etat_Baril = player getvariable ["MRPV2_Petrole_Baril",""];
	if (_etat_Pompe isNotequalto "Pompe relevé" OR {_etat_Baril isNotequalto "Baril plein"}) exitwith 
	{
		if (MRPV2_Petrole_Baril_Au_Milieu isequalto []) exitwith {};

		playSoundUI ["MRPV2_Petrole_Baril_Vide",0.4,0.8 + random 0.4];
	};

	player setvariable ["MRPV2_Petrole_Baril","En mouvement"];

	[1,2] spawn ALF_fnc_addXP; 

	private _liste_Ctrl_Baril = MRPV2_Petrole_Baril_Au_Milieu # 0;
	private _ctrlGrp_Baril = _liste_Ctrl_Baril # 0;
	private _pos_X = 2.2 - (count MRPV2_Petrole_Liste_Baril_Plein_Interface) * 0.05;

	_ctrlGrp_Baril ctrlSetPosition [_pos_X,1.3,safeZonew * 0.2,safeZoneh * 0.4];
	_ctrlGrp_Baril ctrlCommit 1;		

	{
		_x ctrlsetscale 1;
		_x ctrlCommit 1;
	} foreach _liste_Ctrl_Baril;
	
	[_liste_Ctrl_Baril,_ctrlGrp_Baril] spawn 
	{params ["_liste_Ctrl_Baril","_ctrlGrp_Baril"];
		sleep 1;

		player setvariable ["MRPV2_Petrole_Baril",""];
		player setvariable ["MRPV2_Petrole_Pompe",""];

		MRPV2_Petrole_Baril_Au_Milieu deleteat 0;
		_liste_Ctrl_Baril pushback (ctrlPosition _ctrlGrp_Baril);
		MRPV2_Petrole_Liste_Baril_Plein_Interface pushback _liste_Ctrl_Baril;	
	};
}];

// Bouton pour les barils a droite
private _ctrl_Bouton_Droite = _MRPV2_Interface_Base ctrlCreate ["MRP_Bouton",-1];
uinamespace setVariable ["MRPV2_Petrole_Baril_Ctrl_Bouton_Droite",_ctrl_Bouton_Droite];
_ctrl_Bouton_Droite ctrlSetPosition [safeZoneX + 0.75 * safeZoneW,safezoneY + 0.7 * safezoneh,0.25 * safeZoneW,0.3 * safezoneh];
_ctrl_Bouton_Droite ctrlCommit 0;

_ctrl_Bouton_Droite ctrlAddEventHandler ["ButtonClick",
{	
	if (MRPV2_Petrole_Liste_Baril_Plein_Interface isequalto []) exitwith {};

	[MRPV2_Petrole_Liste_Baril_Plein_Interface] call MRPV2_fnc_Petrole_Baril_Anim_Tremblement;

	playSoundUI ["MRPV2_Petrole_Baril_Plein",0.4,0.8 + random 0.4];
}];

// Bouton pour déplacer la pompe et remplir la pompe
private _ctrlButton = _MRPV2_Interface_Base ctrlCreate ["MRP_Bouton",-1];
uinamespace setVariable ["MRPV2_Petrole_Baril_Bouton_Pompe",_ctrlButton];
_ctrlButton ctrlSetPosition [safeZoneX + 0.73 * safeZoneW,safezoneY + 0.1 * safezoneh,0.19 * safeZoneW,0.3 * safezoneh];
_ctrlButton ctrlCommit 0;

_ctrlButton ctrlAddEventHandler ["MouseButtonUp",
{params ["_control"];
	private _etat_Pompe = player getvariable ["MRPV2_Petrole_Pompe",""];
	private _etat_Baril = player getvariable ["MRPV2_Petrole_Baril",""];
	if (_etat_Pompe in ["En mouvement"]) exitwith {};

	private _ctrlGroup_Pompe = uinamespace getVariable ["_ctrlGroup_Pompe",controlnull];

	// Positionnement pompe dans baril
	if (_etat_Baril isequalto "Baril en pos" AND {_etat_Pompe isequalto ""}) then
	{
		player setvariable ["MRPV2_Petrole_Pompe","Pompe en mouvement"];
		[_ctrlGroup_Pompe,TRUE] spawn MRPV2_fnc_Petrole_Baril_Anim_Pompe;
	};

	// Positionnement pompe hors baril
	if (_etat_Baril isequalto "Baril plein" AND {_etat_Pompe isequalto "Pompe abaissé"}) then
	{
		player setvariable ["MRPV2_Petrole_Pompe","Pompe en mouvement"];
		[_ctrlGroup_Pompe,FALSE] spawn MRPV2_fnc_Petrole_Baril_Anim_Pompe;
	};

	// Remplissage baril
	if (_etat_Baril isequalto "Baril en pos" AND {_etat_Pompe isequalto "Pompe abaissé"}) then
	{
		player setvariable ["MRPV2_Petrole_Pompe","En pompage"];
		[_control] call MRPV2_fnc_Petrole_Baril_Remplissage;
	};
}];
// };