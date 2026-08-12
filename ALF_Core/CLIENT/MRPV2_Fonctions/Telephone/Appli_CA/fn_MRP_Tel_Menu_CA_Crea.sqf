// MRPV2_fnc_MRP_Tel_Menu_CA_Crea = {
private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _Telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];
private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];

private _permission_Joueur = [] call MRPV2_fnc_MRP_NB_Service_Vers_TXT;

[] call
{
	if (_permission_Joueur isequalto "GN") exitwith
	{
		_Telephone_Fond ctrlSetText "MRP_Telephones\Data\Fond\Neogend_Fond_PC_Storm_Vide.paa";
	};

	if (_permission_Joueur isequalto "SP") exitwith
	{
		_Telephone_Fond ctrlSetText "MRP_Telephones\Data\Fond\Neogend_Fond_SP_Vide.paa";
	};

	if (_permission_Joueur isequalto "AP") then
	{
		_Telephone_Fond ctrlSetText "MRP_Telephones\Data\Fond\Neogend_Fond_AP_Vide.paa";
	};
};

_ctrl_Liste_Controle_Canaux = _Telephone_Base ctrlCreate ["RscControlsGroupNoScrollbars",-1,_telephone_Cadre_Base];
_ctrl_Liste_Controle_Canaux ctrlSetPixelPrecision 2;
uiNamespace setVariable ["MRP_Telephone_Menu_CA_ctrl_Liste_Controle_Canaux",_ctrl_Liste_Controle_Canaux];
_ctrl_Liste_Controle_Canaux ctrlSetPosition [0.038,0.3,0.48,1];
_ctrl_Liste_Controle_Canaux ctrlCommit 0;

// Icone Appli
private _RscPicture = _Telephone_Base ctrlCreate ["RscPicture",-1,_telephone_Cadre_Base];
_RscPicture ctrlSetPosition [0.23,0.05,0.1,0.12];
_RscPicture ctrlCommit 0;

[] call
{
	if (_permission_Joueur isequalto "GN") exitwith
	{
		_RscPicture ctrlSetText "MRP_Telephones\Data\Icones_Applications\Icone_CORG.paa";
	};

	if (_permission_Joueur isequalto "SP") exitwith
	{
		_RscPicture ctrlSetText "MRP_Telephones\Data\Icones_Applications\Icone_CTA.paa";
	};

	if (_permission_Joueur isequalto "AP") then
	{
		_RscPicture ctrlSetText "MRP_Telephones\Data\Icones_Applications\Icone_AP.paa";
	};
};

private _tel_CA_Info_Ope = player getvariable ["MRP_Tel_CA_Info_Operateur",createHashMap];
private _liste_CA = [];

{
	private _numero = _x;

	if (_numero isNotEqualTo "Mon appel") then
	{
		private _duree_Appel = _y # 0;
		private _etat_Appel = _y # 1;
		private _id_Appelant = _y # 2;
		private _numero_Masquer = _y # 3;
		private _mode_Entreprise = _y # 4;

		_liste_CA pushback [_numero,_duree_Appel,_etat_Appel,_id_Appelant,_numero_Masquer,_mode_Entreprise];
	};
} foreach _tel_CA_Info_Ope;

player setvariable ["MRP_Tel_CA_Info_Operateur",_tel_CA_Info_Ope];

_liste_CA sort TRUE;

{
	private _numero = _x # 0;
	private _duree_Appel = _x # 1;
	private _etat_Appel = _x # 2;
	private _id_Appelant = _x # 3;
	private _numero_Masquer = _x # 4;
	private _mode_Entreprise = _x # 5;

	[_numero,_duree_Appel,_etat_Appel,_foreachindex,_id_Appelant,_numero_Masquer,_mode_Entreprise] call MRPV2_fnc_MRP_Tel_Menu_CA_Ajout_Cadre_Appel;
} foreach _liste_CA;

private _numero_Enregistrer = (_tel_CA_Info_Ope get "Mon appel") # 0;

if (!(isnil {_numero_Enregistrer}) AND {_numero_Enregistrer isNotEquaLTo ""}) then
{
	private _ctrl_Liste_Controle_Canaux = uiNamespace getVariable ["MRP_Telephone_Menu_CA_ctrl_Liste_Controle_Canaux",controlNull];
	private _controle_Actif = ((allControls _ctrl_Liste_Controle_Canaux) select {(_x getvariable ["_numero",""]) isEqualTo _numero_Enregistrer}) # 0;

	[_controle_Actif] call MRPV2_fnc_MRP_Tel_Menu_CA_Crea_CG_Actions;
};

[] call MRPV2_fnc_MRP_Tel_Menu_CA_Gestion_Duree_Appel;
[] call MRPV2_fnc_MRP_Tel_Menu_CA_Creation_Options;

// Bouton retour menu principal
[] call MRPV2_fnc_MRP_Tel_Menu_Principal_Action_Retour;

TRUE
// };