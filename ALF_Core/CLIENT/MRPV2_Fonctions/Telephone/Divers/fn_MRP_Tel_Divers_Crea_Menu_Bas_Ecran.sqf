// MRPV2_fnc_MRP_Tel_Divers_Crea_Menu_Bas_Ecran = {
private _icone_Recents_Bleu = param [0,FALSE];
private _icone_Contacts_Bleu = param [1,FALSE];
private _icone_Clavier_Bleu = param [2,FALSE];
private _telephone_Cadre_Base = param [3,controlNull];


private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _ctrlButton = controlNull;

// Bouton menu Récents
_ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText_Inverser",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.147,1.235,0.067,0.09];
_ctrlButton ctrlCommit 0;

if (_icone_Recents_Bleu) then
{
	_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Pied_Ecran\Icone_Historique_Bleu_dxt5.paa";
	_ctrlButton ctrlenable false;
} else
{
	_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Pied_Ecran\Icone_Historique_dxt5.paa";
	_ctrlButton ctrlAddEventHandler ["ButtonClick",
	{
		MRP_Telephone_Gestion_Numero_Interne = nil;
		playsound "MRP_Telephone_Touche_Appli";

		[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
		[] call MRPV2_fnc_MRP_Tel_Menu_Historique_Crea;
	}];
};

// Bouton menu Contacts
_ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText_Inverser",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.245,1.235,0.07,0.09];
_ctrlButton ctrlCommit 0;

if (_icone_Contacts_Bleu) then
{
	_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Pied_Ecran\Icone_Contacts_Bleu_dxt5.paa";
	_ctrlButton ctrlenable false;
} else
{
	_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Pied_Ecran\Icone_Contacts_dxt5.paa";
	_ctrlButton ctrlAddEventHandler ["ButtonClick",
	{
		MRP_Telephone_Gestion_Numero_Interne = nil;
		playsound "MRP_Telephone_Touche_Appli";

		[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
		[] call MRPV2_fnc_MRP_Tel_Menu_Contact_Crea;
	}];
};

// Bouton menu Appel
_ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText_Inverser",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.34,1.235,0.08,0.09];
_ctrlButton ctrlCommit 0;

if (_icone_Clavier_Bleu) then
{
	_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Pied_Ecran\Icone_Clavier_Bleu_dxt5.paa";
	_ctrlButton ctrlenable false;
} else
{
	_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Pied_Ecran\Icone_Clavier_dxt5.paa";
	_ctrlButton ctrlAddEventHandler ["ButtonClick",
	{
		MRP_Telephone_Gestion_Numero_Interne = nil;
		playsound "MRP_Telephone_Touche_Appli";

		[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
		[] call MRPV2_fnc_MRP_Tel_Menu_Appel_Crea;
	}];
};

TRUE
// };