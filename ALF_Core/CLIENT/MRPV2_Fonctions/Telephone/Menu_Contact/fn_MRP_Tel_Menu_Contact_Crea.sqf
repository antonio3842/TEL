// MRPV2_fnc_MRP_Tel_Menu_Contact_Crea = {
private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _Telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];
private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];

_Telephone_Fond ctrlSetText "MRP_icone_tel\Data\Menu_Contact\Menu_Contact_liste_dxt5.paa";

// Bouton ajout contact en haut a droite
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.48,0.1,0.04,0.05];
_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Contact\Icone_Ajout_Contact_dxt5.paa";
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
		[] call MRPV2_fnc_MRP_Tel_Menu_Contact_Modif_Crea;
	};
}];

// Champ recherche
_edit = _Telephone_Base ctrlCreate ["MRP_Telephone_RscEdit_Cadre_Invisible",645,_telephone_Cadre_Base];
_edit ctrlSetPosition [0.09,0.227,0.4,0.0556];
_edit ctrlSetBackgroundColor [0,0,0,0];
_edit ctrlSetFont "SFUIDisplay_46";
_edit ctrlSetFontHeight 0.05;
_edit ctrlSetTextColor [0,0,0,1];
_edit ctrlCommit 0;

_edit ctrlAddEventHandler ["Keydown",
{params ["_control"];
	[_control,50] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;
}];

_edit ctrlAddEventHandler ["KeyUp",
{
	private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];

	private _texte = ctrltext (_Telephone_Base displayctrl 645);
	private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];

	[_telephone_Cadre_Base,_texte] call MRPV2_fnc_MRP_Tel_Menu_Contact_Crea_Liste;
}];

// Numero personnel
_edit = _Telephone_Base ctrlCreate ["RscStructuredText",-1,_telephone_Cadre_Base];
_edit ctrlSetPosition [0.02,0.35,0.5,0.05];
_edit ctrlCommit 0;

private _mon_Numero = player getvariable ["phonenumber",""];
_mon_Numero = _mon_Numero insert [2, " "];
_mon_Numero = _mon_Numero insert [5, " "];
_mon_Numero = _mon_Numero insert [8, " "];
_mon_Numero = _mon_Numero insert [11, " "];

_edit ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_20' shadow='0' color='#000000' size='1.4' align='center'>Mon numéro : %1</t>",_mon_Numero];

[_telephone_Cadre_Base] call MRPV2_fnc_MRP_Tel_Menu_Contact_Crea_Liste;

[FALSE,TRUE,FALSE,_telephone_Cadre_Base] call MRPV2_fnc_MRP_Tel_Divers_Crea_Menu_Bas_Ecran;

// Bouton retour menu principal
[] call MRPV2_fnc_MRP_Tel_Menu_Principal_Action_Retour;

TRUE
// };