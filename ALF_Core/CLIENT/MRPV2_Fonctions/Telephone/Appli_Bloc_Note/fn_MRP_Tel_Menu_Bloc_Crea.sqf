// MRPV2_fnc_MRP_Tel_Menu_Bloc_Crea = {
private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _Telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];
private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];

_Telephone_Fond ctrlSetText "MRP_icone_tel\Data\Menu_Bloc_Note\Menu_Note_dxt5.paa";

// Champ recherche
_edit = _Telephone_Base ctrlCreate ["RscEdit",645,_telephone_Cadre_Base];
_edit ctrlSetPosition [0.045,0.23,0.4,0.06];
_edit ctrlSetFont "SFUIDisplay_46";
_edit ctrlSetBackgroundColor [1,1,1,1];
_edit ctrlSetFontHeight 0.05;
_edit ctrlSetTextColor [0,0,0,1];
_edit ctrlCommit 0;

_edit ctrlAddEventHandler ["Keydown",
{params ["_control"];
	[_control,30] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;
}];

_edit ctrlAddEventHandler ["KeyUp",
{params ["_control"];
	[_control,30] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;
	[] call MRPV2_fnc_MRP_Tel_Menu_Bloc_Gestion_Liste_Note;
}];

[] call MRPV2_fnc_MRP_Tel_Menu_Bloc_Gestion_Liste_Note;

// Bouton Créer note
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.47,0.24,0.03,0.04];
_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Bloc_Note\Icone_Creer_Note_dxt5.paa";
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
		[] call MRPV2_fnc_MRP_Tel_Menu_Bloc_Crea_Nouvelle_Note;
	};
}];

// Bouton retour menu principal
[] call MRPV2_fnc_MRP_Tel_Menu_Principal_Action_Retour;

TRUE
// };