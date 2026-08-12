// MRPV2_fnc_Petrole_Baril_Anim_Pompe ={
private _ctrlGroup_Pompe = param [0,controlnull];
private _action = param [1,FALSE];


private _etat_Pompe = player getvariable ["MRPV2_Petrole_Pompe",""];
if (_etat_Pompe in ["Pompe","En mouvement"]) exitwith {};

private _ctrl_Bouton_Pompe = uiNamespace getVariable ["MRPV2_Petrole_Baril_Bouton_Pompe",controlnull];
_ctrl_Bouton_Pompe ctrlSetPosition [safeZoneX + 0.73 * safeZoneW,safezoneY + 0.1 * safezoneh,0.19 * safeZoneW,0.3 * safezoneh];
_ctrl_Bouton_Pompe ctrlCommit 0;

if (_action) then
{
	_ctrlGroup_Pompe ctrlSetPositionX (safeZoneW * 0.389);

	_ctrl_Bouton_Pompe ctrlSetPositionX (safeZoneW * 0.13);
	_ctrl_Bouton_Pompe ctrlSetPositionY (safeZoneh * 0.02);

	ctrlSetFocus _ctrlGroup_Pompe;
	ctrlSetFocus _ctrl_Bouton_Pompe;
} else
{
	_ctrlGroup_Pompe ctrlSetPositionY (safeZoneh * 0.1);
};

_ctrlGroup_Pompe ctrlCommit 1;
_ctrl_Bouton_Pompe ctrlCommit 1;

sleep 1.1;

if (_action) then
{
	_ctrlGroup_Pompe ctrlSetPositionY (safeZoneh * 0.309);
	_ctrlGroup_Pompe ctrlCommit 1;

	sleep 1;	

	// Création affichage baril de remplissage
	private _MRPV2_Interface_Base = uiNamespace getVariable ["MRPV2_Interface_Diverse",controlnull];
	private _liste_Ctrl_Baril = MRPV2_Petrole_Baril_Au_Milieu # 0;
	private _ctrlGroup_Baril = _liste_Ctrl_Baril # 0;
	private _ctrl_Baril = _liste_Ctrl_Baril # 1;

	private _ctrlGroup = uiNamespace getVariable ["_ctrlGroup",controlnull];
	private _ctrlGroup_Baril_remplissage = _MRPV2_Interface_Base ctrlCreate ["RscControlsGroupNoScrollbars",-1,_ctrlGroup];
	_ctrlGroup_Baril_remplissage ctrlSetBackgroundColor [1,0,0,0.9];

	private _scale_Temp = ctrlscale _ctrlGroup_Baril;
	private _pos_GrpCtrl_Baril = ctrlPosition _ctrlGroup_Baril;
	_ctrlGroup_Baril_remplissage ctrlSetPosition [safeZonew * 0.35,safezoneh * 0.4,(_pos_GrpCtrl_Baril # 2) + 0.4,(_pos_GrpCtrl_Baril # 3) + 0.7];
	_ctrlGroup_Baril_remplissage ctrlSetScale _scale_Temp;
	_ctrlGroup_Baril_remplissage ctrlCommit 0;

	private _ctrl_Baril_Surcouche_remplissage = _MRPV2_Interface_Base ctrlCreate ["Rscpicture",-1,_ctrlGroup_Baril_remplissage];
	uinamespace setvariable ["_ctrl_Baril_Surcouche_remplissage",_ctrl_Baril_Surcouche_remplissage];

	_ctrl_Baril_Surcouche_remplissage ctrlcommit 0;
	_ctrl_Baril_Surcouche_remplissage ctrlSetText "MRPV2_Farm_Petrole\Data\Baril_Pour_Remplir.paa";
	private _pos_Temp = ctrlposition _ctrl_Baril;
	private _scale_Temp = ctrlscale _ctrl_Baril;
	_ctrl_Baril_Surcouche_remplissage ctrlSetPosition [0,0,_pos_Temp # 2,_pos_Temp # 3];
	_ctrl_Baril_Surcouche_remplissage ctrlSetScale _scale_Temp;
	_ctrl_Baril_Surcouche_remplissage ctrlsetfade 1;
	_ctrl_Baril_Surcouche_remplissage ctrlCommit 0;		
	
	_ctrl_Baril_Surcouche_remplissage ctrlsetfade 0;
	_ctrl_Baril_Surcouche_remplissage ctrlCommit 1;

	sleep 1;

	private _MRPV2_Petrole_Baril_Bouton_Tas_Gauche = uiNamespace getVariable ["MRPV2_Petrole_Baril_Bouton_Tas_Gauche",controlnull];
	ctrlSetFocus _MRPV2_Petrole_Baril_Bouton_Tas_Gauche;
	_ctrlGroup_Baril_remplissage ctrlenable false;

	// Après mise en place de la pompe, création du niveau de pétrole pour l'action de pompe
	private _ctrl_Niveau_Petrole = _MRPV2_Interface_Base ctrlCreate ["RscBackground",-1,_ctrlGroup_Baril_remplissage];
	uinamespace setvariable ["_ctrl_Niveau_Petrole",_ctrl_Niveau_Petrole];
	_ctrl_Niveau_Petrole ctrlSetPosition [safeZonew * 0.087,safezoneh * 0.565,safeZonew * 0.0535,0];
	_ctrl_Niveau_Petrole ctrlSetBackgroundColor [0,0,0,0.9];
	_ctrl_Niveau_Petrole ctrlCommit 0;
	_ctrl_Niveau_Petrole ctrlenable false;

	player setvariable ["MRPV2_Petrole_Pompe","Pompe abaissé"];
} else
{
	_ctrlGroup_Pompe ctrlSetPositionX (safeZoneW * 0.7);
	_ctrlGroup_Pompe ctrlCommit 1;

	private _liste_Ctrl_Baril = MRPV2_Petrole_Baril_Au_Milieu # 0;
	private _ctrlGrp_Baril = _liste_Ctrl_Baril # 0;	
	_ctrlGrp_Baril ctrlenable TRUE;

	(_liste_Ctrl_Baril # 1) ctrlSetText "MRPV2_Farm_Petrole\Data\Baril_Remplis.paa";

	private _ctrl_Baril_Surcouche_remplissage = uinamespace getVariable ["_ctrl_Baril_Surcouche_remplissage",controlnull];
	private _ctrl_Niveau_Petrole = uinamespace getVariable ["_ctrl_Niveau_Petrole",controlnull];

	_ctrl_Baril_Surcouche_remplissage ctrlsetfade 1;	
	_ctrl_Niveau_Petrole ctrlsetfade 1;

	_ctrl_Baril_Surcouche_remplissage ctrlcommit 1;
	_ctrl_Niveau_Petrole ctrlcommit 1;

	sleep 1;

	player setvariable ["MRPV2_Petrole_Pompe","Pompe relevé"];	

	sleep 1;
	
	ctrldelete _ctrl_Niveau_Petrole;
	ctrldelete _ctrl_Baril_Surcouche_remplissage;
};
// };