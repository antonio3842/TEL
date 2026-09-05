// MRPV2_fnc_MRP_Tel_Menu_SMS_Lecture = {
private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _Telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];
private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];

_Telephone_Fond ctrlSetText "MRP_icone_tel\Data\Menu_SMS\Menu_SMS_Discussion_Vide_dxt5.paa";

// Bouton retour sms en haut a gauche
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.005,0.125,0.12,0.04];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetTextColor [0.8,0.8,0.8,1];
_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_SMS\Menu_SMS_Fleche_Retour_dxt5.paa";

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	[_control] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;

	playsound "MRP_Telephone_Touche_Appli";

	[_control] spawn
	{params ["_control"];
		sleep 0.2;
		MRP_Telephone_Gestion_Numero_Interne = nil;
		[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
		[] call MRPV2_fnc_MRP_Tel_Menu_SMS_Crea;
	};
}];

// Bouton supprimer sms en haut a droite
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.405,0.12,0.11,0.05];
_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Contact\Icone_Supprimer_dxt5.paa";
_ctrlButton ctrlSetTextColor [0.8,0.8,0.8,1];
_ctrlButton ctrlCommit 0;

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	[_control] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;

	playsound "MRP_Telephone_Touche_Appli";

	[_control] spawn
	{params ["_control"];
		sleep 0.2;
		[] call MRPV2_fnc_MRP_Tel_Menu_SMS_Action_Supprimer;
	};
}];

// Texte Contact
private _edit = _Telephone_Base ctrlCreate ["MRP_Structured_Text",-1,_telephone_Cadre_Base];
_edit ctrlSetPosition [0,0.163,0.56,0.075];
_edit ctrlCommit 0;

private _intituler_Identifiant = [MRP_Telephone_Gestion_Numero_Interne] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Intituler;
_edit ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_46' shadow='0' color='#000000' size='1.5' align='center'>%1</t>",_intituler_Identifiant];

// Bouton Contact
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.25,0.09,0.07,0.085];
_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_SMS\Icone_Contact_dxt5.paa";
_ctrlButton ctrlSetTextColor [0.9,0.9,0.9,1];
_ctrlButton ctrlCommit 0;

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	[_control] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;

	playsound "MRP_Telephone_Touche_Appli";

	[_control] spawn
	{params ["_control"];
		sleep 0.2;
		[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;

		private _liste_Contact = profileNamespace getvariable ["MRP_Telephone_Liste_Contact",createhashmap];
		private _info_Contact = _liste_Contact getOrDefault [MRP_Telephone_Gestion_Numero_Interne,[]];

		if (_info_Contact isEqualTo []) then
		{
			[] call MRPV2_fnc_MRP_Tel_Menu_Contact_Modif_Crea;
		} else
		{
			[] call MRPV2_fnc_MRP_Tel_Menu_Contact_Lecture_Fiche;
		};
	};
}];

