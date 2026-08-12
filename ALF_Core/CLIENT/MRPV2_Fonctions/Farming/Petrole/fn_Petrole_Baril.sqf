// MRPV2_fnc_Petrole_Baril = {
[] spawn 
{	// sleep 0.5;
	private _liste_Baril_Vide_Joueur = magazines player select {"ALF_Barile_P_E" in _x};
	if (_liste_Baril_Vide_Joueur isequalto []) exitwith 
	{
		["PETROLE", "Vous devez avoir des barils vide sur vous.", "warning"] spawn ALF_fnc_doMsg;
	};

	createDialog "MRPV2_Interface_Diverse";

	private _MRPV2_Interface_Base = uiNamespace getVariable ["MRPV2_Interface_Diverse",controlnull];

	// BASE
	private _ctrlGroup = _MRPV2_Interface_Base ctrlCreate ["RscControlsGroupNoScrollbars",-1];
	uinamespace setVariable ["_ctrlGroup",_ctrlGroup];

	_ctrlGroup ctrlSetPosition [safezoneX,safezoneY,safeZoneW,safeZoneH];
	_ctrlGroup ctrlSetBackgroundColor [0,0,0.5,0.9];
	_ctrlGroup ctrlenable false;
	_ctrlGroup ctrlCommit 0;

	_ctrlGroup ctrlAddEventHandler ["Destroy",
	{
		player setvariable ["MRPV2_Petrole_Pompe",nil];
		player setvariable ["MRPV2_Petrole_Baril",nil];

		MRPV2_Petrole_Liste_Baril_Vide_Interface = nil;
		MRPV2_Petrole_Liste_Baril_Plein_Interface = nil;
		MRPV2_Petrole_Baril_Au_Milieu = nil;
	}];

	MRPV2_Petrole_Liste_Baril_Vide_Interface = [];
	MRPV2_Petrole_Liste_Baril_Plein_Interface = [];
	MRPV2_Petrole_Baril_Au_Milieu = [];

	// Creation tas de baril vide a gauche
	{
		private _liste_Ctrl_Barils_Vide = [] call MRPV2_fnc_Petrole_Baril_Crea;
		
		private _grpctrl = _liste_Ctrl_Barils_Vide # 0;
		private _pos_GrpCtrl_Baril = ctrlPosition _grpctrl;

		private _pos_X = (0.03 * _foreachindex);
		_grpctrl ctrlSetPositionX ((_pos_GrpCtrl_Baril # 0) + _pos_X);
		_grpctrl ctrlSetPositionY ((_pos_GrpCtrl_Baril # 1) + random 0.05);
		_grpctrl ctrlCommit 0;

		// on met la pos des baril pour avoir la posinitiale pour le script de tremblement
		_liste_Ctrl_Barils_Vide pushback (ctrlPosition _grpctrl);

		MRPV2_Petrole_Liste_Baril_Vide_Interface pushback _liste_Ctrl_Barils_Vide;

		sleep 0.05;
	} foreach _liste_Baril_Vide_Joueur;

	reverse MRPV2_Petrole_Liste_Baril_Vide_Interface;

	[] call MRPV2_fnc_Petrole_Baril_Crea_Boutons_Inter;

	// Creation pompe
	private _ctrlGroup_Pompe = _MRPV2_Interface_Base ctrlCreate ["RscControlsGroupNoScrollbars",-1,_ctrlGroup];
	uinamespace setvariable ["_ctrlGroup_Pompe",_ctrlGroup_Pompe];
	_ctrlGroup_Pompe ctrlSetPosition [safeZonew * 0.7,safeZoneh * 0.1,safeZonew * 0.4,safeZoneh * 0.4];
	_ctrlGroup_Pompe ctrlsetbackgroundcolor [0.6,0.2,0.5,0.4];
	_ctrlGroup_Pompe ctrlCommit 0;

	// Piston Vertical
	private _ctrl_Piston_Vertical = _MRPV2_Interface_Base ctrlCreate ["rscpicture",-1,_ctrlGroup_Pompe];
	uinamespace setVariable ["MRPV2_Petrole_Baril_Ctrl_Piston_Vertical",_ctrl_Piston_Vertical];
	_ctrl_Piston_Vertical ctrlSetText "MRPV2_Farm_Petrole\Data\Pompe_Barre_Verticale.paa";
	_ctrl_Piston_Vertical ctrlSetPosition [safeZonew * 0.113,safeZoneh * 0.03,safeZonew * 0.032,safeZoneh * 0.14];
	_ctrl_Piston_Vertical ctrlSetTextColor [1,1,1,1];
	_ctrl_Piston_Vertical ctrlCommit 0;

	// Poignet pivot 
	private _ctrl_Poignet_Pivot = _MRPV2_Interface_Base ctrlCreate ["rscpicture",-1,_ctrlGroup_Pompe];
	uinamespace setVariable ["MRPV2_Petrole_Baril_Ctrl_Poignet_Pivot",_ctrl_Poignet_Pivot];
	_ctrl_Poignet_Pivot ctrlSetText "MRPV2_Farm_Petrole\Data\Pompe_Poignet_Pivot.paa";
	_ctrl_Poignet_Pivot ctrlSetPosition [safeZonew * -0.016,safeZoneh * -0.025,safeZonew * 0.2,safeZoneh * 0.25];
	_ctrl_Poignet_Pivot ctrlSetTextColor [1,1,1,1];
	_ctrl_Poignet_Pivot ctrlCommit 0;

	// Piece_Centrale_pompage
	private _ctrl_Piece_Centrale = _MRPV2_Interface_Base ctrlCreate ["rscpicture", -1, _ctrlGroup_Pompe];
	_ctrl_Piece_Centrale ctrlSetText "MRPV2_Farm_Petrole\Data\Pompe_Piece_Centrale.paa";
	_ctrl_Piece_Centrale ctrlSetPosition [safeZonew * 0.0625,safeZoneh * 0.065,safeZonew * 0.2,safeZoneh * 0.4];
	_ctrl_Piece_Centrale ctrlCommit 0;
};
// };
// [] spawn {sleep 2;[] call MRPV2_fnc_Petrole_Baril;};