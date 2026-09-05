// MRPV2_fnc_MRP_Tel_Menu_Appel_Crea = {
private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _Telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];
private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];

_Telephone_Fond ctrlSetText "MRP_icone_tel\Data\Menu_Appel\Menu_appel.paa";

// Cadran numéro
_edit = _Telephone_Base ctrlCreate ["MRP_Structured_Text",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Telephone_Menu_Appel_Cadran_Numero",_edit];
_edit ctrlSetPosition [0.039,0.18,0.48,0.07];
_edit ctrlCommit 0;

private _liste_Contact = profileNamespace getvariable ["MRP_Telephone_Liste_Contact",createhashmap];
private _info_Contact = [];

if !(isnil {MRP_Telephone_Gestion_Numero_Interne}) then
{
	private _intituler_Identifiant = [MRP_Telephone_Gestion_Numero_Interne] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Intituler;
	_edit ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_46' shadow='0' color='#000000' size='1.8' valign='bottom' align='center'>%1</t>",_intituler_Identifiant];
};

// Texte bouton ajout numéro
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Telephone_Menu_Appel_Bouton_Ajout_Numero",_ctrlButton];
_ctrlButton ctrlSetPosition [0.12,0.24,0.3,0.102];
_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Appel\Phrase_Ajout_Numero_Gris_dxt5.paa";
_ctrlButton ctrlSetTextColor [1,1,1,1];
_ctrlButton ctrlCommit 0;

private _texte = ctrltext _edit;
private _numero_Fractionner = _texte splitstring "";
private _nombre_Numero_Fractionner = count _numero_Fractionner;

private _liste_Entreprise = profilenamespace getvariable ["MRP_Tel_Liste_Entreprise",[]];
private _est_Pas_Une_Entreprise = !(_texte in str _liste_Entreprise);

if (_texte isNotEquaLTo "" AND {_info_Contact isEquaLTo [] AND {_nombre_Numero_Fractionner isequalto 14 AND {_est_Pas_Une_Entreprise}}}) then
{
	_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Appel\Phrase_Ajout_Numero_dxt5.paa";
	_ctrlButton ctrlSetTextColor [0.9,0.9,0.9,1];
};

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	private _cadran_Numero = uiNamespace getVariable ["MRP_Telephone_Menu_Appel_Cadran_Numero",controlNull];
	private _numero = ctrltext _cadran_Numero;

	if (_numero isNotEqualTo "" AND {"Phrase_Ajout_Numero_dxt5" in (ctrltext _control)}) then
	{
		private _liste_Contact = profileNamespace getvariable ["MRP_Telephone_Liste_Contact",createhashmap];
		private _info_Contact = _liste_Contact getOrDefault [MRP_Telephone_Gestion_Numero_Interne,[]];

		if (_info_Contact isEqualTo []) then
		{
			if ("#31#" in _numero) then {_numero = _numero regexReplace ["#31# ",""];};
			
			_numero = _numero regexReplace [" ",""];
			MRP_Telephone_Gestion_Numero_Interne = _numero;

			[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
			[] call MRPV2_fnc_MRP_Tel_Menu_Contact_Modif_Crea;
		};
	};
}];

