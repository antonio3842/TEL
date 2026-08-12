// MRPV2_fnc_MRP_Tel_Menu_Bloc_Lecture_Note = {
private _cle = param [0,""];


private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _Telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];
private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];

_Telephone_Fond ctrlSetText "MRP_Telephones\Data\Menu_Bloc_Note\Menu_Note_Vide_dxt5.paa";

private _Telephone_Liste_Note = profileNamespace getvariable ["MRP_Telephone_Liste_Note",createhashmap];
private _info_Note = _Telephone_Liste_Note getorDefault [_cle,""];

if (_info_Note isEqualTo "") exitwith {};

private _titre = _info_Note # 0;
private _texte = _info_Note # 1;

// Bouton retour Note en haut a gauche
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.05,0.179,0.03,0.04];
_ctrlButton ctrlSetText "MRP_Telephones\Data\Menu_Bloc_Note\Icone_Fleche_Retour_dxt5.paa";
_ctrlButton ctrlCommit 0;

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	[_control] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;
	
	playsound "MRP_Telephone_Touche_Appli";
	
	[] spawn
	{
		sleep 0.2;
		[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
		[] call MRPV2_fnc_MRP_Tel_Menu_Bloc_Crea;
	};
}];

// Champ Titre note
_edit = _Telephone_Base ctrlCreate ["RscText",-1,_telephone_Cadre_Base];
_edit ctrlSetPosition [0.05,0.3,0.456,0.07];
_edit ctrlSetBackgroundColor [1,1,1,1];
_edit ctrlSetText _titre;
_edit ctrlSetTextColor [0,0,0,1];
_edit ctrlSetFontHeight 0.08;
_edit ctrlSetShadow 0;
_edit ctrlSetFont "SFUIDisplay_46";
_edit ctrlCommit 0;

// Champ contenus Notes
_edit = _Telephone_Base ctrlCreate ["MRP_RscTextMulti",-1,_telephone_Cadre_Base];
_edit ctrlSetPosition [0.05,0.44,0.456,0.8];
_edit ctrlSetText _texte;
_edit ctrlSetTextColor [0,0,0,1];
_edit ctrlSetBackgroundColor [1,1,1,1];
_edit ctrlSetFontHeight 0.06;
_edit ctrlSetShadow 0;
_edit ctrlenable FALSE;
_edit ctrlSetFont "SFUIDisplay_46";
_edit ctrlCommit 0;

// Bouton Supprimer note en haut a droite
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.47,0.17,0.03,0.04];
_ctrlButton ctrlSetTextColor [0.8,0.8,0.8,1];
_ctrlButton ctrlSetText "MRP_Telephones\Data\Menu_Bloc_Note\Icone_Supprimer_dxt5.paa";
_ctrlButton ctrlCommit 0;
_ctrlButton setvariable ["_cle",_cle];

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	[_control] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;
	
	playsound "MRP_Telephone_Touche_Appli";
	
	[_control] spawn
	{params ["_control"];
		sleep 0.2;
		private _cle = _control getvariable "_cle";
		[_cle] call MRPV2_fnc_MRP_Tel_Menu_Bloc_Suppr_Note;
	};
}];

// Bouton Modifier note en bas a droite
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.47,0.24,0.03,0.04];
_ctrlButton ctrlSetText "MRP_Telephones\Data\Menu_Bloc_Note\Icone_Creer_Note_dxt5.paa";
_ctrlButton ctrlSetTextColor [0.9,0.9,0.9,1];
_ctrlButton ctrlCommit 0;
_ctrlButton setvariable ["_cle",_cle];

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	[_control] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;
	
	playsound "MRP_Telephone_Touche_Appli";
	
	[_control] spawn
	{params ["_control"];
		sleep 0.2;
		private _cle = _control getvariable "_cle";

		[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
		[_cle] call MRPV2_fnc_MRP_Tel_Menu_Bloc_Crea_Modif;
	};
}];

// Bouton retour menu principal
[] call MRPV2_fnc_MRP_Tel_Menu_Principal_Action_Retour;

TRUE
// };