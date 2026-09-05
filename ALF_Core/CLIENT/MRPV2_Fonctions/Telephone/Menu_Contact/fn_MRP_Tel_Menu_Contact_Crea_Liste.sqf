// MRPV2_fnc_MRP_Tel_Menu_Contact_Crea_Liste = {
private _telephone_Cadre_Base = param [0,controlNull];
private _texte = param [1,""];


private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _tv = _Telephone_Base displayctrl 60520;

{ctrlDelete _x} foreach allControls _tv;

if (isnull _tv) then
{
	_tv = _Telephone_Base ctrlCreate ["RscControlsGroupNoScrollbars",60520,_telephone_Cadre_Base];
	_tv ctrlSetPosition [0.01,0.47,0.47,0.75];
	_tv ctrlCommit 0;
};

private _liste_Contact = profileNamespace getvariable ["MRP_Telephone_Liste_Contact",createhashmap];
private _liste_Contacts = [];


{
	private _info_Contact = _y;
	private _prenom = _info_Contact # 0;
	private _nom = _info_Contact # 1;
	private _entreprise = _info_Contact # 2;

	if (_entreprise isNotequalto "") then {_entreprise = "(" + _entreprise + ")"};

	private _numero = _x;

	if (tolowerANSI _texte isEqualTo "" OR {tolowerANSI _texte in tolowerANSI _prenom OR {tolowerANSI _texte in tolowerANSI _nom} OR {tolowerANSI _texte in tolowerANSI _numero}}) then
	{
		private _ID = _x;
		_nom = trim _nom;
		_prenom = trim _prenom;

		[] call
		{
			if (_prenom isEquaLTo "") exitwith {_liste_Contacts pushback [_nom,_ID,_entreprise];};
			if (_nom isEquaLTo "") exitwith {_liste_Contacts pushback [_prenom,_ID,_entreprise];};

			_liste_Contacts pushback [_prenom + " " + _nom,_ID,_entreprise];
		};
	};
} foreach _liste_Contact;

_liste_Contacts sort TRUE;

private _SMS_Liste_Position_Verticale_Cumuler = 0;

{
	private _numero = _x # 1;
	private _entreprise = _x # 2;

	// Interligne
	private _interligne = _Telephone_Base ctrlcreate ["MRP_Structured_Text",-1, _tv];
	_interligne ctrlSetPosition [0.06,_SMS_Liste_Position_Verticale_Cumuler,0.7,0.002];
	_interligne ctrlSetBackgroundColor [0,0,0,0.22];
	_interligne ctrlCommit 0;

	// Cadre Nom contact
	private _ctrl_Image = _Telephone_Base ctrlCreate ["MRP_Structured_Text",-1,_tv];	
	_ctrl_Image ctrlSetPosition [0.05,_SMS_Liste_Position_Verticale_Cumuler + 0.02,0.6,0.05];
	_ctrl_Image ctrlCommit 0;

	private _intituler_Identifiant = [_numero] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Intituler;
	_ctrl_Image ctrlSetStructuredText parseText format 
	[
		"<t font='SFUIDisplay_20' shadow='0' color='#000000' size='1.2' align='left'>%1</t>
		<t font='SFUIDisplay_20' shadow='0' color='#888888' size='1' align='left'>%2</t>",
		_intituler_Identifiant,_entreprise
	];

	private _liste_Contact = profileNamespace getvariable ["MRP_Telephone_Liste_Contact",createhashmap];
	private _contact_Bloquer = (_liste_Contact get _numero) # 5;
	if (_contact_Bloquer) then
	{
		// Icone bloquage
		private _icone_Appel = _Telephone_Base ctrlcreate ["RscPicture",-1, _tv];
		_icone_Appel ctrlSetPosition [0.03,_SMS_Liste_Position_Verticale_Cumuler + 0.025,0.025,0.035];
		_icone_Appel ctrlCommit 0;
		_icone_Appel ctrlSetText "MRP_icone_tel\Data\Menu_Contact\Icone_Contact_Bloquer_dxt5.paa";
	};

	private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_Bouton",-1,_tv];
	_ctrlButton ctrlSetPosition [0,_SMS_Liste_Position_Verticale_Cumuler,0.5,0.11];
	_ctrlButton ctrlsettext _numero;
	_ctrlButton ctrlSetfade 1;
	_ctrlButton ctrlCommit 0;
	_ctrlButton setVariable ["_fond_Contact",_ctrl_Image];

	_ctrlButton ctrlAddEventHandler ["ButtonClick",
	{params ["_control"];
		private _fond_Contact = _control getvariable ["_fond_Contact",controlNull];
		[_fond_Contact] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;

		playsound "MRP_Telephone_Touche_Appli";

		[_control] spawn
		{params ["_control"];
			sleep 0.2;

			private _numero = ctrlText _control;

			MRP_Telephone_Gestion_Numero_Interne = _numero;

			[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
			[_numero] call MRPV2_fnc_MRP_Tel_Menu_Contact_Lecture_Fiche;
		};
	}];

	_SMS_Liste_Position_Verticale_Cumuler = _SMS_Liste_Position_Verticale_Cumuler + 0.08;
} foreach _liste_Contacts;

MRP_Telephone_Gestion_Numero_Interne = nil;

TRUE
// };