// Numéro de 0 à 9
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.07,0.37,0.14,0.14];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Appel\Petite_icone_appel_1.paa";
_ctrlButton ctrlSetTextColor [0.9,0.9,0.9,1];
_ctrlButton ctrlAddEventHandler ["ButtonClick",{["1",_this # 0] call MRPV2_fnc_MRP_Tel_Menu_Appel_Action_Bouton;}];

private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.2,0.37,0.14,0.14];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Appel\Petite_icone_appel_2.paa";
_ctrlButton ctrlSetTextColor [0.9,0.9,0.9,1];
_ctrlButton ctrlAddEventHandler ["ButtonClick",{["2",_this # 0] call MRPV2_fnc_MRP_Tel_Menu_Appel_Action_Bouton;}];

private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.33,0.37,0.14,0.14];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Appel\Petite_icone_appel_3.paa";
_ctrlButton ctrlSetTextColor [0.9,0.9,0.9,1];
_ctrlButton ctrlAddEventHandler ["ButtonClick",{["3",_this # 0] call MRPV2_fnc_MRP_Tel_Menu_Appel_Action_Bouton;}];

private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.07,0.54,0.14,0.14];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Appel\Petite_icone_appel_4.paa";
_ctrlButton ctrlSetTextColor [0.9,0.9,0.9,1];
_ctrlButton ctrlAddEventHandler ["ButtonClick",{["4",_this # 0] call MRPV2_fnc_MRP_Tel_Menu_Appel_Action_Bouton;}];

private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.2,0.54,0.14,0.14];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Appel\Petite_icone_appel_5.paa";
_ctrlButton ctrlSetTextColor [0.9,0.9,0.9,1];
_ctrlButton ctrlAddEventHandler ["ButtonClick",{["5",_this # 0] call MRPV2_fnc_MRP_Tel_Menu_Appel_Action_Bouton;}];

private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.33,0.54,0.14,0.14];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Appel\Petite_icone_appel_6.paa";
_ctrlButton ctrlSetTextColor [0.9,0.9,0.9,1];
_ctrlButton ctrlAddEventHandler ["ButtonClick",{["6",_this # 0] call MRPV2_fnc_MRP_Tel_Menu_Appel_Action_Bouton;}];

private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.07,0.71,0.14,0.14];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Appel\Petite_icone_appel_7.paa";
_ctrlButton ctrlSetTextColor [0.9,0.9,0.9,1];
_ctrlButton ctrlAddEventHandler ["ButtonClick",{["7",_this # 0] call MRPV2_fnc_MRP_Tel_Menu_Appel_Action_Bouton;}];

private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.2,0.71,0.14,0.14];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Appel\Petite_icone_appel_8.paa";
_ctrlButton ctrlSetTextColor [0.9,0.9,0.9,1];
_ctrlButton ctrlAddEventHandler ["ButtonClick",{["8",_this # 0] call MRPV2_fnc_MRP_Tel_Menu_Appel_Action_Bouton;}];

private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.33,0.71,0.14,0.14];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Appel\Petite_icone_appel_9.paa";
_ctrlButton ctrlSetTextColor [0.9,0.9,0.9,1];

_ctrlButton ctrlAddEventHandler ["ButtonClick",{["9",_this # 0] call MRPV2_fnc_MRP_Tel_Menu_Appel_Action_Bouton;}];

private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.2,0.88,0.14,0.14];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Appel\Petite_icone_appel_0.paa";
_ctrlButton ctrlSetTextColor [0.9,0.9,0.9,1];
_ctrlButton ctrlAddEventHandler ["ButtonClick",{["0",_this # 0] call MRPV2_fnc_MRP_Tel_Menu_Appel_Action_Bouton;}];

// Symbole * et #
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.07,0.88,0.14,0.14];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Appel\Petite_icone_appel_etoile.paa";
_ctrlButton ctrlSetTextColor [0.9,0.9,0.9,1];
_ctrlButton ctrlAddEventHandler ["ButtonClick",{["*",_this # 0] call MRPV2_fnc_MRP_Tel_Menu_Appel_Action_Bouton;}];

private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.33,0.88,0.14,0.14];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Appel\Petite_icone_appel_diese.paa";
_ctrlButton ctrlSetTextColor [0.9,0.9,0.9,1];
_ctrlButton ctrlAddEventHandler ["ButtonClick",{["#",_this # 0] call MRPV2_fnc_MRP_Tel_Menu_Appel_Action_Bouton;}];

// Bouton appel
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.2,1.05,0.14,0.14];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Appel\Icone_appel.paa";
_ctrlButton ctrlSetTextColor [0.9,0.9,0.9,1];

private _liste_Configuration = profileNamespace getvariable ["MRP_Telephone_Configuration",[]];
private _mode_Avion = _liste_Configuration # 0;
	
if (_mode_Avion) then
{
	_ctrlButton ctrlSetTextColor [1,1,1,0.2];
	_ctrlButton ctrlenable false;
};

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];	
	private _cadran_Numero = uiNamespace getVariable ["MRP_Telephone_Menu_Appel_Cadran_Numero",controlNull];
	private _numero = trim (ctrltext _cadran_Numero);	
	if (_numero isEquaLTo "") exitwith {};	
	
if (!(_numero in [17,18,21,"Gendarmerie","Pompiers","AP / PM"]) && {ALF_Forfait < 1}) exitwith {
	hint "Votre forfait est épuisé.";
};
 	
	[_control] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;	

	if (isnil {MRP_Telephone_Gestion_Numero_Interne}) then
	{
		MRP_Telephone_Gestion_Numero_Interne = _numero regexreplace [" ",""];
		MRP_Telephone_Numero_Appel = _numero regexreplace [" ",""];
	} else
	{
		MRP_Telephone_Numero_Appel = MRP_Telephone_Gestion_Numero_Interne regexreplace [" ",""];
	};

	private _Telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];
	private _fond = ctrltext _Telephone_Fond;
	uiNamespace setVariable ["MRP_Telephone_Fond_Menu_En_Attente",_fond];
	
	// Si le joueur est toujours en mode entrprise pour le tel mais nest plus en service on desactive le mdoe entreprise sur le tel
	if !(b_enService || life_gendarme_service || life_pompier_service || life_penit_service) then 
	{
		private _telephone_Configuration = profileNamespace getvariable ["MRP_Telephone_Configuration",[]];
		_telephone_Configuration set [11,FALSE];
		profileNamespace setVariable ["MRP_Telephone_Configuration",_telephone_Configuration];
		player setvariable ["MRP_Telephone_Mode_Entreprise",FALSE];
	};

	[] call MRPV2_fnc_MRP_Tel_Menu_Appel_Exped_Crea;
	[player] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Etat_Joueur_En_Appel;
}];

// Bouton suppression numéro
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.35,1.07,0.1,0.1];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Appel\Petite_icone_appel_effacer.paa";
_ctrlButton ctrlSetTextColor [0.9,0.9,0.9,1];

_ctrlButton ctrlAddEventHandler ["MouseButtonDown",
{params ["_control"];
	[_control] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;

	private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
	private _cadran_Numero = uiNamespace getVariable ["MRP_Telephone_Menu_Appel_Cadran_Numero",controlNull];

	playsound "MRP_Telephone_Touche_Appli";

	private _numero_Appel = (ctrlText _cadran_Numero) regexReplace [" ",""];
	if (_numero_Appel isEqualTo "") exitwith {};

	if (!(isnil {MRP_Telephone_Gestion_Numero_Interne}) AND {_numero_Appel isNotEqualTo MRP_Telephone_Gestion_Numero_Interne}) then
	{
		_numero_Appel = MRP_Telephone_Gestion_Numero_Interne;
		MRP_Telephone_Gestion_Numero_Interne = nil;
	};

	private _numero_Fractionner = _numero_Appel splitstring "";
	private _nombre_Numero = count _numero_Fractionner;
	
	_numero_Fractionner deleteAt (_nombre_Numero - 1);	
	_numero_Reformer = _numero_Fractionner joinstring "";

	private _liste_Contact = profileNamespace getvariable ["MRP_Telephone_Liste_Contact",createhashmap];
	private _info_Contact = _liste_Contact getOrDefault [_numero_Reformer,[]];
	if (_info_Contact isequalto []) then {MRP_Telephone_Gestion_Numero_Interne = nil;	};
	
	private _intituler_Identifiant = [_numero_Reformer] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Intituler;

	_cadran_Numero ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_46' shadow='0' color='#000000' size='1.8' valign='bottom' align='center'>%1</t>",_intituler_Identifiant];

	[] call MRPV2_fnc_MRP_Tel_Menu_Appel_Gestion_Couleur_Bouton_Ajouter;
}];

[FALSE,FALSE,TRUE,_telephone_Cadre_Base] call MRPV2_fnc_MRP_Tel_Divers_Crea_Menu_Bas_Ecran;

// Bouton retour menu principal
[] call MRPV2_fnc_MRP_Tel_Menu_Principal_Action_Retour;

TRUE
// };