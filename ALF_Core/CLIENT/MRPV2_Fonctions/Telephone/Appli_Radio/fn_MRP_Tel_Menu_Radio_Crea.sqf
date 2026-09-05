// MRPV2_fnc_MRP_Tel_Menu_Radio_Crea = {
private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _Telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];
private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];

_Telephone_Fond ctrlSetText "MRP_icone_tel\Data\Menu_Radio\Fond_Radio_dxt5.paa";

private _position_X = 0.25;
for "_i" from 0 to 1 do {[_i,_position_X * _i] call MRPV2_fnc_MRP_Tel_Menu_Radio_Crea_Cadre_Sauvegarde_Freq;};

// Texte fréquence sauvegardé
_edit = _Telephone_Base ctrlCreate ["RscStructuredText",-1,_telephone_Cadre_Base];
_edit ctrlSetPosition [0.02,0.13,0.5,0.05];
_edit ctrlCommit 0;

private _texte = "Fréquences sauvegardées";
_edit ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_20' shadow='0' color='#ffffff' size='1.3' align='center'>%1</t>",_texte];

// Texte fréquence Principale
_edit = _Telephone_Base ctrlCreate ["RscStructuredText",-1,_telephone_Cadre_Base];
_edit ctrlSetPosition [0.02,0.43,0.5,0.05];
_edit ctrlCommit 0;

private _texte = "Fréquence principale";
_edit ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_20' shadow='0' color='#ffffff' size='1.3' align='center'>%1</t>",_texte];

