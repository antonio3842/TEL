// MRPV2_fnc_MRP_Tel_Menu_CA_Crea_CG_Actions = {
private _ctrl = param [0,controlNull];


private _CG_CORG_Appel = _ctrl getvariable ["_CG_CORG_Appel",controlNull];
private _CG_Options = _CG_CORG_Appel getVariable ["MRP_Telephone_Menu_CAG_CG_Options",controlNull];
private _ctrl_Liste_Controle_Canaux = uiNamespace getVariable ["MRP_Telephone_Menu_CA_ctrl_Liste_Controle_Canaux",controlNull];
private _liste_Tous_Ctrl = (allControls _ctrl_Liste_Controle_Canaux) select {ctrlClassName _x isEqualTo "RscControlsGroupNoScrollbars" AND {ctrltooltip _x isNotEqualTo ""}};
private _numero = _ctrl getvariable ["_numero",""];

if (_CG_Options isEqualTo controlNull) then
{
	private _Rscframe = _ctrl getvariable ["_Rscframe",controlNull];
	private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];

	_CG_Options = _Telephone_Base ctrlCreate ["RscControlsGroupNoScrollbars",-1,_CG_CORG_Appel];
	_CG_CORG_Appel setVariable ["MRP_Telephone_Menu_CAG_CG_Options",_CG_Options];
	_CG_Options setVariable ["_CG_CORG_Appel",_CG_CORG_Appel];
	_CG_Options ctrlSetPixelPrecision 2;
	_CG_Options ctrlSetBackgroundColor [0,0,0,0.3];
	_CG_Options ctrlSetPosition [0,0,0.43,0.14];
	_CG_Options ctrlsetfade 1;
	_CG_Options ctrlCommit 0;
	_CG_Options ctrlSetPosition [0,0.1,0.43,0.14];
	_CG_Options ctrlsetfade 0;
	_CG_Options ctrlCommit 0.3;

	[_CG_Options,0.2] spawn MRP_Gestion_Anti_Spam_Bouton;

	// Bouton Accepter
	private _ctrlButton_Accepter = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_CG_Options];
	_ctrlButton_Accepter ctrlSetPosition [0,0.02,0.08,0.1];
	_ctrlButton_Accepter ctrlSetText "MRP_icone_tel\Data\Menu_Appel\Icone_appel.paa";
	_ctrlButton_Accepter ctrlSetTextColor [0.9,0.9,0.9,1];
	_ctrlButton_Accepter ctrlCommit 0;
	_ctrlButton_Accepter setvariable ["_Rscframe",_Rscframe];
	_ctrlButton_Accepter setvariable ["_numero",_numero];
	_ctrlButton_Accepter setvariable ["_CG_Options",_CG_Options];

	// Bouton En attente
	private _ctrlButton_Pause = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_CG_Options];
	_ctrlButton_Pause ctrlSetPosition [0.17,0.02,0.08,0.1];
	_ctrlButton_Pause ctrlSetText "MRP_icone_tel\Data\Icones_Applications\Icone_Appel_En_Pause.paa";
	_ctrlButton_Pause ctrlSetTextColor [0.9,0.9,0.9,1];
	_ctrlButton_Pause ctrlCommit 0;
	_ctrlButton_Pause setvariable ["_Rscframe",_Rscframe];
	_ctrlButton_Pause setvariable ["_numero",_numero];
	_ctrlButton_Pause setvariable ["_CG_Options",_CG_Options];

	// Bouton Arret
	private _ctrlButton_Arret = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_CG_Options];
	_ctrlButton_Arret ctrlSetPosition [0.34,0.02,0.08,0.1];
	_ctrlButton_Arret ctrlSetText "MRP_icone_tel\Data\Menu_Appel\Icone_Appel_Raccrocher.paa";
	_ctrlButton_Arret ctrlSetTextColor [0.9,0.9,0.9,1];
	_ctrlButton_Arret ctrlCommit 0;
	_ctrlButton_Arret setvariable ["_Rscframe",_Rscframe];
	_ctrlButton_Arret setvariable ["_numero",_numero];
	_ctrlButton_Arret setvariable ["_ctrl",_ctrl];

	////// EventHandler des bouton apres la création des 3 boutons pour avoir les id
	_ctrlButton_Accepter ctrlAddEventHandler ["ButtonClick",
	{params ["_control"];
		[_control,2] spawn MRP_Gestion_Anti_Spam_Bouton;
		[_control] call MRPV2_fnc_MRP_Tel_Menu_CA_Action_Appel;
	}];

	_ctrlButton_Pause ctrlAddEventHandler ["ButtonClick",
	{params ["_control"];
		[_control,2] spawn MRP_Gestion_Anti_Spam_Bouton;
		[_control] call MRPV2_fnc_MRP_Tel_Menu_CA_Action_Pause;
	}];

	_ctrlButton_Arret ctrlAddEventHandler ["ButtonClick",
	{params ["_control"];
		[_control,2] spawn MRP_Gestion_Anti_Spam_Bouton;
		[_control] call MRPV2_fnc_MRP_Tel_Menu_CA_Action_Arret;
	}];

	_CG_Options setvariable ["_ctrlButton_Accepter",_ctrlButton_Accepter];
	_CG_Options setvariable ["_ctrlButton_Pause",_ctrlButton_Pause];
	_CG_Options setvariable ["_ctrlButton_Arret",_ctrlButton_Arret];

	_CG_Options ctrlAddEventHandler ["MouseButtonClick",
	{params ["_control"];
		_ctrlButton_Accepter = _control getvariable ["_ctrlButton_Accepter",controlNull];
		_ctrlButton_Pause = _control getvariable ["_ctrlButton_Pause",controlNull];
		_ctrlButton_Arret = _control getvariable ["_ctrlButton_Arret",controlNull];

		if (!ctrlEnabled _ctrlButton_Accepter AND {!ctrlEnabled _ctrlButton_Pause AND {!ctrlEnabled _ctrlButton_Arret}}) then
		{
			private _ctrl_Liste_Controle_Canaux = uiNamespace getVariable ["MRP_Telephone_Menu_Dispatch_ctrl_Liste_Controle_Canaux",controlNull];
			private _liste_Tous_Ctrl = (allControls _ctrl_Liste_Controle_Canaux) select {ctrlClassName _x isEqualTo "RscControlsGroupNoScrollbars"};

			private _tel_CA_Info_Ope = player getvariable ["MRP_Tel_CA_Info_Operateur",createhashmap];
			private _numero_Enregistrer = (_tel_CA_Info_Ope get "Mon appel") # 0;

			private _CG_CORG_Appel_En_Cours = (_liste_Tous_Ctrl select {(ctrltooltip _x ) isEqualTo _numero_Enregistrer}) # 0;

			if (_CG_CORG_Appel_En_Cours isNotEquaLTo controlNull) then
			{
				private _RscBackground = _CG_CORG_Appel_En_Cours getvariable ["_RscBackground",controlNull];

				[_RscBackground] spawn
				{params ["_RscBackground"];
					_RscBackground ctrlSetBackgroundColor [0,1,0,0.3];
					sleep 0.3; _RscBackground ctrlSetBackgroundColor [0,0,0,0.3];
					sleep 0.3; _RscBackground ctrlSetBackgroundColor [0,1,0,0.3];
					sleep 0.3; _RscBackground ctrlSetBackgroundColor [0,0,0,0.3];
				};
			};
		};
	}];

	// Activation ou desactivation des icones d'interaction lorsque l'on arrive dans lecran en fonction de letat d'appel
	[] call
	{
		private _tel_CA_Info_Ope = player getvariable ["MRP_Tel_CA_Info_Operateur",createhashmap];
		private _etat_Appel_En_Cours_Autre = (_tel_CA_Info_Ope get _numero) # 1;

		private _numero_Mon_Appel = (_tel_CA_Info_Ope get "Mon appel") # 0;
		private _etat_Appel_En_Cours_Mon_Appel = (_tel_CA_Info_Ope get "Mon appel") # 1;
		private _etat_Appel_En_Cours_Final = "";

		[] call
		{
			// si je suis en appel et que j'ouvre un autre cadre
			if (_numero_Mon_Appel isNotequalto _numero AND {_etat_Appel_En_Cours_Mon_Appel isequalto "Appel"}) exitwith
			{
				_etat_Appel_En_Cours_Final = "Appel verrouiller";
			};

			if (_numero_Mon_Appel isequalto _numero) then
			{
				_etat_Appel_En_Cours_Final = _etat_Appel_En_Cours_Mon_Appel;
			};
		};

		// Si en pause on cache les boutons pause et raccrocher
		if (_etat_Appel_En_Cours_Final in ["Pause","","Appel verrouiller"]) then
		{
			_ctrlButton_Pause ctrlenable false;
			_ctrlButton_Pause ctrlsetfade 0.7;
			_ctrlButton_Pause ctrlCommit 0;

			_ctrlButton_Arret ctrlenable false;
			_ctrlButton_Arret ctrlsetfade 0.7;
			_ctrlButton_Arret ctrlCommit 0;
		};

		// Si en appel on cache le bouton appel
		if (_etat_Appel_En_Cours_Final in ["Appel","Appel verrouiller"]) then
		{
			_ctrlButton_Accepter ctrlenable FALSE;
			_ctrlButton_Accepter ctrlsetfade 0.7;
			_ctrlButton_Accepter ctrlCommit 0;
		};
	};

	// Fermeture des autres controles
	private _liste_Tous_Ctrl_En_Dessous = _liste_Tous_Ctrl select {ctrlposition _x # 1 > ctrlposition _CG_CORG_Appel # 1};
	private _ctrl_Ouvert = (_liste_Tous_Ctrl select {(ctrlposition _x # 3) isEqualTo 0.26}) # 0;

	if (isnil {_ctrl_Ouvert}) then
	{
		// baissage des controles en dessous
		{
			private _ctrl = _x;
			private _pos_Controle = ctrlposition _ctrl;

			_pos_Controle set [1,(_pos_Controle # 1) + 0.12];
			_ctrl ctrlSetPosition _pos_Controle;
			_ctrl ctrlCommit 0.3;
		} foreach _liste_Tous_Ctrl_En_Dessous;
	} else
	{
		[_Ctrl_Ouvert] spawn
		{params ["_Ctrl_Ouvert"];
			private _CG_Options = _Ctrl_Ouvert getVariable ["MRP_Telephone_Menu_CAG_CG_Options",controlNull];

			_CG_Options ctrlenable FALSE;
			_CG_Options ctrlsetfade 1;
			_CG_Options ctrlCommit 0.3;

			sleep 0.3;

			ctrldelete _CG_Options;

			_Ctrl_Ouvert ctrlsetpositionH 0.12;
			_Ctrl_Ouvert ctrlCommit 0;
		};

		private _liste_Tous_Ctrl_Au_Dessus = _liste_Tous_Ctrl select {ctrlposition _x # 1 > ctrlposition _Ctrl_Ouvert # 1};

		{
			private _Ctrl_Au_Dessus = _x;
			private _pos_Controle = ctrlposition _Ctrl_Au_Dessus;

			_Ctrl_Au_Dessus ctrlSetPositionY ((_pos_Controle # 1) - 0.12);
			_Ctrl_Au_Dessus ctrlCommit 0.3;
		} foreach _liste_Tous_Ctrl_Au_Dessus;

		private _ancien_Controle_Plus_Bas = ctrlposition _Ctrl_Ouvert # 1 > ctrlposition _CG_CORG_Appel # 1;

		if (_ancien_Controle_Plus_Bas) then
		{
			private _liste_Tous_Ctrl_Au_Dessus = _liste_Tous_Ctrl select {ctrlposition _x # 1 > ctrlposition _CG_CORG_Appel # 1};
			private _pos_Controle_Base_Y = ((ctrlposition _CG_CORG_Appel) # 1) + 0.12;

			{
				private _ctrl = _x;
				private _pos_Controle_Y = (_pos_Controle_Base_Y + (0.12 * (_foreachindex + 1)));

				_ctrl ctrlSetPositionY _pos_Controle_Y;
				_ctrl ctrlCommit 0.3;
			} foreach _liste_Tous_Ctrl_Au_Dessus;
		} else
		{
			private _liste_Tous_Ctrl_En_Dessous = _liste_Tous_Ctrl select {ctrlposition _x # 1 > ctrlposition _CG_CORG_Appel # 1};
			private _pos_Controle_Base_Y = (ctrlposition _CG_CORG_Appel) # 1;

			{
				private _ctrl = _x;
				private _pos_Controle_Y = (_pos_Controle_Base_Y + (0.12 * (_foreachindex + 1)));

				_ctrl ctrlSetPositionY _pos_Controle_Y;
				_ctrl ctrlCommit 0.3;
			} foreach _liste_Tous_Ctrl_En_Dessous;
		};
	};

	// Agrandissement du controle
	_CG_CORG_Appel ctrlsetpositionH 0.26;
	_CG_CORG_Appel ctrlCommit 0.3;
} else
{
	_CG_Options ctrlenable FALSE;
	_CG_Options ctrlSetPosition [0,0.01,0.42,0.11];
	_CG_Options ctrlsetfade 1;
	_CG_Options ctrlCommit 0.3;

	_CG_CORG_Appel ctrlsetpositionH 0.12;
	_CG_CORG_Appel ctrlCommit 0.3;

	private _liste_Tous_Ctrl = (allControls _ctrl_Liste_Controle_Canaux) select {ctrlClassName _x isEqualTo "RscControlsGroupNoScrollbars"};
	private _liste_Tous_Ctrl_En_Dessous = _liste_Tous_Ctrl select {ctrlposition _x # 1 > ctrlposition _CG_CORG_Appel # 1};

	{
		private _ctrl = _x;
		private _pos_Controle = ctrlposition _ctrl;
		_pos_Controle set [1,(_pos_Controle # 1) - 0.12];
		_ctrl ctrlSetPosition _pos_Controle;
		_ctrl ctrlCommit 0.3;
	} foreach _liste_Tous_Ctrl_En_Dessous - [_CG_CORG_Appel];

	[_CG_Options,_CG_CORG_Appel] spawn
	{params ["_CG_Options","_CG_CORG_Appel"];
		sleep 0.3;

		ctrldelete _CG_Options;

		uiNamespace setVariable ["MRP_Telephone_Menu_CAG_CG_Options",nil];
	};
};

// Gestion de la mini icone de signalisation de quel numero est en appel avec l'agent si il nest plus interactivement dessus
private _tel_CA_Info_Ope = player getvariable ["MRP_Tel_CA_Info_Operateur",createhashmap];
private _numero_Enregistrer = (_tel_CA_Info_Ope get "Mon appel") # 0;

private _CG_CORG_Appel_En_Cours = (_liste_Tous_Ctrl select {(ctrltooltip _x ) isEqualTo _numero_Enregistrer}) # 0;

private _control_Actif = (ctrlposition _CG_CORG_Appel_En_Cours # 3) > 0.12;
private _ctrlButton_Accepter_Icone = _CG_CORG_Appel_En_Cours getVariable ["_ctrlButton_Accepter_Icone",controlNull];

if (_ctrlButton_Accepter_Icone isEquaLTo controlNull AND {_control_Actif OR {_numero_Enregistrer isNotEquaLTo _numero}}) then
{
	private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
	private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];

	private _ctrlButton_Accepter_Icone = _Telephone_Base ctrlCreate ["RscPicture",-1,_CG_CORG_Appel_En_Cours];
	_CG_CORG_Appel_En_Cours setVariable ["_ctrlButton_Accepter_Icone",_ctrlButton_Accepter_Icone];
	_ctrlButton_Accepter_Icone ctrlSetPosition [0.23,0.025,0.035,0.045];

	private _etat_Appel = (_tel_CA_Info_Ope get "Mon appel") # 1;

	if (_etat_Appel isEquaLTo "Appel") then
	{
		_ctrlButton_Accepter_Icone ctrlSetText "MRP_icone_tel\Data\Menu_Appel\Icone_appel.paa";
	} else
	{
		_ctrlButton_Accepter_Icone ctrlSetText "MRP_icone_tel\Data\Icones_Applications\Icone_Appel_En_Pause.paa";
	};

	_ctrlButton_Accepter_Icone ctrlSetTextColor [0.9,0.9,0.9,1];
	_ctrlButton_Accepter_Icone ctrlSetFade 1;
	_ctrlButton_Accepter_Icone ctrlCommit 0;
	_ctrlButton_Accepter_Icone ctrlSetFade 0.5;
	_ctrlButton_Accepter_Icone ctrlCommit 0.3;
};

if (_ctrlButton_Accepter_Icone isNotEquaLTo controlNull AND {_control_Actif OR {_numero_Enregistrer isEquaLTo _numero}}) then
{
	_ctrlButton_Accepter_Icone ctrlSetFade 1;
	_ctrlButton_Accepter_Icone ctrlcommit 0.3;

	_CG_CORG_Appel setVariable ["_ctrlButton_Accepter_Icone",nil];

	[_ctrlButton_Accepter_Icone] spawn {params ["_ctrlButton_Accepter_Icone"]; uisleep 0.3; ctrlDelete _ctrlButton_Accepter_Icone;};
};

TRUE
// };