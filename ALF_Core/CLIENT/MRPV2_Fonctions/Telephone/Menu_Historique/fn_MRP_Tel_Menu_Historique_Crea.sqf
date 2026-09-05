// MRPV2_fnc_MRP_Tel_Menu_Historique_Crea = {
private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _Telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];
private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];

_Telephone_Fond ctrlSetText "MRP_icone_tel\Data\Menu_Historique\Menu_recent.paa";

// Bouton supprimer historique
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.405,0.15,0.11,0.05];
_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Contact\Icone_Supprimer_dxt5.paa";
_ctrlButton ctrlSetTextColor [0.8,0.8,0.8,1];
_ctrlButton ctrlCommit 0;

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	[_control] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;

	playsound "MRP_Telephone_Touche_Appli";

	[] spawn
	{
		sleep 0.2;
		["Supprimer Historique"] call MRPV2_fnc_MRP_Tel_Menu_Contact_Lecture_Fiche_Gestion_Contact;
	};
}];

[] call MRPV2_fnc_MRP_Tel_Menu_Historique_Crea_Liste;

[TRUE,FALSE,FALSE,_telephone_Cadre_Base] call MRPV2_fnc_MRP_Tel_Divers_Crea_Menu_Bas_Ecran;

// Bouton retour menu principal
[] call MRPV2_fnc_MRP_Tel_Menu_Principal_Action_Retour;

TRUE
// };