// Champ Fréquence Principale
_edit = _Telephone_Base ctrlCreate ["RscEdit",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Telephone_Appli_Radio_Frequence_Principale",_edit];
_edit ctrlSetPosition [0.06,0.49,0.4,0.2];
_edit ctrlSetBackgroundColor [0,0.1,0,0.8];
_edit ctrlSetFontHeight 0.15;
_edit ctrlsettext "30-512";
_edit ctrlsettooltip "Fréquence principale";
_edit ctrlCommit 0;

_edit ctrlAddEventHandler ["KeyUp",
{params ["_displayOrControl", "_key"];
	[_displayOrControl,_key,"0123456789."] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Filtrage_Lettres;

	private _Bouton_Connecter = uiNamespace getVariable ["MRP_Telephone_Appli_Radio_Connection",controlNull];	
	private _texte = ctrltext _displayOrControl;
	private _frequence = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwFrequency;

	if (_texte isnotequalto _frequence AND {ctrltooltip _Bouton_Connecter isequalto "Se déconnecter"}) then
	{
		playSound "TFAR_rotatorPush";
		player setVariable ["tf_unable_to_use_radio", true];
		[(call TFAR_fnc_ActiveSwRadio),1,""] call TFAR_fnc_SetChannelFrequency;

		private _config_Raccourcis_TFAR = ["TFAR","SWTransmit"] call CBA_fnc_getKeybind;
		_config_Raccourcis_TFAR set [3,{[] call TFAR_fnc_hideHint;}];
		_config_Raccourcis_TFAR set [4,{[] call TFAR_fnc_hideHint;}];
		_config_Raccourcis_TFAR set [8,TRUE];

		_config_Raccourcis_TFAR call CBA_fnc_addKeybind;

		_Bouton_Connecter ctrlsettooltip "Se connecter";
		_Bouton_Connecter ctrlSetText "MRP_icone_tel\Data\Menu_Radio\Icone_Radio_Connexion_dxt5.paa";
	};
}];

_edit ctrlAddEventHandler ["EditChanged",
{params ["_control", "_newText"];
	if ("." in _newText OR {count (_newText splitstring ".") > 1}) then
	{
		if (count ((_newText splitstring ".") # 0) isequalto 1) exitWith {[_control,4] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;};
		if (count ((_newText splitstring ".") # 0) isequalto 2) exitWith {[_control,5] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;};
		if (count ((_newText splitstring ".") # 0) isequalto 3) exitWith {[_control,6] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;};
		[_control,3] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;
	} else
	{
		[_control,3] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;
	};
	
	playsound "MRP_Telephone_Touche_Appli";
}];

_edit ctrlAddEventHandler ["KeyDown",
{params ["_displayOrControl", "_key"];
	[_displayOrControl,_key,"0123456789."] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Filtrage_Lettres;	
}];

_edit ctrlAddEventHandler ["SetFocus",
{params ["_displayOrControl", "_key"];
	private _texte = ctrltext _displayOrControl;
	if (_texte isEquaLTo "30-512") then {_displayOrControl ctrlsettext "";};
}];

private _frequence_Radio = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwFrequency;
if (!isnil {_frequence_Radio} AND {_frequence_Radio isnotequalto ""}) then
{
	_edit ctrlsettext _frequence_Radio;

	if !(isnil {MRP_Telephone_Info_Dispatch}) then
	{
		private _est_Dans_Dispatch = MRP_Telephone_Info_Dispatch getOrDefault ["Principal",""] isnotequalto "";
		if (_est_Dans_Dispatch) then {_edit ctrlsettext "Dispatch";};
	};
};

// Bouton Connecter
private _Bouton_Connecter = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Telephone_Appli_Radio_Connection",_Bouton_Connecter];
_Bouton_Connecter ctrlSetPosition [0.06,0.74,0.1,0.1];
_Bouton_Connecter ctrlCommit 0;

if (_frequence_Radio in ["30-512",""]) then
{
	_Bouton_Connecter ctrlsettooltip "Se connecter";
	_Bouton_Connecter ctrlSetText "MRP_icone_tel\Data\Menu_Radio\Icone_Radio_Connexion_dxt5.paa";
} else
{
	_Bouton_Connecter ctrlsettooltip "Se déconnecter";
	_Bouton_Connecter ctrlSetText "MRP_icone_tel\Data\Menu_Radio\Icone_Radio_Deconnexion_dxt5.paa";
};

_Bouton_Connecter ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	private _ctrl_freq_Principale = uiNamespace getVariable ["MRP_Telephone_Appli_Radio_Frequence_Principale",controlNull];
	private _frequence = ctrltext _ctrl_freq_Principale;	

	if (parsenumber _frequence < 30 OR {parsenumber _frequence > 512 OR {_frequence isEqualTo "" OR {_frequence isEqualTo "30-512"}}}) exitwith 
	{
		private _texte = 'La fréquence rentrée n''est pas valide (entre "30" et "512")';
		["Appli Radio",format ["<t color='#ffffff' align='center'>%1</t>",_texte],"warning"] spawn ALF_fnc_doMsg;
	};

	private _frequence_Radio = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwFrequency;

	if ("Deconnexion" in (ctrltext _control)) then
	{
		_control ctrlSetText "MRP_icone_tel\Data\Menu_Radio\Icone_Radio_connexion_dxt5.paa";
		_control ctrlsettooltip "Se connecter";

		private _config_Raccourcis_TFAR = ["TFAR","SWTransmit"] call CBA_fnc_getKeybind;
		_config_Raccourcis_TFAR set [3,{[] call TFAR_fnc_hideHint;}];
		_config_Raccourcis_TFAR set [4,{[] call TFAR_fnc_hideHint;}];
		_config_Raccourcis_TFAR set [8,TRUE];

		_config_Raccourcis_TFAR call CBA_fnc_addKeybind;
		
		if  !(isnil {MRP_Telephone_Info_Dispatch}) then
		{				
			// _ctrl_freq_Principale ctrlsettext "";

			private _texte = MRP_Telephone_Info_Dispatch getOrDefault ["Principal",""];
			private _frequence = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwFrequency;
			private _liste_Collegues = (allplayers select {([_x] call MRPV2_fnc_MRP_NB_Service_Vers_TXT) isEquaLTo ([] call MRPV2_fnc_MRP_NB_Service_Vers_TXT)}) - [player];

			if (_liste_Collegues isnotequalto []) then {[_texte,_frequence] remoteExec ["MRPV2_fnc_MRP_Tel_Menu_Dispatch_Gestion_Nombre_Connex_Collegue",_liste_Collegues];};
			
			MRP_Telephone_Info_Dispatch deleteat "Principal";
			player setvariable ["MRP_Telephone_Info_Dispatch",MRP_Telephone_Info_Dispatch,TRUE];
		};
		player setVariable ["tf_unable_to_use_radio", true];
		[(call TFAR_fnc_ActiveSwRadio),1,""] call TFAR_fnc_SetChannelFrequency;

		// Variable pour sauvegarder le fait que le joueur a activement choisis cette fréequence, pour le script de desactivation de radio fantome
		player setvariable ["MRP_Tel_Radio_Frequence_Active",nil];
	} else
	{
		_control ctrlSetText "MRP_icone_tel\Data\Menu_Radio\Icone_Radio_Deconnexion_dxt5.paa";
		_control ctrlsettooltip "Se déconnecter";
		
		player setVariable ["tf_unable_to_use_radio", false];
		[(call TFAR_fnc_ActiveSwRadio),0] call TFAR_fnc_setSwChannel;
		[(call TFAR_fnc_ActiveSwRadio),1,_frequence] call TFAR_fnc_SetChannelFrequency;

		// Variable pour sauvegarder le fait que le joueur a activement choisis cette fréequence, pour le script de desactivation de radio fantome
		player setvariable ["MRP_Tel_Radio_Frequence_Active",_frequence];

		private _conf_Raccourcis_Transmission_Courte_Portee = ["TFAR","SWTransmit"] call CBA_fnc_getKeybind;
		_conf_Raccourcis_Transmission_Courte_Portee set [3,
		{
			if (gestureState player isequalto "mrp_menotter") exitwith {};
			if (tolower (lifeState player) in ["incapacitated"]) exitwith {};
			if (isnil {[] call TFAR_fnc_activeSwRadio}) exitwith {};

			call TFAR_fnc_onSwTangentPressed;

			private _frequence = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwFrequency;
			private _texte_Transmission_Radio = ["Transmission","RADIO",_frequence] call MRPV2_fnc_MRP_Tel_Divers_Config_Mess_Transmission_TFAR;
			[parsetext _texte_Transmission_Radio,-1] call TFAR_fnc_showHint;
		}];

		_conf_Raccourcis_Transmission_Courte_Portee set [4,
		{
			if (gestureState player isequalto "mrp_menotter") exitwith {};
			if (tolower (lifeState player) in ["incapacitated"]) exitwith {};
			if (isnil {[] call TFAR_fnc_activeSwRadio}) exitwith {};

			call TFAR_fnc_onSwTangentReleased;

			private _frequence = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwFrequency;
			private _texte_Transmission_Radio = ["Transmis avec","RADIO",_frequence] call MRPV2_fnc_MRP_Tel_Divers_Config_Mess_Transmission_TFAR;
			[parsetext _texte_Transmission_Radio,2] call TFAR_fnc_showHint;
		}];

		_conf_Raccourcis_Transmission_Courte_Portee set [8,TRUE];
		_conf_Raccourcis_Transmission_Courte_Portee call CBA_fnc_addKeybind;
	};

	playSound "TFAR_rotatorPush";

	[_control] spawn MRP_Gestion_Effet_Bouton_Appuyer;		
}];

// Bouton suppression Fréquence
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.415,0.55,0.15,0.08];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetTextColor [0.8,0.8,0.8,1];
_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_SMS\Icone_Supprimer_dxt5.paa";

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	private _Bouton_Connecter = uiNamespace getVariable ["MRP_Telephone_Appli_Radio_Connection",controlNull];
	playsound "MRP_Telephone_Touche_Appli";

	[_control] spawn MRP_Gestion_Effet_Bouton_Appuyer;

	private _ctrl_freq_Principale = uiNamespace getVariable ["MRP_Telephone_Appli_Radio_Frequence_Principale",controlNull];
	_ctrl_freq_Principale ctrlsettext "";

	private _frequence = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwFrequency;
	if (_frequence isnotequalto "") then {playSound "TFAR_rotatorPush";};
	
	if  !(isnil {MRP_Telephone_Info_Dispatch}) then
	{				
		private _texte = MRP_Telephone_Info_Dispatch getOrDefault ["Principal",""];
		private _frequence = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwFrequency;
		private _liste_Collegues = (allplayers select {([_x] call MRPV2_fnc_MRP_NB_Service_Vers_TXT) isEquaLTo ([] call MRPV2_fnc_MRP_NB_Service_Vers_TXT)}) - [player];

		if (_liste_Collegues isnotequalto []) then {[_texte,_frequence] remoteExec ["MRPV2_fnc_MRP_Tel_Menu_Dispatch_Gestion_Nombre_Connex_Collegue",_liste_Collegues];};
		
		MRP_Telephone_Info_Dispatch deleteat "Principal";
		player setvariable ["MRP_Telephone_Info_Dispatch",MRP_Telephone_Info_Dispatch,TRUE];

		// On suppr les marqueurs de suivis de collegue
		if (!isnil {MRP_Dispatch_Liste_Suivis}) then {{deleteMarkerlocal _x;} foreach MRP_Dispatch_Liste_Suivis;MRP_Dispatch_Liste_Suivis = nil;};
	};
	player setVariable ["tf_unable_to_use_radio", true];
	[(call TFAR_fnc_ActiveSwRadio),1,""] call TFAR_fnc_SetChannelFrequency;

	private _config_Raccourcis_TFAR = ["TFAR","SWTransmit"] call CBA_fnc_getKeybind;
	_config_Raccourcis_TFAR set [3,{[] call TFAR_fnc_hideHint;}];
	_config_Raccourcis_TFAR set [4,{[] call TFAR_fnc_hideHint;}];
	_config_Raccourcis_TFAR set [8,TRUE];

	_config_Raccourcis_TFAR call CBA_fnc_addKeybind;

	if (ctrltooltip _Bouton_Connecter isequalto "Se déconnecter") then
	{
		_Bouton_Connecter ctrlsettooltip "Se connecter";
		_Bouton_Connecter ctrlSetText "MRP_icone_tel\Data\Menu_Radio\Icone_Radio_Connexion_dxt5.paa";
	};
}];

// Bouton Volume +
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.25,0.72,0.08,0.1];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlsettooltip "Volume +";
_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Radio\Icone_Radio_Volume_Augmenter_dxt5.paa";

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_ctrl"];
	private _volume = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwVolume;

	if (_volume < 9) then
	{
		playSound "TFAR_rotatorPush";

		[(call TFAR_fnc_ActiveSwRadio),_volume + 1] call TFAR_fnc_setSwVolume;
		[(call TFAR_fnc_ActiveSwRadio)] call TFAR_fnc_showRadioVolume;

		[_ctrl] spawn MRP_Gestion_Effet_Bouton_Appuyer;
	};
}];

