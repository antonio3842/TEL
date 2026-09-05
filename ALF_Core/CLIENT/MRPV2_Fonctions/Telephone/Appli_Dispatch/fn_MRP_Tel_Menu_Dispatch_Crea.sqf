// MRPV2_fnc_MRP_Tel_Menu_Dispatch_Crea = {
private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _Telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];

private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];

private _permission_Joueur = [] call MRPV2_fnc_MRP_NB_Service_Vers_TXT;

[] call
{
	if (_permission_Joueur isequalto "GN") exitwith	{_Telephone_Fond ctrlSetText "MRP_icone_tel\Data\Fond\Neogend_Fond_PC_Storm.paa";};
	if (_permission_Joueur isequalto "SP") exitwith {_Telephone_Fond ctrlSetText "MRP_icone_tel\Data\Fond\Neogend_Fond_SP_Vide.paa";};
	if (_permission_Joueur isequalto "AP") then {_Telephone_Fond ctrlSetText "MRP_icone_tel\Data\Fond\Neogend_Fond_AP_Vide.paa";};
};

_tv = _Telephone_Base ctrlCreate ["RscControlsGroupNoScrollbars",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Telephone_Menu_Dispatch_ctrl_Liste_Controle_Canaux",_tv];
_tv ctrlSetPosition [0.038,0.3,0.48,1];
_tv ctrlCommit 0;

// Icone Appli
private _RscPicture = _Telephone_Base ctrlCreate ["RscPicture",-1,_telephone_Cadre_Base];
_RscPicture ctrlSetPosition [0.23,0.05,0.1,0.12];
_RscPicture ctrlCommit 0;

[] call
{
	if (_permission_Joueur isequalto "SP") exitwith	{_RscPicture ctrlSetText "MRP_icone_tel\Data\Icones_Applications\Icone_CODIS.paa";};
	if (_permission_Joueur isequalto "AP") then {_RscPicture ctrlSetText "MRP_icone_tel\Data\Icones_Applications\Icone_DSPOM.paa";};
};

private _compteur_Verticale = 0;

private _gestion_Liste_Frequences = [] call MRPV2_fnc_MRP_Tel_Menu_Dispatch_Gestion_Frequences;
private _liste_Frequences = _gestion_Liste_Frequences # 0;
private _frequence_Base = _gestion_Liste_Frequences # 1;

[] call MRPV2_fnc_MRP_Tel_Menu_Dispatch_Crea_Options;

{
	private _intituler_Frequence = _x;
	private _ecart_Vertical = 0.1 * _compteur_Verticale;
	private _ecart_Entre_Cadre = 0;

	if (_foreachindex <= 0) then
	{
		_ecart_Entre_Cadre = 0.02 * _compteur_Verticale;
	} else
	{
		_ecart_Entre_Cadre = 0.02 * (_compteur_Verticale + 2);
	};

	_ecart_Vertical = _ecart_Vertical + _ecart_Entre_Cadre;

	private _RscBackground = _Telephone_Base ctrlCreate ["RscBackground",-1,_tv];
	_RscBackground ctrlEnable false;
	_RscBackground ctrlSetPosition [0.03,0.01 + _ecart_Vertical,0.42,0.1];
	_RscBackground ctrlSetPixelPrecision 2;
	_RscBackground ctrlSetBackgroundColor [0,0,0,0.3];
	_RscBackground ctrlCommit 0;

	// Cadre Dispatch
	private _RscFrame = _Telephone_Base ctrlCreate ["RscFrame",-1,_tv];
	_RscFrame ctrlEnable false;
	_RscFrame ctrlSetPosition [0.03,0.01 + _ecart_Vertical,0.42,0.1];
	_RscFrame ctrlCommit 0;

	// Texte Canal
	_edit_Texte = _Telephone_Base ctrlCreate ["MRP_Structured_Text",-1,_tv];
	_edit_Texte ctrlEnable false;
	_edit_Texte ctrlSetPosition [0.03,0.035 + _ecart_Vertical,0.4,0.1];
	_edit_Texte ctrlCommit 0;

	// Nombre connexion
	_edit = _Telephone_Base ctrlCreate ["MRP_Structured_Text",-1,_tv];
	_edit ctrlEnable false;
	_edit ctrlSetPosition [0.35,0.035 + _ecart_Vertical,0.1,0.1];
	_edit ctrlCommit 0;

	private _nombre_Joueur_Connecter = [_frequence_Base,_foreachindex] call MRPV2_fnc_MRP_Tel_Menu_Dispatch_Gestion_Nombre_Ope_Freq;

	if !(isnil {MRP_Telephone_Info_Dispatch}) then
	{
		if (_intituler_Frequence in str MRP_Telephone_Info_Dispatch) then
		{
			_RscFrame ctrlSetTextColor [0,1,0,1];
			_edit_Texte ctrlSetTextColor [0,1,0,1];
			_edit_Texte ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_46' shadow='1.5' color='#3dff00' size='1' align='left'>%1</t>",_intituler_Frequence];
			_edit ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_46' shadow='1.5' color='#3dff00' size='1' align='Right'>%1</t>",_nombre_Joueur_Connecter];
		} else
		{
			_RscFrame ctrlSetTextColor [1,1,1,1];
			_edit_Texte ctrlSetTextColor [1,1,1,1];
			_edit_Texte ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_46' shadow='1.5' color='#ffffff' size='1' align='left'>%1</t>",_intituler_Frequence];
			_edit ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_46' shadow='1.5' color='#ffffff' size='1' align='Right'>%1</t>",_nombre_Joueur_Connecter];
		};
	} else
	{
		_RscFrame ctrlSetTextColor [1,1,1,1];
		_edit_Texte ctrlSetTextColor [1,1,1,1];
		_edit_Texte ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_46' shadow='1.5' color='#ffffff' size='1' align='left'>%1</t>",_intituler_Frequence];
		_edit ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_46' shadow='1.5' color='#ffffff' size='1' align='Right'>%1</t>",_nombre_Joueur_Connecter];
	};

	// Bouton Connexion
	private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_Bouton",-1,_tv];
	_ctrlButton ctrlSetPosition [0.03,0.01 + _ecart_Vertical,0.42,0.1];
	_ctrlButton ctrlCommit 0;
	_ctrlButton setvariable ["Frequence",_frequence_Base + _foreachindex];
	_ctrlButton setvariable ["Controle_Texte",_edit_Texte];
	_ctrlButton setvariable ["Controle_Nombre",_edit];
	_ctrlButton setvariable ["_foreachindex",_foreachindex];
	_ctrlButton setvariable ["_RscFrame",_RscFrame];

	ctrlsetfocus _ctrlButton;

	_ctrlButton ctrlAddEventHandler ["ButtonClick",
	{params ["_ctrl"];
		_ctrl ctrlEnable FALSE;
		[_ctrl] spawn
		{params ["_ctrl"];
			sleep 0.5;

			_ctrl ctrlEnable TRUE;
			ctrlsetfocus _ctrl;
		};

		playsound "MRP_Telephone_Touche_Appli";

		private _frequence = str(_ctrl getvariable ["Frequence","-1"]);
		private _RscFrame = (_ctrl getvariable ["_RscFrame",controlNull]);
		private _ctrl_Texte = (_ctrl getvariable ["Controle_Texte",controlNull]);
		private _texte = ctrltext _ctrl_Texte;
		private _Ctrl_Nombre = (_ctrl getvariable ["Controle_Nombre",controlNull]);
		private _foreachindex = (_ctrl getvariable ["_foreachindex",0]);
		private _nombre_Connecter = ctrltext _Ctrl_Nombre;

		if (isnil {MRP_Telephone_Info_Dispatch}) then {MRP_Telephone_Info_Dispatch = createhashmap;};

		private _est_Connecter = ctrlTextColor _ctrl_Texte isEquaLTo [0,1,0,1];
		private _liste_Collegues = (allplayers select {([_x] call MRPV2_fnc_MRP_NB_Service_Vers_TXT) isEquaLTo ([] call MRPV2_fnc_MRP_NB_Service_Vers_TXT)}) - [player];

		if (tolowerANSI _texte in ["conference","global"]) then
		{
			// On deconnecte du canal "global"
			if (_est_Connecter) then
			{
				player setVariable ["tf_unable_to_use_radio", true];
				[(call TFAR_fnc_ActiveSwRadio),0] call TFAR_fnc_setSwChannel;
				[(call TFAR_fnc_ActiveSwRadio),2,""] call TFAR_fnc_SetChannelFrequency;

				private _canal_Supp = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getAdditionalSwChannel;

				if (_canal_Supp isEqualTo 1) then
				{
					[(call TFAR_fnc_ActiveSwRadio),1] call TFAR_fnc_setAdditionalSwChannel;
				};

				if (_texte in str MRP_Telephone_Info_Dispatch) then
				{
					MRP_Telephone_Info_Dispatch deleteat "Secondaire";
				};

				private _configuration_Raccourcis_TFAR = ["TFAR","SWTransmitAdditional"] call CBA_fnc_getKeybind;
				_configuration_Raccourcis_TFAR set [3,{[] call TFAR_fnc_hideHint;}];
				_configuration_Raccourcis_TFAR set [4,{[] call TFAR_fnc_hideHint;}];
				_configuration_Raccourcis_TFAR set [8,TRUE];

				_configuration_Raccourcis_TFAR call CBA_fnc_addKeybind;

				if (_liste_Collegues isnotequalto []) then
				{
					[_texte,_frequence,0] remoteExec ["MRPV2_fnc_MRP_Tel_Menu_Dispatch_Gestion_Nombre_Connex_Collegue",_liste_Collegues];
				};

				private _nombre_Joueur_Connecter = [_frequence,0] call MRPV2_fnc_MRP_Tel_Menu_Dispatch_Gestion_Nombre_Ope_Freq;

				_RscFrame ctrlSetTextColor [1,1,1,1];
				_ctrl_Texte ctrlSetTextColor [1,1,1,1];
				_ctrl_Texte ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_46' shadow='1.5' color='#ffffff' size='1' align='left'>%1</t>",_texte];
				_Ctrl_Nombre ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_46' shadow='1.5' color='#ffffff' size='1' align='Right'>%1</t>",str (_nombre_Joueur_Connecter)];
			} else
			{
				player setVariable ["tf_unable_to_use_radio", false];
				[(call TFAR_fnc_ActiveSwRadio),0] call TFAR_fnc_setSwChannel;
				[(call TFAR_fnc_ActiveSwRadio),2,_frequence] call TFAR_fnc_SetChannelFrequency;
				[(call TFAR_fnc_ActiveSwRadio),1] call TFAR_fnc_setAdditionalSwChannel;

				private _conf_Raccourcis_Transmission_Courte_Portee = ["TFAR","SWTransmitAdditional"] call CBA_fnc_getKeybind;
				_conf_Raccourcis_Transmission_Courte_Portee set [3,
				{
					if (gestureState player isequalto "mrp_menotter") exitwith {};
					if (tolower (lifeState player) in ["incapacitated"]) exitwith {};
					if (isnil {[] call TFAR_fnc_activeSwRadio}) exitwith {};

					call TFAR_fnc_onAdditionalSwTangentPressed;

					private _frequence = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwFrequency;
					private _permission_Joueur = [] call MRPV2_fnc_MRP_NB_Service_Vers_TXT;
					private _type_Appli = [_permission_Joueur] call MRPV2_fnc_MRP_Tel_Divers_Type_Appli;

					private _texte_Transmission_Radio = ["Transmission",_type_Appli,"Secondaire"] call MRPV2_fnc_MRP_Tel_Divers_Config_Mess_Transmission_TFAR;

					[parsetext _texte_Transmission_Radio,-1] call TFAR_fnc_showHint;
				}];

				_conf_Raccourcis_Transmission_Courte_Portee set [4,
				{
					if (gestureState player isequalto "mrp_menotter") exitwith {};
					if (tolower (lifeState player) in ["incapacitated"]) exitwith {};
					if (isnil {[] call TFAR_fnc_activeSwRadio}) exitwith {};

					call TFAR_fnc_onAdditionalSwTangentReleased;

					private _frequence = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwFrequency;
					private _permission_Joueur = [] call MRPV2_fnc_MRP_NB_Service_Vers_TXT;
					private _type_Appli = [_permission_Joueur] call MRPV2_fnc_MRP_Tel_Divers_Type_Appli;

					private _texte_Transmission_Radio = ["Transmis avec",_type_Appli,"Secondaire"] call MRPV2_fnc_MRP_Tel_Divers_Config_Mess_Transmission_TFAR;

					[parsetext _texte_Transmission_Radio,2] call TFAR_fnc_showHint;
				}];

				_conf_Raccourcis_Transmission_Courte_Portee set [8,TRUE];
				_conf_Raccourcis_Transmission_Courte_Portee call CBA_fnc_addKeybind;

				MRP_Telephone_Info_Dispatch set ["Secondaire",_texte];

				if (_liste_Collegues isnotequalto []) then
				{
					[_texte,_frequence,0] remoteExec ["MRPV2_fnc_MRP_Tel_Menu_Dispatch_Gestion_Nombre_Connex_Collegue",_liste_Collegues];
				};
				private _nombre_Joueur_Connecter = [_frequence,0] call MRPV2_fnc_MRP_Tel_Menu_Dispatch_Gestion_Nombre_Ope_Freq;

				_RscFrame ctrlSetTextColor [0,1,0,1];
				_ctrl_Texte ctrlSetTextColor [0,1,0,1];
				_ctrl_Texte ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_46' shadow='1.5' color='#3dff00' size='1' align='left'>%1</t>",_texte];
				_Ctrl_Nombre ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_46' shadow='1.5' color='#3dff00' size='1' align='Right'>%1</t>",str _nombre_Joueur_Connecter];
			};
		} else
		{
			// On déconnecte du canal "Unité"
			if (_est_Connecter) then
			{
				player setVariable ["tf_unable_to_use_radio", true];
				[(call TFAR_fnc_ActiveSwRadio),0] call TFAR_fnc_setSwChannel;
				[(call TFAR_fnc_ActiveSwRadio),1,""] call TFAR_fnc_SetChannelFrequency;

				MRP_Telephone_Info_Dispatch deleteat "Principal";

				// On suppr les marqueurs de suivis de collegue
				if (!isnil {MRP_Dispatch_Liste_Suivis}) then {{deleteMarkerlocal _x;} foreach MRP_Dispatch_Liste_Suivis;MRP_Dispatch_Liste_Suivis = nil;};

				private _configuration_Raccourcis_TFAR = ["TFAR","SWTransmit"] call CBA_fnc_getKeybind;
				_configuration_Raccourcis_TFAR set [3,{[] call TFAR_fnc_hideHint;}];
				_configuration_Raccourcis_TFAR set [4,{[] call TFAR_fnc_hideHint;}];
				_configuration_Raccourcis_TFAR set [8,TRUE];

				_configuration_Raccourcis_TFAR call CBA_fnc_addKeybind;

				if (_liste_Collegues isnotequalto []) then
				{
					[_texte,_frequence] remoteExec ["MRPV2_fnc_MRP_Tel_Menu_Dispatch_Gestion_Nombre_Connex_Collegue",_liste_Collegues];
				};
				private _nombre_Joueur_Connecter = [_frequence] call MRPV2_fnc_MRP_Tel_Menu_Dispatch_Gestion_Nombre_Ope_Freq;

				player setvariable ["radioUnite","",TRUE];

				_RscFrame ctrlSetTextColor [1,1,1,1];
				_ctrl_Texte ctrlSetTextColor [1,1,1,1];
				_ctrl_Texte ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_46' shadow='1.5' color='#ffffff' size='1' align='left'>%1</t>",_texte];
				_Ctrl_Nombre ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_46' shadow='1.5' color='#ffffff' size='1' align='Right'>%1</t>",str _nombre_Joueur_Connecter];
			} else
			{
				player setVariable ["tf_unable_to_use_radio", false];
				[(call TFAR_fnc_ActiveSwRadio),0] call TFAR_fnc_setSwChannel;
				[(call TFAR_fnc_ActiveSwRadio),1,_frequence] call TFAR_fnc_SetChannelFrequency;						

				// Si un autre canal était actif avant on desactive l'ancien canal
				if !(_texte in str MRP_Telephone_Info_Dispatch) then
				{
					private _texte_Ancienne_Freq = MRP_Telephone_Info_Dispatch getordefault ["Principal",""];
					private _ctrl_Ancien_Texte = controlNull;
					private _ctrl_Ancien_Nombre = controlNull;
					private _ctrl_Ancien_RscFrame = controlNull;

					private _liste_Controle = allControls (ctrlparent _ctrl);
					private _ancienne_Frequence = 0;

					{
						private _ctrl_Texte = (_x getvariable ["Controle_Texte",controlNull]);
						private _texte = ctrltext _ctrl_Texte;

						if (_texte isequalto _texte_Ancienne_Freq) then
						{
							_ctrl_Ancien_Texte = _x;
							_ancienne_Frequence = _ctrl_Ancien_Texte getvariable ["Frequence","666"];
							_ctrl_Ancien_Nombre = _liste_Controle # (_foreachindex - 1);
							_ctrl_Ancien_Texte = _liste_Controle # (_foreachindex - 2);
							_ctrl_Ancien_RscFrame = _liste_Controle # (_foreachindex - 3);
						};
					} foreach _liste_Controle;

					if (_liste_Collegues isnotequalto []) then {[_texte_Ancienne_Freq,_ancienne_Frequence] remoteExec ["MRPV2_fnc_MRP_Tel_Menu_Dispatch_Gestion_Nombre_Connex_Collegue",_liste_Collegues];};
					private _nombre_Joueur_Connecter = [_ancienne_Frequence] call MRPV2_fnc_MRP_Tel_Menu_Dispatch_Gestion_Nombre_Ope_Freq;

					_ctrl_Ancien_RscFrame ctrlSetTextColor [1,1,1,1];
					_ctrl_Ancien_Texte ctrlSetTextColor [1,1,1,1];
					_ctrl_Ancien_Texte ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_46' shadow='1.5' color='#ffffff' size='1' align='left'>%1</t>",_texte_Ancienne_Freq];

					_ctrl_Ancien_Nombre ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_46' shadow='1.5' color='#ffffff' size='1' align='Right'>%1</t>",str _nombre_Joueur_Connecter];

					// On suppr les marqueurs de suivis de collegue
					if (!isnil {MRP_Dispatch_Liste_Suivis}) then {{deleteMarkerlocal _x;} foreach MRP_Dispatch_Liste_Suivis;MRP_Dispatch_Liste_Suivis = nil;};
				};

				MRP_Telephone_Info_Dispatch set ["Principal",_texte];

				private _conf_Raccourcis_Transmission_Courte_Portee = ["TFAR","SWTransmit"] call CBA_fnc_getKeybind;
				_conf_Raccourcis_Transmission_Courte_Portee set [3,
				{
					call TFAR_fnc_onSwTangentPressed;

					private _frequence = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwFrequency;
					private _permission_Joueur = [] call MRPV2_fnc_MRP_NB_Service_Vers_TXT;
					private _type_Appli = [_permission_Joueur] call MRPV2_fnc_MRP_Tel_Divers_Type_Appli;

					private _texte_Transmission_Radio = ["Transmission",_type_Appli,"Principal"] call MRPV2_fnc_MRP_Tel_Divers_Config_Mess_Transmission_TFAR;

					[parsetext _texte_Transmission_Radio,-1] call TFAR_fnc_showHint;
				}];

				_conf_Raccourcis_Transmission_Courte_Portee set [4,
				{
					call TFAR_fnc_onSwTangentReleased;

					private _frequence = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwFrequency;
					private _permission_Joueur = [] call MRPV2_fnc_MRP_NB_Service_Vers_TXT;
					private _type_Appli = [_permission_Joueur] call MRPV2_fnc_MRP_Tel_Divers_Type_Appli;

					private _texte_Transmission_Radio = ["Transmis avec",_type_Appli,"Principal"] call MRPV2_fnc_MRP_Tel_Divers_Config_Mess_Transmission_TFAR;

					[parsetext _texte_Transmission_Radio,2] call TFAR_fnc_showHint;
				}];

				_conf_Raccourcis_Transmission_Courte_Portee set [8,TRUE];
				_conf_Raccourcis_Transmission_Courte_Portee call CBA_fnc_addKeybind;

				if (_liste_Collegues isnotequalto []) then
				{
					[_texte,_frequence] remoteExec ["MRPV2_fnc_MRP_Tel_Menu_Dispatch_Gestion_Nombre_Connex_Collegue",_liste_Collegues];
				};
				private _nombre_Joueur_Connecter = [_frequence] call MRPV2_fnc_MRP_Tel_Menu_Dispatch_Gestion_Nombre_Ope_Freq;
				
				player setvariable ["radioUnite",_texte,TRUE];
				
				_RscFrame ctrlSetTextColor [0,1,0,1];
				_ctrl_Texte ctrlSetTextColor [0,1,0,1];
				_ctrl_Texte ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_46' shadow='1.5' color='#3dff00' size='1' align='left'>%1</t>",_texte];
				_Ctrl_Nombre ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_46' shadow='1.5' color='#3dff00' size='1' align='Right'>%1</t>",str _nombre_Joueur_Connecter];
			};

			private _ctrl_Principal_Option = uiNamespace getVariable ["MRP_Telephone_Menu_Dispatch_Menu_Options_Ctrl_Principal",controlNull];
			if (_ctrl_Principal_Option isnotEqualto controlNull) then
			{
				private _canal = MRP_Telephone_Info_Dispatch getordefault ["Principal",""];

				if (_canal isequalto "") then
				{
					_ctrl_Principal_Option ctrlSetText "Unité";
				} else
				{
					_ctrl_Principal_Option ctrlSetText _canal;
				};
			};
		};

		// Pour que l'on puisse compter les joueurs
		player setvariable ["MRP_Telephone_Info_Dispatch",MRP_Telephone_Info_Dispatch,TRUE];
	}];

	_compteur_Verticale = _compteur_Verticale + 1;
} foreach _liste_Frequences;

// Bouton retour menu principal
[] call MRPV2_fnc_MRP_Tel_Menu_Principal_Action_Retour;

TRUE
// };