// Contenus SMS
private _ctrl_SMS = _Telephone_Base ctrlCreate ["RscControlsGroupNoScrollbars",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_menu_SMS_Lecture_Conteneur_SMS",_ctrl_SMS];
_ctrl_SMS ctrlSetPosition [0.03,0.225,0.5,0.99];
_ctrl_SMS ctrlCommit 0;

private _telephone_Liste_SMS = profileNamespace getvariable ["MRP_Telephone_Liste_SMS",createhashmap];
private _info_SMS_Contact = _telephone_Liste_SMS getOrDefault [MRP_Telephone_Gestion_Numero_Interne,[]];

if (count _info_SMS_Contact > 420) then
{
	reverse _info_SMS_Contact;
	_info_SMS_Contact resize 400;
	reverse _info_SMS_Contact;
};

Date_Enregistrer = "";
Heure_Enregistrer = "";
Nombre_Cadre_Message_Simple = 0;
Nombre_Cadre_Message_Multiple = 0;
Nombre_Espace_Entre_Message = 1;
MRP_Position_Hauteur_Cadre = 0;

{
	private _liste_SMS = _x;

	private _SMS_Placer_A_Gauche = _liste_SMS # 0;
	private _message = _liste_SMS # 1;
	private _liste_Date = _liste_SMS # 2;

	[_SMS_Placer_A_Gauche,_message,_liste_Date] call MRPV2_fnc_MRP_Tel_Menu_SMS_Crea_Cadre;
} foreach _info_SMS_Contact;

private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_menu_SMS_Lecture_Boutton_Ecriture_Message",_ctrlButton];
_ctrlButton ctrlSetPosition [0,1.2,0.6,0.1];
_ctrlButton ctrlSetTextColor [0.8,0.8,0.8,1];
_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_SMS\Menu_SMS_Icone_Bouton_Message_dxt5.paa";
_ctrlButton ctrlCommit 0;

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{
	playsound "MRP_Telephone_Touche_Appli";

	private _liste_Configuration = profileNamespace getvariable ["MRP_Telephone_Configuration",[]];
	private _mode_Avion = _liste_Configuration # 0;

	if (_mode_Avion OR (ALF_Forfait < 1)) exitwith {};

	private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
	private _menu_SMS_Lecture_Conteneur_SMS = uiNamespace getVariable ["MRP_menu_SMS_Lecture_Conteneur_SMS",controlNull];
	private _lecture_Boutton_Ecriture_Message = uiNamespace getVariable ["MRP_menu_SMS_Lecture_Boutton_Ecriture_Message",controlNull];
	[_lecture_Boutton_Ecriture_Message] spawn {params ["_lecture"]; ctrldelete _lecture};

	private  _vitesse_Animation = 0.5;

	_menu_SMS_Lecture_Conteneur_SMS ctrlSetPosition [0.03,0.226,0.5,0.62];
	_menu_SMS_Lecture_Conteneur_SMS ctrlCommit _vitesse_Animation;

	private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];

	private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
	_ctrlButton ctrlSetPosition [0.42,1.2,0.06,0.05];
	_ctrlButton ctrlSetTextColor [0.8,0.8,0.8,1];
	_ctrlButton ctrlSetfade 1;
	_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_SMS\Icone_Envoi_Message_dxt5.paa";
	_ctrlButton ctrlCommit 0;

	_ctrlButton ctrlSetPosition [0.42,0.85,0.06,0.05];
	_ctrlButton ctrlSetfade 0;
	_ctrlButton ctrlCommit _vitesse_Animation;

	// Envoie message
	_ctrlButton ctrlAddEventHandler ["ButtonClick",
	{params ["_control"];
		[_control] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;

		playsound "MRP_Telephone_Touche_Appli";

		[_control] spawn
		{params ["_control"];
			sleep 0.2;
			if (isnil {MRP_Tel_Spam_SMS}) then
			{
				MRP_Tel_Spam_SMS = "";
				[] call MRPV2_fnc_MRP_Tel_Menu_SMS_Validation_SMS;

				[] spawn {sleep 1; MRP_Tel_Spam_SMS = nil;};
			};
		};
	}];

	// Cadre Fond Ecriture SMS
	private _cadre_Ecriture = _Telephone_Base ctrlCreate ["RscEditMulti",-1,_telephone_Cadre_Base];
	uiNamespace setVariable ["MRP_menu_SMS_Lecture_Cadre_Ecriture",_cadre_Ecriture];
	_cadre_Ecriture ctrlSetPosition [0.18,1.16,0.3,0.056];
	_cadre_Ecriture ctrlSetBackgroundColor [0,0,0,0];
	_cadre_Ecriture ctrlSetFont "SFUIDisplay_46";
	_cadre_Ecriture ctrlSetTextColor [0,0,0,1];
	_cadre_Ecriture ctrlSetFontHeight 0.05;
	_cadre_Ecriture ctrlSetFade 1;
	_cadre_Ecriture ctrlCommit 0;

	_cadre_Ecriture ctrlSetPosition [0.04,0.91,0.476,0.38];
	_cadre_Ecriture ctrlSetFade 0;
	_cadre_Ecriture ctrlSetBackgroundColor [0,0,0,0.1];
	_cadre_Ecriture ctrlCommit _vitesse_Animation;

	ctrlSetFocus _cadre_Ecriture;

	private _temps_animation = time + 1;

	_cadre_Ecriture ctrlAddEventHandler ["KeyUp",
	{params ["_displayOrControl", "_key"];
		[_displayOrControl,150] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;
	}];

	_cadre_Ecriture ctrlAddEventHandler ["KeyDown",
	{params ["_displayOrControl","_key","_shift"];
		[_displayOrControl,150] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;

		if (_key in [28,156] AND {!_shift AND {isnil {MRP_Tel_Spam_SMS}}}) then
		{
			MRP_Tel_Spam_SMS = "";
			[] call MRPV2_fnc_MRP_Tel_Menu_SMS_Validation_SMS;

			[] spawn {sleep 1; MRP_Tel_Spam_SMS = nil;};
		};
	}];

	[
		{params ["_args", "_pfID"];
			_args params ["_menu_SMS_Lecture_Conteneur_SMS","_temps_animation"];

			if (time > _temps_animation) exitwith {[_pfID] call CBA_fnc_removePerFrameHandler;};

			_menu_SMS_Lecture_Conteneur_SMS ctrlSetScrollValues [1,-1];
		},
		0,
		[_menu_SMS_Lecture_Conteneur_SMS,_temps_animation]
	] call CBA_fnc_addPerFrameHandler;
}];

[_ctrl_SMS] spawn
{params ["_ctrl_SMS"];
	sleep 0.01;

	_ctrl_SMS ctrlSetScrollValues [1,-1];
};

["SMS",MRP_Telephone_Gestion_Numero_Interne] call MRPV2_fnc_MRP_Tel_Menu_SMS_Gestion_Nombre_SMS;

// Bouton retour menu principal
[] call MRPV2_fnc_MRP_Tel_Menu_Principal_Action_Retour;

TRUE
// };