// Bouton Volume -
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.4,0.72,0.08,0.1];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlsettooltip "Volume -";
_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Radio\Icone_Radio_Volume_Diminuer.paa";

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_ctrl"];
	private _volume = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwVolume;

	if (_volume > 0) then
	{
		playSound "TFAR_rotatorPush";

		[(call TFAR_fnc_ActiveSwRadio),_volume - 1] call TFAR_fnc_setSwVolume;
		[(call TFAR_fnc_ActiveSwRadio)] call TFAR_fnc_showRadioVolume;

		[_ctrl] spawn MRP_Gestion_Effet_Bouton_Appuyer;
	};
}];

// Bouton Haut-Parleur
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.06,0.88,0.1,0.1];
_ctrlButton ctrlCommit 0;

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];

	[(call TFAR_fnc_ActiveSwRadio)] call TFAR_fnc_setSwSpeakers;
	[(call TFAR_fnc_ActiveSwRadio)] call TFAR_fnc_showRadioSpeakers;

	if ((call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwSpeakers) then
	{
		_control ctrlsettooltip "Ecouteurs";
		_control ctrlSetText "MRP_icone_tel\Data\Menu_Radio\Icone_Radio_Ecouteur_dxt5.paa";
	} else
	{
		_control ctrlsettooltip "Haut-Parleur";
		_control ctrlSetText "MRP_icone_tel\Data\Menu_Radio\Icone_Radio_Haut_Parleur_dxt5.paa";
	};

	playSound "TFAR_rotatorPush";

	[_control] spawn MRP_Gestion_Effet_Bouton_Appuyer;
}];

