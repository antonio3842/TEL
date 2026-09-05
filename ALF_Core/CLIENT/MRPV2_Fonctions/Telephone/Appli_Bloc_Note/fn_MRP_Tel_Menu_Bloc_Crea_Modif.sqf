private _cle = param [0,""];


private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _Telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];
private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];

_Telephone_Fond ctrlSetText "MRP_icone_tel\Data\Menu_Bloc_Note\Menu_Note_Vide_dxt5.paa";

// Bouton retour Note en haut a gauche
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.05,0.179,0.03,0.04];
_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Bloc_Note\Icone_Fleche_Retour_dxt5.paa";
_ctrlButton ctrlCommit 0;

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	[_control] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;
	
	playsound "MRP_Telephone_Touche_Appli";
	
	[_control] spawn
	{params ["_control"];
		sleep 0.2;
		[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
		[] call MRPV2_fnc_MRP_Tel_Menu_Bloc_Crea;
	};
}];

// Bouton Confirmer en haut a droite
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.46,0.179,0.05,0.05];
_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Bloc_Note\Icone_Valider_dxt5.paa";
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
		[_cle] call MRPV2_fnc_MRP_Tel_Menu_Bloc_Gestion_Modif_Note;

		[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
		[] call MRPV2_fnc_MRP_Tel_Menu_Bloc_Crea;
	};
}];

private _Telephone_Liste_Note = profileNamespace getvariable ["MRP_Telephone_Liste_Note",createhashmap];
private _info_Note = _Telephone_Liste_Note getorDefault [_cle,""];

if (_info_Note isEqualTo "") exitwith {};

private _titre = _info_Note # 0;
private _texte = _info_Note # 1;

// Champ Titre note
_edit = _Telephone_Base ctrlCreate ["RscEdit",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Tel_Var_Note_Titre",_edit];
_edit ctrlSetPosition [0.05,0.3,0.456,0.07];
_edit ctrlSetText _titre;
_edit ctrlSetBackgroundColor [1,1,1,1];
_edit ctrlSetTextColor [0,0,0,1];
_edit ctrlSetFontHeight 0.06;
_edit ctrlSetShadow 0;
_edit ctrlSetFont "SFUIDisplay_46";
_edit ctrlCommit 0;

_edit ctrlAddEventHandler ["Keydown",
{params ["_control"];
	[_control,50] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;
}];

// Champ contenus Notes
_edit = _Telephone_Base ctrlCreate ["RscEditMulti", -1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Tel_Var_Note_Texte",_edit];
_edit ctrlSetPosition [0.05,0.44,0.456,0.8];
_edit ctrlSetText _texte;
_edit ctrlSetTextColor [0,0,0,1];
_edit ctrlSetBackgroundColor [1,1,1,1];
_edit ctrlSetFontHeight 0.06;
_edit ctrlSetShadow 0;
_edit ctrlSetFont "SFUIDisplay_46";
_edit ctrlCommit 0;
_edit ctrlSetTextSelection [0,0];

_edit ctrlAddEventHandler ["KeyUp",
{params ["_displayOrControl", "_key"];
	[_displayOrControl,110] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;
}];

_edit ctrlAddEventHandler ["KeyDown",
{params ["_displayOrControl", "_key"];
	if (_key isEqualTo 28) then {[_displayOrControl] call MRPV2_fnc_MRP_Tel_Divers_Ajout_Retour_Ligne;};
	[_displayOrControl,110] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;
}];

// Bouton retour menu principal
[] call MRPV2_fnc_MRP_Tel_Menu_Principal_Action_Retour;

TRUE