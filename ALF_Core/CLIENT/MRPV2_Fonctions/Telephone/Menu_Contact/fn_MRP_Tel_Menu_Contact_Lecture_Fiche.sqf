// MRPV2_fnc_MRP_Tel_Menu_Contact_Lecture_Fiche = {
private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _Telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];
private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];

_Telephone_Fond ctrlSetText "MRP_Telephones\Data\Menu_Contact\Menu_Contact_Fiche_dxt5.paa";

// Bouton menu contact
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.03,0.07,0.15,0.1];
_ctrlButton ctrlSetText "MRP_Telephones\Data\Menu_Contact\Icone_Contact.paa";
_ctrlButton ctrlSetTextColor [0.8,0.8,0.8,1];
_ctrlButton ctrlCommit 0;

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	[_control] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;

	playsound "MRP_Telephone_Touche_Appli";

	[] spawn
	{
		sleep 0.2;

		MRP_Telephone_Gestion_Numero_Interne = nil;

		[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
		[] call MRPV2_fnc_MRP_Tel_Menu_Contact_Crea;
	};
}];

// Bouton modifier contact en haut a droite
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.4,0.07,0.15,0.1];
_ctrlButton ctrlSetText "MRP_Telephones\Data\Menu_Contact\Icone_Modifier.paa";
_ctrlButton ctrlSetTextColor [0.8,0.8,0.8,1];
_ctrlButton ctrlCommit 0;

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	[_control] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;

	playsound "MRP_Telephone_Touche_Appli";

	[] spawn
	{
		sleep 0.2;

		[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
		[] call MRPV2_fnc_MRP_Tel_Menu_Contact_Modif_Crea;
	};
}];

// Bouton supprimer contact
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.405,0.19,0.11,0.05];
_ctrlButton ctrlSetText "MRP_Telephones\Data\Menu_Contact\Icone_Supprimer_dxt5.paa";
_ctrlButton ctrlSetTextColor [0.8,0.8,0.8,1];
_ctrlButton ctrlCommit 0;

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	[_control] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;

	playsound "MRP_Telephone_Touche_Appli";

	[] spawn
	{
		sleep 0.2;

		["Supprimer"] call MRPV2_fnc_MRP_Tel_Menu_Contact_Lecture_Fiche_Gestion_Contact;
	};
}];

// Bouton bloquer ou débloquer contact
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Telephone_Menu_Contact_Bouton_Bloquage",_ctrlButton];
_ctrlButton ctrlSetPosition [0.035,0.19,0.11,0.05];

private _liste_Contact = profileNamespace getvariable ["MRP_Telephone_Liste_Contact",createhashmap];
private _info_Contact = _liste_Contact getordefault [MRP_Telephone_Gestion_Numero_Interne,[]];
private _contact_Est_Bloquer = _info_Contact # 5;

if (_contact_Est_Bloquer) then
{
	_ctrlButton ctrlSetText "MRP_Telephones\Data\Menu_Contact\Icone_Debloquer_dxt5.paa";
	_ctrlButton ctrlSetPosition [0.045,0.19,0.11,0.05];
} else
{
	_ctrlButton ctrlSetText "MRP_Telephones\Data\Menu_Contact\Icone_Bloquer_dxt5.paa";
	_ctrlButton ctrlSetPosition [0.035,0.19,0.11,0.05];
};

_ctrlButton ctrlSetTextColor [0.8,0.8,0.8,1];
_ctrlButton ctrlCommit 0;

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	[_control] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;

	playsound "MRP_Telephone_Touche_Appli";

	[] spawn
	{
		sleep 0.2;

		["Bloquer"] call MRPV2_fnc_MRP_Tel_Menu_Contact_Lecture_Fiche_Gestion_Contact;
	};
}];

// Initiale Prénom Nom
private _edit = _Telephone_Base ctrlCreate ["MRP_Structured_Text",-1,_telephone_Cadre_Base];
_edit ctrlSetPosition [0.22,0.16,0.12,0.1];
_edit ctrlCommit 0;

private _liste_Contact = profileNamespace getvariable ["MRP_Telephone_Liste_Contact",createhashmap];
private _info_Contact = _liste_Contact getOrDefault [MRP_Telephone_Gestion_Numero_Interne,[]];