if ((call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwSpeakers) then
{
	_ctrlButton ctrlsettooltip "Ecouteurs";
	_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Radio\Icone_Radio_Ecouteur_dxt5.paa";
} else
{
	_ctrlButton ctrlsettooltip "Haut-Parleur";
	_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Radio\Icone_Radio_Haut_Parleur_dxt5.paa";
};

// Bouton Son à gauche
private _RscPicture = _Telephone_Base ctrlCreate ["RscPicture",-1,_telephone_Cadre_Base];
_RscPicture ctrlSetPosition [0.2,0.88,0.1,0.11];
_RscPicture ctrlSetText "MRP_icone_tel\Data\Menu_Radio\Icone_Radio_Son_Gauche_dxt5.paa";
_RscPicture ctrlSetTextColor [0.7,0.7,0.7,1];
_RscPicture ctrlCommit 0;

private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_Bouton",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.2,0.88,0.1,0.11];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlsettooltip "Oreille gauche";
_ctrlButton setvariable ["_RscPicture",_RscPicture];

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	private _telephone_Configuration = profileNamespace getvariable ["MRP_Telephone_Configuration",[]];
	private _liste_Positions_Audio = _telephone_Configuration # 10;
	private _position_Radio_Principal = _liste_Positions_Audio # 0;

	if (_position_Radio_Principal isNotEqualTo 1) then
	{
		private _RscPicture = _control getvariable "_RscPicture";

		playSound "TFAR_rotatorPush";

		[(call TFAR_fnc_ActiveSwRadio),1] call TFAR_fnc_setSwStereo;
		[(call TFAR_fnc_ActiveSwRadio)] call TFAR_fnc_showRadioVolume;

		[_RscPicture] spawn MRP_Gestion_Effet_Bouton_Appuyer;
		private _ctrlparent = ctrlparent _RscPicture;

		{
			if ("Icone_Radio_Son_" in ctrltext _x) then {_x ctrlSetTextColor [0.7,0.7,0.7,1];};
		} foreach (allControls _ctrlparent);

		_RscPicture ctrlSetTextColor [0,1,0,0.8];
		_liste_Positions_Audio set [0,1];
	};
}];

