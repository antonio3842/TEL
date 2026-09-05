// MRPV2_fnc_MRP_Tel_Menu_Historique_Crea_Liste = {
private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];

private _ctrl_Historique = uiNamespace getVariable ["MRP_Telephone_Menu_Historique_Ctrl",controlNull];
if (_ctrl_Historique isnotEqualTo controlNull) then {ctrldelete _ctrl_Historique;};

// Contenus Historique
private _ctrl_Historique = _Telephone_Base ctrlCreate ["RscControlsGroupNoScrollbars",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Telephone_Menu_Historique_Ctrl",_ctrl_Historique];
_ctrl_Historique ctrlSetPosition [0.04,0.278,0.48,0.96];
_ctrl_Historique ctrlCommit 0;

private _liste_Contact = profileNamespace getvariable ["MRP_Telephone_Liste_Contact",createhashmap];
private _liste_Historique = profileNamespace getvariable ["MRP_Telephone_Liste_Historique",[]];
reverse _liste_Historique;

private _taille_Cadre_Messages = 0.1;
private _espacement_Verticale_Entre_Messages = 0.06;
private _MRP_SMS_Lecture_Position_Verticale_Cumuler = 0.02;

{
	private _liste_Profondeur_Date = _x;
	private _historique_Date = _liste_Profondeur_Date # 0;
	private _historique_Annee = _historique_Date # 0;
	private _historique_Mois = _historique_Date # 1;
	private _historique_Jour = _historique_Date # 2;
	private _historique_Heure = _historique_Date # 3;
	private _historique_Minute = _historique_Date # 4;
	private _numero = trim (_liste_Profondeur_Date # 1);
	private _code = _liste_Profondeur_Date # 2;

	// Interligne
	private _interligne = _Telephone_Base ctrlcreate ["MRP_Structured_Text",-1, _ctrl_Historique];
	_interligne ctrlSetPosition [0.04,_MRP_SMS_Lecture_Position_Verticale_Cumuler,0.5,0.002];
	_interligne ctrlCommit 0;

	_MRP_SMS_Lecture_Position_Verticale_Cumuler = _MRP_SMS_Lecture_Position_Verticale_Cumuler + 0.02;

	// Icone appel
	private _icone_Appel = _Telephone_Base ctrlcreate ["RscPicture",-1, _ctrl_Historique];
	_icone_Appel ctrlSetPosition [0,_MRP_SMS_Lecture_Position_Verticale_Cumuler,0.05,0.06];
	_icone_Appel ctrlSetText "";
	_icone_Appel ctrlCommit 0;

	if (_code in [2,3]) then
	{
		_icone_Appel ctrlSetText "MRP_icone_tel\Data\Menu_Historique\Petite_icone_recent_sortant_dxt5.paa";
	};

	// Intitulé
	private _texte_Contact = _Telephone_Base ctrlcreate ["MRP_Structured_Text",-1, _ctrl_Historique];
	_texte_Contact ctrlSetPosition [0.035,_MRP_SMS_Lecture_Position_Verticale_Cumuler,0.33,0.05];
	_texte_Contact ctrlCommit 0;

	private _info_Contact = _liste_Contact getOrDefault [_numero,[]];

	private _intituler_Appel = [_numero] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Intituler;
	private _liste_Entreprise = profilenamespace getvariable ["MRP_Tel_Liste_Entreprise",[]];
	private _numero_Pas_Service = (_liste_Entreprise select {(_x getOrDefault ["PHONE",""]) isequalto _numero}) isequalto [];
	private _format_Contact = "";

	if (_info_Contact isEqualTo [] AND {_numero_Pas_Service AND {_numero isnotequalto "Numéro masqué"}}) then
	{
		_format_Contact = format ["<t font='SFUIDisplay_20' color='#000000' shadow='0' size='1.2' align='left'>%1</t><t font='SFUIDisplay_20' color='#89898c' shadow='0' size='0.7' align='left'>%2</t>",parsetext _intituler_Appel,"  (Inconnu)"];
	} else
	{
		_format_Contact = format ["<t font='SFUIDisplay_20' color='#000000' shadow='0' size='1.2' align='left'>%1</t>",parsetext _intituler_Appel];
	};

	// Appel en rouge
	if (_code in [0,2]) then
	{
		if (_info_Contact isEqualTo [] AND {_numero_Pas_Service AND {_numero isnotequalto "Numéro masqué"}}) then
		{
			_format_Contact = format ["<t font='SFUIDisplay_20' color='#FF0000' shadow='0' size='1.2' align='left'>%1</t><t font='SFUIDisplay_20' color='#89898c' shadow='0' size='0.7' align='left'>%2</t>",parsetext _intituler_Appel,"  (Inconnu)"];
		} else
		{
			_format_Contact = format ["<t font='SFUIDisplay_20' color='#FF0000' shadow='0' size='1.2' align='left'>%1</t>",parsetext _intituler_Appel];
		};
	};

	_texte_Contact ctrlSetStructuredText parseText _format_Contact;

	// Date
	private _texte_Contact = _Telephone_Base ctrlcreate ["MRP_Structured_Text",-1, _ctrl_Historique];
	_texte_Contact ctrlSetPosition [0.09,_MRP_SMS_Lecture_Position_Verticale_Cumuler + 0.01,0.35,0.05];
	_texte_Contact ctrlCommit 0;

	private _historique_Jour_Formater = ([_historique_Jour] apply {if (_x < 10) then {"0" + str _x} else {str _x }}) # 0;
	private _historique_Mois_Formater = ([_historique_Mois] apply {if (_x < 10) then {"0" + str _x} else {str _x }}) # 0;

	private _format_Date = format ["<t font='SFUIDisplay_20' color='#89898c' shadow='0' size='0.8' align='right'>%1/%2</t>",_historique_Jour_Formater,_historique_Mois_Formater];

	private _meme_Annee = (systemTimeUTC # 0) isEqualTo _historique_Annee;

	if (_meme_Annee) then
	{
		private _meme_Mois = (systemTimeUTC # 1) isEqualTo _historique_Mois;

		if (_meme_Mois) then
		{
			private _hier = ((systemTimeUTC # 2) - 1) isEqualTo _historique_Jour;

			if (_hier) exitwith
			{
				_format_Date = format ["<t font='SFUIDisplay_20' color='#89898c' shadow='0' size='0.8' align='right'>%1</t>","Hier"];
			};

			private _meme_Jour = (systemTimeUTC # 2) isEqualTo _historique_Jour;

			if (_meme_Jour) then
			{
				private _meme_Heure = ((systemTimeUTC # 3) + UTC_DIFF) isEqualTo _historique_Heure;
				private _moins_De_1_Minutes = (systemTimeUTC # 4) < (_historique_Minute + 1);

				if (_meme_Heure AND {_moins_De_1_Minutes}) exitwith
				{
					_format_Date = format ["<t font='SFUIDisplay_20' color='#89898c' shadow='0' size='0.8' align='right'>%1</t>",'A l''instant'];
				};

				private _heures = ([_historique_Heure] apply {if (_x < 10) then {"0" + str _x} else {str _x }}) # 0;
				private _minutes = ([_historique_Minute] apply {if (_x < 10) then {"0" + str _x} else {str _x }}) # 0;

				_format_Date = format ["<t font='SFUIDisplay_20' color='#89898c' shadow='0' size='0.8' align='right'>%1:%2</t>",_heures,_minutes];
			};
		};
	} else
	{
		_format_Date = format ["<t font='SFUIDisplay_20' color='#89898c' shadow='0' size='0.8' align='right'>%1</t>",_historique_Annee];
	};

	_texte_Contact ctrlSetStructuredText parseText _format_Date;

	// Bouton Champs appel
	private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_Bouton",-1,_ctrl_Historique];
	_ctrlButton ctrlSetPosition [0.045,_MRP_SMS_Lecture_Position_Verticale_Cumuler - 0.02,0.39,0.08];
	_ctrlButton ctrlCommit 0;
	_ctrlButton setVariable ["MRP_Telephone_Historique_Numero",_numero];

	_ctrlButton ctrlAddEventHandler ["ButtonClick",
	{params ["_control"];
		playsound "MRP_Telephone_Touche_Appli";

		private _numero = _control getvariable ["MRP_Telephone_Historique_Numero",""];
		if (_numero isequalto "Numéro masqué") exitwith {};

		MRP_Telephone_Gestion_Numero_Interne = _numero;

		[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
		[] call MRPV2_fnc_MRP_Tel_Menu_Appel_Crea;
	}];

	private _liste_Entreprise = profilenamespace getvariable ["MRP_Tel_Liste_Entreprise",[]];
	private _numero_Pas_Service = (_liste_Entreprise select {(_x getOrDefault ["PHONE",""]) isequalto _numero}) isequalto [];

	private _numero_Pas_Masquer = _numero isNotequalto "Numéro masqué";

	if (_numero_Pas_Service AND {_numero_Pas_Masquer}) then
	{
		// Bouton info menu contact
		private _icone_Appel = _Telephone_Base ctrlcreate ["MRP_RscClickableText",-1, _ctrl_Historique];
		_icone_Appel ctrlSetPosition [0.44,_MRP_SMS_Lecture_Position_Verticale_Cumuler + 0.004,0.03,0.04];
		_icone_Appel ctrlCommit 0;
		_icone_Appel ctrlSetText "MRP_icone_tel\Data\Menu_Historique\icone_Info_dxt5.paa";
		_icone_Appel ctrlSetTextColor [0.8,0.8,0.8,1];
		_icone_Appel setVariable ["MRP_Telephone_Historique_Numero",_numero];

		_icone_Appel ctrlAddEventHandler ["ButtonClick",
		{params ["_control"];
			playsound "MRP_Telephone_Touche_Appli";

			MRP_Telephone_Gestion_Numero_Interne = nil;
			[_control] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;

			[_control] spawn
			{params ["_control"];
				sleep 0.2;

				_numero = _control getvariable ["MRP_Telephone_Historique_Numero",""];
				_control setVariable ["MRP_Telephone_Historique_Numero",nil];

				MRP_Telephone_Gestion_Numero_Interne = _numero;

				private _liste_Contact = profileNamespace getvariable ["MRP_Telephone_Liste_Contact",createhashmap];
				private _info_Contact = _liste_Contact getOrDefault [_numero,[]];

				[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;

				if (_info_Contact isEqualTo []) then
				{
					[] call MRPV2_fnc_MRP_Tel_Menu_Contact_Modif_Crea;
				} else
				{
					[] call MRPV2_fnc_MRP_Tel_Menu_Contact_Lecture_Fiche;
				};
			};
		}];
	};

	_MRP_SMS_Lecture_Position_Verticale_Cumuler = _MRP_SMS_Lecture_Position_Verticale_Cumuler + _espacement_Verticale_Entre_Messages;
} foreach _liste_Historique;

reverse _liste_Historique;

[] call MRPV2_fnc_MRP_Tel_Divers_Crea_Liste_Nombre_Appel;

MRP_Telephone_Gestion_Numero_Interne = nil;

TRUE
// };