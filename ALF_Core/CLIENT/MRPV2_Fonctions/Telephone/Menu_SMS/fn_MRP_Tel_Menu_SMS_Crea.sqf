// MRPV2_fnc_MRP_Tel_Menu_SMS_Crea = {
private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _Telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];
private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];

_Telephone_Fond ctrlSetText "MRP_icone_tel\Data\Menu_SMS\Menu_SMS_Liste_dxt5.paa";

// Bouton ecrire SMS en haut a droite
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText_Inverser",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.45,0.12,0.05,0.05];
_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_SMS\Menu_SMS_Bouton_Nouveau_SMSdxt5.paa";
_ctrlButton ctrlCommit 0;

private _Mode_Avion = player getvariable ["MRP_Telephone_Mode_Avion",FALSE];

if (_mode_Avion OR (ALF_Forfait < 1)) then
{
	_ctrlButton ctrlenable FALSE;
	_ctrlButton ctrlSetTextcolor [1,1,1,0.2];
};

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	[_control] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;
	playsound "MRP_Telephone_Touche_Appli";

	[_control] spawn
	{params ["_control"];
		sleep 0.2;

		[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
		[] call MRPV2_fnc_MRP_Tel_Menu_Nouveau_SMS_Crea;
	};
}];

[] call MRPV2_fnc_MRP_Tel_Menu_SMS_Crea_Liste;

// Bouton retour menu principal
[] call MRPV2_fnc_MRP_Tel_Menu_Principal_Action_Retour;

TRUE
// };