private _prenom = _info_Contact # 0;
private _nom = _info_Contact # 1;

private _initiale = "";

{
	if (_x isNotEqualTo "") then
	{
		private _premiere_Lettre = toUpper ((_x splitString "") # 0);

		_initiale = _initiale + _premiere_Lettre;
	};
} foreach [_prenom,_nom];

_edit ctrlSetStructuredText parsetext format ["<t font='SFUIDisplay_46' color='#ffffff' shadow='0' size='2' align='center'>%1</t>",_initiale];

// Prénom Nom
private _edit = _Telephone_Base ctrlCreate ["MRP_Structured_Text",-1,_telephone_Cadre_Base];
_edit ctrlSetPosition [0.039,0.28,0.48,0.08];
_edit ctrlCommit 0;
_edit ctrlSetStructuredText parsetext format ["<t font='SFUIDisplay_46' color='#000000' shadow='0' size='2' align='center'>%1</t>",_prenom + " " +_nom];

// Bouton vers Message
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.04,0.37,0.105,0.09];
_ctrlButton ctrlCommit 0;

if (MRP_Telephone_Gestion_Numero_Interne isEqualTo "") then
{
	_ctrlButton ctrlSetText "MRP_Telephones\Data\Menu_Contact\Icone_Message_Gris_dxt5.paa";
	_ctrlButton ctrlSetTextColor [1,1,1,1];
	_ctrlButton ctrlenable FALSE;
} else
{
	_ctrlButton ctrlSetText "MRP_Telephones\Data\Menu_Contact\Icone_Message_Bleu_dxt5.paa";
	_ctrlButton ctrlSetTextColor [0.8,0.8,0.8,1];
};

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	[_control] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;

	playsound "MRP_Telephone_Touche_Appli";

	[] spawn
	{
		sleep 0.2;

		[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
		[] call MRPV2_fnc_MRP_Tel_Menu_SMS_Lecture;
	};
}];

// Bouton vers Appel
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.16,0.37,0.105,0.09];
_ctrlButton ctrlCommit 0;

private _liste_Configuration = profileNamespace getvariable ["MRP_Telephone_Configuration",[]];
private _mode_Avion = _liste_Configuration # 0;

if (MRP_Telephone_Gestion_Numero_Interne isEqualTo "" OR {_mode_Avion} OR {ALF_Forfait < 1}) then
{
	_ctrlButton ctrlSetText "MRP_Telephones\Data\Menu_Contact\Icone_Appel_Gris_dxt5.paa";
	_ctrlButton ctrlSetTextColor [1,1,1,1];
	_ctrlButton ctrlenable FALSE;
} else
{
	_ctrlButton ctrlSetText "MRP_Telephones\Data\Menu_Contact\Icone_Appel_Bleu_dxt5.paa";
	_ctrlButton ctrlSetTextColor [0.8,0.8,0.8,1];
};

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	[_control] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;

	playsound "MRP_Telephone_Touche_Appli";

	[] spawn
	{
		sleep 0.2;
		MRP_Telephone_Numero_Appel = MRP_Telephone_Gestion_Numero_Interne;

		private _Telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];
		private _fond = ctrltext _Telephone_Fond;
		uiNamespace setVariable ["MRP_Telephone_Fond_Menu_En_Attente",_fond];

		[] call MRPV2_fnc_MRP_Tel_Menu_Appel_Exped_Crea;
		[player] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Etat_Joueur_En_Appel;
	};
}];

// Intitulé Numéro de téléphone
_edit = _Telephone_Base ctrlCreate ["MRP_Structured_Text",-1,_telephone_Cadre_Base];
_edit ctrlSetPosition [0.04,0.48,0.45,0.3];
_edit ctrlCommit 0;
_edit ctrlSetStructuredText parsetext format ["<t font='SFUIDisplay_20' color='#000000' shadow='0' size='1.2' align='left'>%1</t>","Téléphone :"];

// Numéro de téléphone
_edit = _Telephone_Base ctrlCreate ["MRP_Structured_Text",-1,_telephone_Cadre_Base];
_edit ctrlSetPosition [0.04,0.53,0.45,0.3];
_edit ctrlCommit 0;

