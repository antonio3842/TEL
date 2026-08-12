// MRPV2_fnc_MRP_Tel_Menu_Nouveau_SMS_Crea_Liste = {
private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",displayNull];

private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _tv = uiNamespace getVariable ["MRP_menu_SMS_Action_Creation_Liste_Tree_Liste",controlnull];
private _texte = ctrltext (_Telephone_Base displayctrl 645);

{ctrlDelete _x} foreach allControls _tv;

private _Telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];
if (ctrltext _Telephone_Fond isnotequalto "MRP_Telephones\Data\Menu_SMS\Menu_SMS_ecrire_dxt5.paa") exitwith {};

if (_tv isEquaLTo controlnull) then
{
	private _pos_X = 0.04;
	private _pos_Y = 0.265;
	private _pos_H = 0.57;
	private _pos_L = 0.475;

	private _fond = _Telephone_Base ctrlCreate ["RscBackGround",-1,_telephone_Cadre_Base];
	uiNamespace setVariable ["MRP_menu_SMS_Action_Creation_Liste_Fond",_fond];
	_fond ctrlSetPosition [_pos_X,_pos_Y,_pos_L,_pos_H];
	_fond ctrlSetBackgroundColor [0,0,0,0.9];
	_fond ctrlEnable false;
	_fond ctrlCommit 0;

	_tv = _Telephone_Base ctrlCreate ["RscControlsGroupNoHScrollbars",-1,_telephone_Cadre_Base];
	uiNamespace setVariable ["MRP_menu_SMS_Action_Creation_Liste_Tree_Liste",_tv];
	_tv ctrlSetPosition [_pos_X,_pos_Y,_pos_L,_pos_H];
	_tv ctrlCommit 0;
};

private _liste_Contact = profileNamespace getvariable ["MRP_Telephone_Liste_Contact",createhashmap];
private _liste_Contacts = [];

{
	private _info_Contact = _y;
	private _prenom = _info_Contact # 0;
	private _nom = _info_Contact # 1;
	private _numero = _x;
	private _a_Un_Numero = (trim _numero) isNotEquaLTo "";
	private _texte_Traiter = trim (tolowerANSI _texte);

	if (_a_Un_Numero AND {_texte_Traiter isEqualTo "" OR {_texte_Traiter in tolowerANSI _prenom OR {_texte_Traiter in tolowerANSI _nom} OR {_texte_Traiter in tolowerANSI _numero}}}) then
	{
		_nom = trim _nom;
		_prenom = trim _prenom;

		[] call
		{
			if (_prenom isEquaLTo "") exitwith {_liste_Contacts pushback [_nom,_numero];};
			if (_nom isEquaLTo "") exitwith {_liste_Contacts pushback [_prenom,_numero];};

			_liste_Contacts pushback [_prenom + " " + _nom,_numero];
		};
	};
} foreach _liste_Contact;

_liste_Contacts sort TRUE;

if (_tv isNotEquaLTo controlnull) then
{
	private _tv = uiNamespace getVariable ["MRP_menu_SMS_Action_Creation_Liste_Tree_Liste",controlnull];
	private _fond = uiNamespace getVariable ["MRP_menu_SMS_Action_Creation_Liste_Fond",controlnull];

	private _pos_X = 0.04;
	private _pos_Y = 0.265;
	private _pos_H = 0.58;
	private _pos_L = 0.475;

	private _hauteur_Cadre_Resultat = ((count _liste_Contacts) * 0.08) min _pos_H;

	_fond ctrlSetPosition [_pos_X,_pos_Y,_pos_L,_hauteur_Cadre_Resultat min _pos_H];
	_tv ctrlSetPosition [_pos_X,_pos_Y,_pos_L,(_hauteur_Cadre_Resultat + 0.5) min _pos_H];
	_fond ctrlCommit 0;
	_tv ctrlCommit 0;
};

_SMS_Liste_Position_Verticale_Cumuler = 0;

{
	private _numero = _x # 1;

	// Interligne
	private _interligne = _Telephone_Base ctrlcreate ["MRP_Structured_Text",-1, _tv];
	_interligne ctrlSetPosition [0.06,_SMS_Liste_Position_Verticale_Cumuler,0.7,0.002];
	_interligne ctrlSetBackgroundColor [1,1,1,0.8];
	_interligne ctrlCommit 0;

	// Cadre Nom contact
	private _ctrl_Image = _Telephone_Base ctrlCreate ["MRP_Structured_Text",-1,_tv];
	_ctrl_Image ctrlSetPosition [0.05,_SMS_Liste_Position_Verticale_Cumuler + 0.02,0.28,0.05];
	_ctrl_Image ctrlCommit 0;

	private _intituler_Identifiant = [_numero] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Intituler;
	_ctrl_Image ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_20' shadow='0' color='#ffffff' size='1.2' align='left'>%1</t>",_intituler_Identifiant];

	private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_Bouton",-1,_tv];
	_ctrlButton ctrlSetPosition [0,_SMS_Liste_Position_Verticale_Cumuler,0.5,0.08];
	_ctrlButton ctrlsettext _numero;
	_ctrlButton ctrlSetfade 1;
	_ctrlButton ctrlCommit 0;

	_ctrlButton ctrlAddEventHandler ["ButtonClick",
	{params ["_control"];
		private _numero = ctrlText  _control;
		MRP_Telephone_Gestion_Numero_Interne = _numero;

		private _intituler_Identifiant = [_numero] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Intituler;

		private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
		private _edit = _Telephone_Base displayctrl 645;
		_edit ctrlsetText _intituler_Identifiant;

		private _champ_SMS = uiNamespace getVariable ["MRPV2_fnc_MRP_Tel_Menu_Nouveau_SMS_Crea_Champs_Message",displayNull];
		private _ctrlButton = uiNamespace getVariable ["MRPV2_fnc_MRP_Tel_Menu_Nouveau_SMS_Crea_Bouton_Envoyer",controlNull];

		if (ctrltext _champ_SMS isNotEqualTo "") then
		{
			_ctrlButton ctrlshow TRUE;
		};

		private _tv = uiNamespace getVariable ["MRP_menu_SMS_Action_Creation_Liste_Tree_Liste",controlnull];
		private _fond = uiNamespace getVariable ["MRP_menu_SMS_Action_Creation_Liste_Fond",controlnull];

		ctrlDelete _tv;
		ctrlDelete _fond;
	}];

	_SMS_Liste_Position_Verticale_Cumuler = _SMS_Liste_Position_Verticale_Cumuler + 0.08;
} foreach _liste_Contacts;

MRP_Telephone_Gestion_Numero_Interne = nil;

TRUE
// };