// MRPV2_fnc_MRP_Tel_Menu_Nouveau_SMS_Crea = {
private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _Telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];
private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];

_Telephone_Fond ctrlSetText "MRP_Telephones\Data\Menu_SMS\Menu_SMS_ecrire_dxt5.paa";

// Bouton retour sms en haut a gauche
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.005,0.125,0.12,0.04];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetTextColor [0.8,0.8,0.8,1];
_ctrlButton ctrlSetText "MRP_Telephones\Data\Menu_SMS\Menu_SMS_Fleche_Retour_dxt5.paa";

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	[_control] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;
		
	playsound "MRP_Telephone_Touche_Appli";

	[] spawn
	{
		sleep 0.2;
		private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];
		_telephone_Cadre_Base ctrlRemoveAllEventHandlers "MouseButtonClick";

		[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
		[] call MRPV2_fnc_MRP_Tel_Menu_SMS_Crea;
	};
}];

// Bouton suppression contact destinataire
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.43,0.205,0.12,0.05];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetTextColor [0.8,0.8,0.8,1];
_ctrlButton ctrlSetText "MRP_Telephones\Data\Menu_SMS\Icone_Supprimer_dxt5.paa";

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	[_control] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;

	playsound "MRP_Telephone_Touche_Appli";

	[] spawn
	{
		sleep 0.2;
		private _champ_Recherche = uiNamespace getVariable ["MRPV2_fnc_MRP_Tel_Menu_Nouveau_SMS_Crea_Champs_Recherche",controlNull];
		_champ_Recherche ctrlSetText "";

		private _champ_Recherche = uiNamespace getVariable ["MRPV2_fnc_MRP_Tel_Menu_Nouveau_SMS_Crea_Champs_Recherche",controlNull];
		private _ctrlButton = uiNamespace getVariable ["MRPV2_fnc_MRP_Tel_Menu_Nouveau_SMS_Crea_Bouton_Envoyer",controlNull];

		if (!(ctrltext _champ_Recherche in ["","Destinataire"]) AND {ctrltext _displayOrControl isNotEqualTo ""}) then
		{
			_ctrlButton ctrlshow TRUE;
		} else
		{
			_ctrlButton ctrlshow FALSE;
		};

		private _tv = uiNamespace getVariable ["MRP_menu_SMS_Action_Creation_Liste_Tree_Liste",controlnull];

		if (_tv isnotEqualTo controlNull) then
		{
			private _fond = uiNamespace getVariable ["MRP_menu_SMS_Action_Creation_Liste_Fond",controlnull];

			ctrlDelete _tv;
			ctrlDelete _fond;
		};
	};
}];

// Champ recherche
private _edit = _Telephone_Base ctrlCreate ["MRP_Telephone_RscEdit_Cadre_Invisible",645,_telephone_Cadre_Base];
uiNamespace setVariable ["MRPV2_fnc_MRP_Tel_Menu_Nouveau_SMS_Crea_Champs_Recherche",_edit];
_edit ctrlSetPosition [0.085,0.2,0.32,0.0556];
_edit ctrlSetFont "SFUIDisplay_46";
_edit ctrlSetFontHeight 0.05;
_edit ctrlSetText "Destinataire";
_edit ctrlSetTextColor [0,0,0,0.3];
_edit ctrlCommit 0;

_edit ctrlAddEventHandler ["KeyDown",
{params ["_displayOrControl","_key"];
	[_displayOrControl,10] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;
}];

_edit ctrlAddEventHandler ["KeyUp",
{
	[_displayOrControl,10] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;
	[] call MRPV2_fnc_MRP_Tel_Menu_Nouveau_SMS_Crea_Liste;
}];

_edit ctrlAddEventHandler ["SetFocus",
{params ["_control"];
	private _champ_Recherche = uiNamespace getVariable ["MRPV2_fnc_MRP_Tel_Menu_Nouveau_SMS_Crea_Champs_Recherche",controlNull];
	private _texte_Champ_Recherche = ctrltext _champ_Recherche;

	if (_texte_Champ_Recherche isEqualTo "Destinataire") then 
	{
		_control ctrlSetText "";
		_control ctrlSetTextColor [0,0,0,1];
	};

	[] call MRPV2_fnc_MRP_Tel_Menu_Nouveau_SMS_Crea_Liste;
}];