if (MRP_Telephone_Gestion_Numero_Interne isEqualTo "") then
{
	_edit ctrlSetStructuredText parsetext format ["<t font='SFUIDisplay_20' color='#0062ce' shadow='0' size='1.2' align='left'>%1</t>","Vide"];
} else
{
	private _numero = MRP_Telephone_Gestion_Numero_Interne;

	_numero = _numero insert [2, " "];
	_numero = _numero insert [5, " "];
	_numero = _numero insert [8, " "];
	_numero = _numero insert [11, " "];

	_edit ctrlSetStructuredText parsetext format ["<t font='SFUIDisplay_20' color='#0062ce' shadow='0' size='1.2' align='left'>%1</t>",_numero];
};

// Intitulé Entreprise
_edit = _Telephone_Base ctrlCreate ["MRP_Structured_Text",-1,_telephone_Cadre_Base];
_edit ctrlSetPosition [0.04,0.61,0.45,0.3];
_edit ctrlCommit 0;

_edit ctrlSetStructuredText parsetext format ["<t font='SFUIDisplay_20' color='#000000' shadow='0' size='1.2' align='left'>%1</t>","Entreprise :"];

// Entreprise
_edit = _Telephone_Base ctrlCreate ["MRP_Structured_Text",-1,_telephone_Cadre_Base];
_edit ctrlSetPosition [0.04,0.65,0.45,0.05];
_edit ctrlCommit 0;

if ((_info_Contact # 2) isEqualTo "") then
{
	_edit ctrlSetStructuredText parsetext format ["<t font='SFUIDisplay_20' color='#0062ce' shadow='0' size='1.2' align='left'>%1</t>","Vide"];
} else
{
	_edit ctrlSetStructuredText parsetext format ["<t font='SFUIDisplay_20' color='#0062ce' shadow='0' size='1.2' align='left'>%1</t>",(_info_Contact # 2)];
};

// Intitulé Mail
_edit = _Telephone_Base ctrlCreate ["MRP_Structured_Text",-1,_telephone_Cadre_Base];
_edit ctrlSetPosition [0.04,0.74,0.45,0.3];
_edit ctrlCommit 0;
_edit ctrlSetStructuredText parsetext format ["<t font='SFUIDisplay_20' color='#000000' shadow='0' size='1.2' align='left'>%1</t>","Mail :"];

// Adresse mail
_edit = _Telephone_Base ctrlCreate ["MRP_Structured_Text",-1,_telephone_Cadre_Base];
_edit ctrlSetPosition [0.04,0.78,0.45,0.05];
_edit ctrlCommit 0;

if ((_info_Contact # 3) isEqualTo "") then
{
	_edit ctrlSetStructuredText parsetext format ["<t font='SFUIDisplay_20' color='#0062ce' shadow='0' size='1.2' align='left'>%1</t>","Vide"];
} else
{
	_edit ctrlSetStructuredText parsetext format ["<t font='SFUIDisplay_20' color='#0062ce' shadow='0' size='1.2' align='left'>%1</t>",(_info_Contact # 3)];
};

// Intitulé Notes
_edit = _Telephone_Base ctrlCreate ["MRP_Structured_Text",-1,_telephone_Cadre_Base];
_edit ctrlSetPosition [0.04,0.88,0.45,0.3];
_edit ctrlCommit 0;
_edit ctrlSetStructuredText parsetext format ["<t font='SFUIDisplay_20' color='#000000' shadow='0' size='1.2' align='left'>%1</t>","Notes :"];

// Notes
_edit = _Telephone_Base ctrlCreate ["MRP_RscTextMulti",-1,_telephone_Cadre_Base];
_edit ctrlSetPosition [0.04,0.92,0.45,0.3];
_edit ctrlSetshadow 0;
_edit ctrlSetFont "SFUIDisplay_20";
_edit ctrlSetTextColor [0,0.388,0.808,1];
_edit ctrlCommit 0;

if ((_info_Contact # 4) isEqualTo "") then
{
	_edit ctrlsettext "Vide";
} else
{
	_edit ctrlsettext (_info_Contact # 4);
};

// Bouton retour menu principal
[] call MRPV2_fnc_MRP_Tel_Menu_Principal_Action_Retour;

TRUE
// };