_ctrlButton ctrlAddEventHandler ["MouseEnter",
{params ["_control"];
	private _RscPicture = _control getvariable "_RscPicture";

	private _telephone_Configuration = profileNamespace getvariable ["MRP_Telephone_Configuration",[]];
	private _liste_Positions_Audio = _telephone_Configuration # 10;
	private _position_Radio_Principal = _liste_Positions_Audio # 0;

	if (_position_Radio_Principal isEqualTo 1) then
	{
		_RscPicture ctrlSetTextColor [0,1,0,1];
	} else
	{
		_RscPicture ctrlSetTextColor [1,1,1,1];
	};
}];

_ctrlButton ctrlAddEventHandler ["MouseExit",
{params ["_control"];
	private _RscPicture = _control getvariable "_RscPicture";

	private _telephone_Configuration = profileNamespace getvariable ["MRP_Telephone_Configuration",[]];
	private _liste_Positions_Audio = _telephone_Configuration # 10;
	private _position_Radio_Principal = _liste_Positions_Audio # 0;

	if (_position_Radio_Principal isEqualTo 1) then
	{
		_RscPicture ctrlSetTextColor [0,1,0,0.8];
	} else
	{
		_RscPicture ctrlSetTextColor [0.7,0.7,0.7,1];
	};
}];