_telephone_Cadre_Base ctrlAddEventHandler ["MouseButtonClick",
{params ["_control", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];
	[_xPos,_yPos] spawn
	{params ["_xPos","_yPos"];
		private _fond = uiNamespace getVariable ["MRP_menu_SMS_Action_Creation_Liste_Fond",controlnull];
		private _longueur_Fond = ctrlPosition _fond # 3;

		private _hors_Cadre_X = _xPos <= 0.69 OR {_xPos > 1.165};
		private _hors_Cadre_Y = _yPos <= 0.2 OR {_yPos > (0.255 + _longueur_Fond)};

		private _permission_Joueur = [] call MRPV2_fnc_MRP_NB_Service_Vers_TXT;

		if (_permission_Joueur isNotEqualTo "CIV") then
		{
			_hors_Cadre_X = _xPos <= 0.68 OR {_xPos > 1.165};
			_hors_Cadre_Y = _yPos <= 0.12 OR {_yPos > (0.22 + _longueur_Fond)};
		};

		private _tv = uiNamespace getVariable ["MRP_menu_SMS_Action_Creation_Liste_Tree_Liste",controlnull];
		private _champ_Recherche = uiNamespace getVariable ["MRPV2_fnc_MRP_Tel_Menu_Nouveau_SMS_Crea_Champs_Recherche",controlNull];
		private _champ_SMS = uiNamespace getVariable ["MRPV2_fnc_MRP_Tel_Menu_Nouveau_SMS_Crea_Champs_Message",displayNull];

		if (_tv isnotequalto controlnull AND {_hors_Cadre_X OR {_hors_Cadre_Y}}) then
		{
			ctrlDelete _tv;
			ctrlDelete _fond;
		};

		private _ctrlButton = uiNamespace getVariable ["MRPV2_fnc_MRP_Tel_Menu_Nouveau_SMS_Crea_Bouton_Envoyer",controlNull];

		if (!(ctrltext _champ_Recherche in ["","Destinataire"]) AND {ctrltext _champ_SMS isNotEqualTo ""}) then
		{
			_ctrlButton ctrlshow TRUE;
		} else
		{
			_ctrlButton ctrlshow FALSE;
		};
	};
}];

// Champ SMS
private _champs_Message = _Telephone_Base ctrlCreate ["RscEditMulti",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRPV2_fnc_MRP_Tel_Menu_Nouveau_SMS_Crea_Champs_Message",_champs_Message];
_champs_Message ctrlSetPosition [0.04,0.27,0.477,0.58];
_champs_Message ctrlSetBackgroundColor [0,0,0,0.1];
_champs_Message ctrlSetFontHeight 0.06;
_champs_Message ctrlSetFont "SFUIDisplay_46";
_champs_Message ctrlSetTextColor [0,0,0,1];
_champs_Message ctrlCommit 0;

_champs_Message ctrlAddEventHandler ["Keyup",
{params ["_displayOrControl","_key"];
	[_displayOrControl,110] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;
}];

_champs_Message ctrlAddEventHandler ["KeyDown",
{params ["_displayOrControl","_key"];
	[_displayOrControl,110] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;
}];

_champs_Message ctrlAddEventHandler ["KeyUp",
{params ["_displayOrControl", "_key"];
	private _champ_Recherche = uiNamespace getVariable ["MRPV2_fnc_MRP_Tel_Menu_Nouveau_SMS_Crea_Champs_Recherche",controlNull];
	private _ctrlButton = uiNamespace getVariable ["MRPV2_fnc_MRP_Tel_Menu_Nouveau_SMS_Crea_Bouton_Envoyer",controlNull];

	if (!(ctrltext _champ_Recherche in ["","Destinataire"]) AND {ctrltext _displayOrControl isNotEqualTo ""}) then
	{
		_ctrlButton ctrlshow TRUE;
	} else
	{
		_ctrlButton ctrlshow FALSE;
	};
}];

// Bouton Envoyer
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRPV2_fnc_MRP_Tel_Menu_Nouveau_SMS_Crea_Bouton_Envoyer",_ctrlButton];
_ctrlButton ctrlSetPixelPrecision 2;
_ctrlButton ctrlSetPosition [0.457,0.857,0.04,0.044];
_ctrlButton ctrlSetTextColor [0.9,0.9,0.9,1];
_ctrlButton ctrlSetText "MRP_Telephones\Data\Menu_SMS\Icone_Envoi_Message_dxt5.paa";
_ctrlButton ctrlshow FALSE;
_ctrlButton ctrlCommit 0;

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{
	[] call MRPV2_fnc_MRP_Tel_Menu_Nouveau_SMS_Action_Validation_SMS;
}];

// Bouton retour menu principal
[] call MRPV2_fnc_MRP_Tel_Menu_Principal_Action_Retour;

TRUE
// };