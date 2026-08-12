// MRPV2_fnc_MRP_Tel_Menu_SMS_Crea_Liste = {
private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];


private _Ctrl_TV = uiNamespace getVariable ["MRPV2_fnc_MRP_Tel_Menu_SMS_Crea_Liste_Ctrl_TV",controlNull];
if (_Ctrl_TV isNotEqualTo controlNull) then {ctrlDelete _Ctrl_TV;};

// Liste Contact avec SMS
_tv = _Telephone_Base ctrlCreate ["RscControlsGroupNoScrollbars",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRPV2_fnc_MRP_Tel_Menu_SMS_Crea_Liste_Ctrl_TV",_tv];
_tv ctrlSetPosition [0.045,0.265,0.46,1];
_tv ctrlSetBackgroundColor [0,0,0,0.2];
_tv ctrlCommit 0;

private _liste_SMS = profileNamespace getvariable ["MRP_Telephone_Liste_SMS",createhashmap];
private _liste_Contact = profileNamespace getvariable ["MRP_Telephone_Liste_Contact",createhashmap];
private _liste_Dernier_SMS = [];
private _liste_Dernier_SMS_Trier = [];
private _liste_Derniere_Date_Trier = [];

// Pas de moyen de trier une liste a plusieur niveau par un attribut (Ou jai pas trouvé), on décompose le procédé pr y arriver
// Creation d'une liste avec les dernieres date par SMS
// Creation d'une liste avec les dernier SMS et leurs infos
{
	private _info_Contact = _y;
	private _info_Dernier_SMS = _info_Contact # ((count _info_Contact) - 1);
	private _dernier_SMS = _info_Dernier_SMS # 1;
	private _date = _info_Dernier_SMS # 2;

	_liste_Derniere_Date_Trier pushback _date;
	_liste_Dernier_SMS pushback [_date,_dernier_SMS,_x];
} foreach _liste_SMS;

// On trie la liste de date pour mettre la plus récente en premier
_liste_Derniere_Date_Trier sort FALSE;

// On trie la liste de sms par la premiere date de la liste de date qui correspond a la date de la liste SMS
// Comme ca on a les dernier sms par numero eux meme trier par la date la plus récente...
{
	private _date_liste_Date = _x;

	{
		private _SMS = _x;
		private _date_liste_SMS = _SMS # 0;

		if (_date_liste_Date isEqualTo _date_liste_SMS) exitwith {_liste_Dernier_SMS_Trier pushback _SMS;};
	} foreach _liste_Dernier_SMS;
} foreach _liste_Derniere_Date_Trier;

private _SMS_Liste_Position_Verticale_Cumuler = 0;

{
	private _info_Date = _x # 0;
	private _SMS = _x # 1;
	private _numero = _x # 2;

	// Interligne
	private _interligne = _Telephone_Base ctrlcreate ["MRP_Structured_Text",-1, _tv];
	_interligne ctrlSetPosition [0.075,_SMS_Liste_Position_Verticale_Cumuler,0.6,0.002];
	_interligne ctrlSetBackgroundColor [0,0,0,0.2];
	_interligne ctrlCommit 0;

	// Cadre principal contact SMS
	private _cadre_Contact = _Telephone_Base ctrlCreate ["RscStructuredText",-1,_tv];
	_cadre_Contact ctrlSetPosition [0,_SMS_Liste_Position_Verticale_Cumuler,0.5,0.11];
	_cadre_Contact ctrlCommit 0;

	// Cadre Icone contact
	private _ctrl_Image = _Telephone_Base ctrlCreate ["RscPicture",-1,_tv];
	_ctrl_Image ctrlSetPosition [0.006,_SMS_Liste_Position_Verticale_Cumuler + 0.026,0.058,0.076];
	_ctrl_Image ctrlCommit 0;

	private _info_Contact = _liste_Contact getOrDefault [_numero,""];

	private _prenom = "";
	private _nom = "";

	if (_info_Contact isNotEqualTo "") then
	{
		_prenom = _info_Contact # 0;
		_nom = _info_Contact # 1;
	};

	if (_info_Contact isEqualTo "" OR {_nom isEqualTo "" AND {_prenom isEqualTo ""}}) then
	{
		_ctrl_Image ctrlSetText "MRP_Telephones\Data\Menu_SMS\Icone_Contact_dxt5.paa";
	} else
	{
		_ctrl_Image ctrlSetText "MRP_Telephones\Data\Menu_SMS\Icone_Contact_Vide_dxt5.paa";

		// Initiale Prénom Nom
		private _edit = _Telephone_Base ctrlCreate ["MRP_Structured_Text",-1,_tv];
		_edit ctrlSetPosition [0.0035,_SMS_Liste_Position_Verticale_Cumuler + 0.042,0.058,0.076];
		_edit ctrlSetScale 1.1;
		_edit ctrlCommit 0;

		private _initiale = "";

		{
			if (_x isNotEqualTo "") then
			{
				private _premiere_Lettre = toUpper ((_x splitString "") # 0);

				_initiale = _initiale + _premiere_Lettre;
			};
		} foreach [(_info_Contact # 0),(_info_Contact # 1)];

		_edit ctrlSetStructuredText parsetext format ["<t font='SFUIDisplay_20' color='#ffffff' shadow='0' size='1' align='center'>%1</t>",_initiale];
	};

	private _compteur_Nouveau_SMS = (["Menu SMS",_numero] call MRPV2_fnc_MRP_Tel_Menu_SMS_Gestion_Nombre_SMS) min 99;
	if (_compteur_Nouveau_SMS > 0) then
	{
		// Icone nouveau mess
		private _fond_Ecran = _Telephone_Base ctrlCreate ["RscPicture",-1,_tv];
		_fond_Ecran ctrlSetPosition [0.05,_SMS_Liste_Position_Verticale_Cumuler + 0.067,0.022,0.03];
		_fond_Ecran ctrlSetText "MRP_Telephones\Data\Menu_Principal\Icone_Nombre_Message.paa";
		_fond_Ecran ctrlCommit 0;

		// Nombre nouveau mess
		private _edit = _Telephone_Base ctrlCreate ["MRP_Structured_Text",-1,_tv];
		_edit ctrlSetPosition [0.035,_SMS_Liste_Position_Verticale_Cumuler + 0.07,0.05,0.05];
		_edit ctrlCommit 0;
		_edit ctrlSetStructuredText parsetext format ["<t font='SFUIDisplay_20' color='#ffffff' shadow='0' size='0.6' align='center'>%1</t>",_compteur_Nouveau_SMS];
	};

	// Cadre Nom contact
	private _ctrl_Image = _Telephone_Base ctrlCreate ["RscStructuredText",-1,_tv];
	_ctrl_Image ctrlSetPosition [0.06,_SMS_Liste_Position_Verticale_Cumuler + 0.01,0.28,0.04];
	_ctrl_Image ctrlSetScale 0.9;
	_ctrl_Image ctrlCommit 0;

	private _intituler = [_numero] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Intituler;
	_ctrl_Image ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_20' shadow='0' color='#000000' size='1' align='left'>%1</t>",_intituler];

	// Cadre Icone vers SMS
	private _ctrl_Image = _Telephone_Base ctrlCreate ["RscPicture",-1,_tv];
	_ctrl_Image ctrlSetPosition [0.43,_SMS_Liste_Position_Verticale_Cumuler + 0.02,0.025,0.025];
	_ctrl_Image ctrlSetText "MRP_Telephones\Data\Menu_SMS\Icone_Fleche_dxt5.paa";
	_ctrl_Image ctrlCommit 0;

	// Cadre Dernier SMS
	private _ctrl_Image = _Telephone_Base ctrlCreate ["RscStructuredText",-1,_tv];
	_ctrl_Image ctrlSetPosition [0.064,_SMS_Liste_Position_Verticale_Cumuler + 0.05,0.36,0.06];
	_ctrl_Image ctrlSetScale 0.75;
	_ctrl_Image ctrlCommit 0;

	_ctrl_Image ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_20' shadow='0' color='#777777' size='1' align='left'>%1</t>",_SMS];

	// Cadre Date
	private _ctrl_Image = _Telephone_Base ctrlCreate ["RscStructuredText",-1,_tv];
	_ctrl_Image ctrlSetPosition [0.3,_SMS_Liste_Position_Verticale_Cumuler + 0.018,0.15,0.03];
	_ctrl_Image ctrlSetScale 0.75;
	_ctrl_Image ctrlCommit 0;

	private _jour = _info_Date # 2;
	private _mois = _info_Date # 1;
	private _annees = _info_Date # 0;

	if (_mois isEqualTo (systemTimeUTC # 1)) then
	{
		private _moins_De_7_Jour = (_jour - 7) < (systemTimeUTC # 2);

		if (_moins_De_7_Jour) then
		{
			private _jour_En_Mot = "";

			if (([_annees,_mois,_jour]) isEqualTo ([systemTimeUTC # 0,systemTimeUTC # 1,systemTimeUTC # 2])) then
			{
				private _heure = _info_Date # 3;

				if (_heure + 4 < systemTimeUTC # 3) then
				{
					_jour_En_Mot = 'Aujourd''hui';
				} else
				{
					private _minute = ([_info_Date # 4] apply {if (_x < 10) then {"0" + str _x} else {str(_x)}}) # 0;

					if (_heure >= 24) then
					{
						_heure = ([_heure - 24] apply {if (_x < 10) then {"0" + str _x} else {str _x }}) # 0;
					} else
					{
						_heure = ([_heure] apply {if (_x < 10) then {"0" + str _x} else {str _x }}) # 0;
					};

					_jour_En_Mot = _heure + ":" + _minute;
				};
			} else
			{
				_jour_En_Mot = [str(_annees),str(_mois),str(_jour),TRUE] call MRPV2_fnc_MRP_Tel_Divers_Conversion_Nombre_Jour_En_Mot;
			};

			_ctrl_Image ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_20' shadow='0' color='#777777' size='1' align='right'>%1</t>",_jour_En_Mot];
		};
	} else
	{
		_jour = ([_jour] apply {if (_x < 10) then {"0" + str _x} else {str _x }}) # 0;
		_mois = ([_mois] apply {if (_x < 10) then {"0" + str _x} else {str _x }}) # 0;
		
		_ctrl_Image ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_20' shadow='0' color='#777777' size='1' align='right'>%1/%2/%3</t>",_jour,_mois,_annees];
	};

	private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_Bouton",-1,_tv];
	_ctrlButton ctrlSetPosition [0,_SMS_Liste_Position_Verticale_Cumuler,0.5,0.11];
	_ctrlButton ctrlCommit 0;
	_ctrlButton setVariable ["_numero",_numero];

	_ctrlButton ctrlAddEventHandler ["ButtonClick",
	{params ["_control"];
		playsound "MRP_Telephone_Touche_Appli";
		
		MRP_Telephone_Gestion_Numero_Interne = _control getvariable ["_numero",""];

		[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
		[] call MRPV2_fnc_MRP_Tel_Menu_SMS_Lecture;
	}];

	_SMS_Liste_Position_Verticale_Cumuler = _SMS_Liste_Position_Verticale_Cumuler + 0.12;
} foreach _liste_Dernier_SMS_Trier;

MRP_Telephone_Gestion_Numero_Interne = nil;

TRUE
// };