private _telephone_Configuration = profileNamespace getvariable ["MRP_Telephone_Configuration",[]];
private _liste_Positions_Audio = _telephone_Configuration # 10;
private _position_Radio_Principal = _liste_Positions_Audio # 0;

if (_position_Radio_Principal isEqualTo 1) then
{
	_RscPicture ctrlSetTextColor [0,1,0,0.8];
} else
{
	_RscPicture ctrlSetTextColor [0.7,0.7,0.7,1];
};

// Bouton Son au mileu
private _RscPicture = _Telephone_Base ctrlCreate ["RscPicture",-1,_telephone_Cadre_Base];
_RscPicture ctrlSetPosition [0.32,0.88,0.1,0.11];
_RscPicture ctrlSetText "MRP_icone_tel\Data\Menu_Radio\Icone_Radio_Son_Centre_dxt5.paa";
_RscPicture ctrlSetTextColor [0.7,0.7,0.7,1];
_RscPicture ctrlCommit 0;

private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_Bouton",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.32,0.88,0.1,0.11];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlsettooltip "Gauche et droite";
_ctrlButton setvariable ["_RscPicture",_RscPicture];

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	private _telephone_Configuration = profileNamespace getvariable ["MRP_Telephone_Configuration",[]];
	private _liste_Positions_Audio = _telephone_Configuration # 10;
	private _position_Radio_Principal = _liste_Positions_Audio # 0;

	if (_position_Radio_Principal isNotEqualTo 0) then
	{
		private _RscPicture = _control getvariable "_RscPicture";

		playSound "TFAR_rotatorPush";

		[(call TFAR_fnc_ActiveSwRadio),0] call TFAR_fnc_setSwStereo;
		[(call TFAR_fnc_ActiveSwRadio)] call TFAR_fnc_showRadioVolume;

		[_RscPicture] spawn MRP_Gestion_Effet_Bouton_Appuyer;

		private _ctrlparent = ctrlparent _RscPicture;

		{
			if ("Icone_Radio_Son_" in ctrltext _x) then
			{
				_x ctrlSetTextColor [0.7,0.7,0.7,1];
			};
		} foreach (allControls _ctrlparent);

		_RscPicture ctrlSetTextColor [0,1,0,0.8];
		_liste_Positions_Audio set [0,0];
	};
}];

_ctrlButton ctrlAddEventHandler ["MouseEnter",
{params ["_control"];
	private _RscPicture = _control getvariable "_RscPicture";

	private _telephone_Configuration = profileNamespace getvariable ["MRP_Telephone_Configuration",[]];
	private _liste_Positions_Audio = _telephone_Configuration # 10;
	private _position_Radio_Principal = _liste_Positions_Audio # 0;

	if (_position_Radio_Principal isEqualTo 0) then
	{
		_RscPicture ctrlSetTextColor [0,1,0,1];
	} else
	{
		_RscPicture ctrlSetTextColor [1,1,1,1];
	};
}];

_ctrlButton ctrlAddEventHandler ["MouseExit",
{params ["_control"];
	private _RscPicture = _control getvariable "_RscPicture";

	private _telephone_Configuration = profileNamespace getvariable ["MRP_Telephone_Configuration",[]];
	private _liste_Positions_Audio = _telephone_Configuration # 10;
	private _position_Radio_Principal = _liste_Positions_Audio # 0;

	if (_position_Radio_Principal isEqualTo 0) then
	{
		_RscPicture ctrlSetTextColor [0,1,0,0.8];
	} else
	{
		_RscPicture ctrlSetTextColor [0.7,0.7,0.7,1];
	};
}];

