// MRPV2_fnc_MRP_Tel_Menu_Principal_Crea = {
private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];


[] call MRPV2_fnc_MRP_Tel_Menu_Principal_Fond_Ecran;
[] call MRPV2_fnc_MRP_Tel_Menu_Principal_Crea_Liste_Appli;

// Barre Fond menu principal
private _ctrl_Image = _Telephone_Base ctrlCreate ["RscPicture",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Telephone_Menu_Principal_Creation_Fond_Menu_Bas",_ctrl_Image];
_ctrl_Image ctrlSetPosition [0.005,1.17,0.55,0.18];
_ctrl_Image ctrlSetText "MRP_icone_tel\Data\Menu_Principal\Barre_Fond_Menu_Principal_dxt5.paa";
_ctrl_Image ctrlCommit 0;

// Creation bouton Appel
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Telephone_Menu_Principal_Creation_Bouton_Appel",_ctrlButton];
_ctrlButton ctrlSetPosition [0.07,1.201,0.092,0.12];
_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Principal\Icone_appel.paa";
_ctrlButton ctrlSetTextColor [0.9,0.9,0.9,1];
_ctrlButton ctrlCommit 0;

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_ctrl"];
	playsound "MRP_Telephone_Touche_Appli";

	MRP_Telephone_Gestion_Numero_Interne = nil;

	[_ctrl] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;
	[] spawn
	{
		sleep 0.2;

		private _telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];
		private _fond = ctrltext _Telephone_Fond;

		private _adresse_Fond_Appel = "MRP_icone_tel\Data\Menu_Appel\Fond_Appel_dxt5.paa";
		if (_fond isequalto _adresse_Fond_Appel) exitwith {};

		[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
		[] call MRPV2_fnc_MRP_Tel_Menu_Appel_Crea;
	};
}];

private _compteur_Nouveau_Appel = ([] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Nombre_Appel) min 99;

// modification icone si nouveau appel sur le menu principal
if (_compteur_Nouveau_Appel > 0) then
{
	_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Principal\Icone_Appel_Rec.paa";
	_ctrlButton ctrlSetPosition [0.053,1.188,0.133,0.133];
	_ctrlButton ctrlCommit 0;

	private _ctrl_Compteur_Nouveau_Appel = uiNamespace getVariable ["MRP_Telephone_Menu_Principal_Compteur_Nouveau_Appel",controlNull];

	if (_ctrl_Compteur_Nouveau_Appel isEqualTo controlNull) then
	{
		_ctrl_Compteur_Nouveau_Appel = _Telephone_Base ctrlCreate ["MRP_Structured_Text",-1,_telephone_Cadre_Base];
		uiNamespace setVariable ["MRP_Telephone_Menu_Principal_Compteur_Nouveau_Appel",_ctrl_Compteur_Nouveau_Appel];
		_ctrl_Compteur_Nouveau_Appel ctrlSetPosition [0.127,1.195,0.05,0.05];
		_ctrl_Compteur_Nouveau_Appel ctrlCommit 0;
	};

	_ctrl_Compteur_Nouveau_Appel ctrlSetStructuredText parsetext format ["<t font='SFUIDisplay_20' color='#ffffff' shadow='0' size='0.8' align='center'>%1</t>",_compteur_Nouveau_Appel];
};

// Creation bouton SMS
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Telephone_Menu_Principal_Creation_Bouton_SMS",_ctrlButton];
_ctrlButton ctrlSetPosition [0.18,1.201,0.092,0.12];
_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Principal\Icone_SMS.paa";
_ctrlButton ctrlSetTextColor [0.9,0.9,0.9,1];
_ctrlButton ctrlCommit 0;

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_ctrl"];
	playsound "MRP_Telephone_Touche_Appli";

	[_ctrl] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;
	[] spawn
	{
		sleep 0.2;

		private _telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];
		private _fond = ctrltext _Telephone_Fond;

		private _adresse_Fond_Appel = "MRP_icone_tel\Data\Menu_Appel\Fond_Appel_dxt5.paa";
		if (_fond isequalto _adresse_Fond_Appel) exitwith {};

		[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
		[] call MRPV2_fnc_MRP_Tel_Menu_SMS_Crea;
	};
}];

