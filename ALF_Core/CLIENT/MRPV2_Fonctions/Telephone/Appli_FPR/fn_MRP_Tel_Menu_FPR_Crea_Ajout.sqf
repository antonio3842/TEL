// MRPV2_fnc_MRP_Tel_Menu_FPR_Crea_Ajout = {
private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _Telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];
private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];

_Telephone_Fond ctrlSetText "MRP_icone_tel\Data\Fond\Neogend_Fond_PC_Storm_Vide.paa";

// Bouton Annuler (RscText visuel + MRP_Bouton invisible superposé)
private _pos_Bouton_Annuler = [0.09,0.095,0.13,0.05];

private _visuel_Annuler = _Telephone_Base ctrlCreate ["RscText",-1,_telephone_Cadre_Base];
_visuel_Annuler ctrlSetPosition _pos_Bouton_Annuler;
_visuel_Annuler ctrlSetBackgroundColor [1,1,1,0.1];
_visuel_Annuler ctrlSetText "Annuler";
_visuel_Annuler ctrlSetTextColor [1,1,1,1];
_visuel_Annuler ctrlSetFontHeight 0.04;
_visuel_Annuler ctrlSetShadow 0;
_visuel_Annuler ctrlSetFont "SFUIDisplay_46";
_visuel_Annuler ctrlCommit 0;

private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_Bouton",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition _pos_Bouton_Annuler;
_ctrlButton ctrlCommit 0;
_ctrlButton setvariable ["_visuel",_visuel_Annuler];

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	private _visuel = _control getvariable ["_visuel",controlNull];
	[_visuel] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;
	playsound "MRP_Telephone_Touche_Appli";
	[] spawn
	{
		sleep 0.2;
		[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
		[] call MRPV2_fnc_MRP_Tel_Menu_FPR_Crea;
	};
}];

// Titre
private _titre = _Telephone_Base ctrlCreate ["RscStructuredText",-1,_telephone_Cadre_Base];
_titre ctrlSetPosition [0.09,0.165,0.45,0.06];
_titre ctrlCommit 0;
_titre ctrlSetStructuredText parseText "<t font='SFUIDisplay_20' shadow='0' color='#ffffff' size='1.5' align='left'>Ajouter au FPR</t>";

// --- Champ Nom ---
private _cadre = _Telephone_Base ctrlCreate ["RscText",-1,_telephone_Cadre_Base];
_cadre ctrlSetPosition [0.09,0.25,0.42,0.075];
_cadre ctrlSetBackgroundColor [1,1,1,0.08];
_cadre ctrlCommit 0;

private _edit = _Telephone_Base ctrlCreate ["MRP_Telephone_RscEdit_Cadre_Invisible",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Tel_FPR_Ajout_Champ_Nom",_edit];
_edit ctrlSetPosition [0.105,0.263,0.39,0.05];
_edit ctrlSetFont "SFUIDisplay_46";
_edit ctrlSetFontHeight 0.048;
_edit ctrlSetTextColor [1,1,1,0.4];
_edit ctrlSetText "Nom de la personne";
_edit ctrlCommit 0;

_edit ctrlAddEventHandler ["SetFocus",{params ["_control"]; if (ctrlText _control isEqualTo "Nom de la personne") then {_control ctrlSetText "";}; _control ctrlSetTextColor [1,1,1,1];}];
_edit ctrlAddEventHandler ["Killfocus",{params ["_control"]; if (ctrlText _control isEqualTo "") then {_control ctrlSetTextColor [1,1,1,0.4]; _control ctrlSetText "Nom de la personne";};}];
_edit ctrlAddEventHandler ["Keydown",{params ["_control"]; [_control,30] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;}];

// --- Champ Motif ---
_cadre = _Telephone_Base ctrlCreate ["RscText",-1,_telephone_Cadre_Base];
_cadre ctrlSetPosition [0.09,0.34,0.42,0.35];
_cadre ctrlSetBackgroundColor [1,1,1,0.08];
_cadre ctrlCommit 0;

_edit = _Telephone_Base ctrlCreate ["MRP_RscEditMulti",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Tel_FPR_Ajout_Champ_Motif",_edit];
_edit ctrlSetPosition [0.105,0.353,0.39,0.324];
_edit ctrlSetFont "SFUIDisplay_46";
_edit ctrlSetBackgroundColor [0,0,0,0];
_edit ctrlSetFontHeight 0.048;
_edit ctrlSetTextColor [1,1,1,0.4];
_edit ctrlSetText "Motif de la recherche";
_edit ctrlCommit 0;

_edit ctrlAddEventHandler ["SetFocus",{params ["_control"]; if (ctrlText _control isEqualTo "Motif de la recherche") then {_control ctrlSetText "";}; _control ctrlSetTextColor [1,1,1,1];}];
_edit ctrlAddEventHandler ["Killfocus",{params ["_control"]; if (ctrlText _control isEqualTo "") then {_control ctrlSetTextColor [1,1,1,0.4]; _control ctrlSetText "Motif de la recherche";};}];
_edit ctrlAddEventHandler ["Keydown",{params ["_control"]; [_control,300] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;}];

// Bouton Ajouter (pleine largeur, bien visible)
private _pos_Bouton_Ajouter = [0.09,0.72,0.42,0.08];

private _visuel_Ajouter = _Telephone_Base ctrlCreate ["RscText",-1,_telephone_Cadre_Base];
_visuel_Ajouter ctrlSetPosition _pos_Bouton_Ajouter;
_visuel_Ajouter ctrlSetBackgroundColor [0.15,0.45,0.85,1];
_visuel_Ajouter ctrlSetText "Ajouter";
_visuel_Ajouter ctrlSetTextColor [1,1,1,1];
_visuel_Ajouter ctrlSetFontHeight 0.05;
_visuel_Ajouter ctrlSetShadow 0;
_visuel_Ajouter ctrlSetFont "SFUIDisplay_46";
_visuel_Ajouter ctrlCommit 0;

private _ctrlAjouter = _Telephone_Base ctrlCreate ["MRP_Bouton",-1,_telephone_Cadre_Base];
_ctrlAjouter ctrlSetPosition _pos_Bouton_Ajouter;
_ctrlAjouter ctrlCommit 0;
_ctrlAjouter setvariable ["_visuel",_visuel_Ajouter];

_ctrlAjouter ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	private _visuel = _control getvariable ["_visuel",controlNull];
	[_visuel] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;
	playsound "MRP_Telephone_Touche_Appli";
	[] call MRPV2_fnc_MRP_Tel_Menu_FPR_Action_Ajouter;
}];

// Bouton retour menu principal
[] call MRPV2_fnc_MRP_Tel_Menu_Principal_Action_Retour;

TRUE
// };