if (_position_Radio_Principal isEqualTo 0) then
{
	_RscPicture ctrlSetTextColor [0,1,0,0.8];
} else
{
	_RscPicture ctrlSetTextColor [0.7,0.7,0.7,1];
};

// Bouton Son à droite
private _RscPicture = _Telephone_Base ctrlCreate ["RscPicture",-1,_telephone_Cadre_Base];
_RscPicture ctrlSetPosition [0.43,0.88,0.1,0.11];
_RscPicture ctrlSetText "MRP_icone_tel\Data\Menu_Radio\Icone_Radio_Son_Droite_dxt5.paa";
_RscPicture ctrlSetTextColor [0.7,0.7,0.7,1];
_RscPicture ctrlCommit 0;

private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_Bouton",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.43,0.88,0.1,0.11];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlsettooltip "Oreille droite";
_ctrlButton setvariable ["_RscPicture",_RscPicture];

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	private _telephone_Configuration = profileNamespace getvariable ["MRP_Telephone_Configuration",[]];
	private _liste_Positions_Audio = _telephone_Configuration # 10;
	private _position_Radio_Principal = _liste_Positions_Audio # 0;

	if (_position_Radio_Principal isNotEqualTo 2) then
	{
		private _RscPicture = _control getvariable "_RscPicture";
		playSound "TFAR_rotatorPush";

		[(call TFAR_fnc_ActiveSwRadio),2] call TFAR_fnc_setSwStereo;
		[(call TFAR_fnc_ActiveSwRadio)] call TFAR_fnc_showRadioVolume;

		[_RscPicture] spawn MRP_Gestion_Effet_Bouton_Appuyer;

		private _ctrlparent = ctrlparent _RscPicture;

		{
			if ("Icone_Radio_Son_" in ctrltext _x) then
			{
				_x ctrlSetTextColor [0.7,0.7,0.7,1];
			};
		} foreach (allControls _ctrlparent);

		_RscPicture ctrlSetTextColor [0,1,0,0.8];
		_liste_Positions_Audio set [0,2];
	};
}];

_ctrlButton ctrlAddEventHandler ["MouseEnter",
{params ["_control"];
	private _RscPicture = _control getvariable "_RscPicture";

	private _telephone_Configuration = profileNamespace getvariable ["MRP_Telephone_Configuration",[]];
	private _liste_Positions_Audio = _telephone_Configuration # 10;
	private _position_Radio_Principal = _liste_Positions_Audio # 0;

	if (_position_Radio_Principal isEqualTo 2) then
	{
		_RscPicture ctrlSetTextColor [0,1,0,1];
	} else
	{
		_RscPicture ctrlSetTextColor [1,1,1,1];
	};
}];

_ctrlButton ctrlAddEventHandler ["MouseExit",
{params ["_control"];
	private _RscPicture = _control getvariable "_RscPicture";

	private _telephone_Configuration = profileNamespace getvariable ["MRP_Telephone_Configuration",[]];
	private _liste_Positions_Audio = _telephone_Configuration # 10;
	private _position_Radio_Principal = _liste_Positions_Audio # 0;

	if (_position_Radio_Principal isEqualTo 2) then
	{
		_RscPicture ctrlSetTextColor [0,1,0,0.8];
	} else
	{
		_RscPicture ctrlSetTextColor [0.7,0.7,0.7,1];
	};
}];

if (_position_Radio_Principal isEqualTo 2) then
{
	_RscPicture ctrlSetTextColor [0,1,0,0.8];
} else
{
	_RscPicture ctrlSetTextColor [0.7,0.7,0.7,1];
};

private _frequence_Principale = uiNamespace getVariable ["MRP_Telephone_Appli_Radio_Frequence_Principale",controlNull];
ctrlsetfocus _ctrlButton;

// Bouton retour menu principal
[] call MRPV2_fnc_MRP_Tel_Menu_Principal_Action_Retour;

TRUE
// };