private _compteur_Nouveau_SMS = (["Menu principal"] call MRPV2_fnc_MRP_Tel_Menu_SMS_Gestion_Nombre_SMS) min 99;

// modification icone si nouveau SMS sur le menu principal
if (_compteur_Nouveau_SMS > 0) then
{
	_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Principal\Icone_SMS_Mess.paa";
	_ctrlButton ctrlSetPosition [0.163,1.189,0.132,0.132];
	_ctrlButton ctrlCommit 0;

	private _ctrl_Compteur_Nouveau_Mess = uiNamespace getVariable ["MRP_Telephone_Menu_Principal_Compteur_Nouveau_Mess",controlNull];

	if (_ctrl_Compteur_Nouveau_Mess isEqualTo controlNull) then
	{
		_ctrl_Compteur_Nouveau_Mess = _Telephone_Base ctrlCreate ["MRP_Structured_Text",-1,_telephone_Cadre_Base];
		uiNamespace setVariable ["MRP_Telephone_Menu_Principal_Compteur_Nouveau_Mess",_ctrl_Compteur_Nouveau_Mess];
		_ctrl_Compteur_Nouveau_Mess ctrlSetPosition [0.237,1.195,0.05,0.05];
		_ctrl_Compteur_Nouveau_Mess ctrlCommit 0;
	};

	_ctrl_Compteur_Nouveau_Mess ctrlSetStructuredText parsetext format ["<t font='SFUIDisplay_20' color='#ffffff' shadow='0' size='0.8' align='center'>%1</t>",_compteur_Nouveau_SMS];
};

private _telephone_Configuration = profileNamespace getvariable ["MRP_Telephone_Configuration",[]];

// Creation bouton Contact
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Telephone_Menu_Principal_Creation_Bouton_Contact",_ctrlButton];
_ctrlButton ctrlSetPosition [0.29,1.201,0.092,0.12];
_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Principal\Icone_Contacts.paa";
_ctrlButton ctrlSetTextColor [0.9,0.9,0.9,1];
_ctrlButton ctrlCommit 0;

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_ctrl"];
	playsound "MRP_Telephone_Touche_Appli";

	[_ctrl] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;
	[] spawn
	{
		sleep 0.2;

		private _telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];
		private _fond = ctrltext _Telephone_Fond;

		private _adresse_Fond_Appel = "MRP_icone_tel\Data\Menu_Appel\Fond_Appel_dxt5.paa";
		if (_fond isequalto _adresse_Fond_Appel) exitwith {};

		[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
		[] call MRPV2_fnc_MRP_Tel_Menu_Contact_Crea;
	};
}];

// Creation bouton Réglages
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Telephone_Menu_Principal_Creation_Bouton_Reglages",_ctrlButton];
_ctrlButton ctrlSetPosition [0.4,1.201,0.092,0.12];
_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Principal\Icone_Reglages.paa";
_ctrlButton ctrlSetTextColor [0.9,0.9,0.9,1];
_ctrlButton ctrlCommit 0;

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_ctrl"];
	playsound "MRP_Telephone_Touche_Appli";

	[_ctrl] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;
	[] spawn
	{
		sleep 0.2;

		private _telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];
		private _fond = ctrltext _Telephone_Fond;

		private _adresse_Fond_Appel = "MRP_icone_tel\Data\Menu_Appel\Fond_Appel_dxt5.paa";
		if (_fond isequalto _adresse_Fond_Appel) exitwith {};

		[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
		[] call MRPV2_fnc_MRP_Tel_Menu_Reglages_Crea;
	};
}];

TRUE
// };