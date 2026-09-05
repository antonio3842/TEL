// MRPV2_fnc_MRP_Tel_Menu_TAJ_Crea_Ajout = {
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
		[] call MRPV2_fnc_MRP_Tel_Menu_TAJ_Crea;
	};
}];

// Titre
private _titre = _Telephone_Base ctrlCreate ["RscStructuredText",-1,_telephone_Cadre_Base];
_titre ctrlSetPosition [0.09,0.16,0.45,0.06];
_titre ctrlCommit 0;
_titre ctrlSetStructuredText parseText "<t font='SFUIDisplay_20' shadow='0' color='#ffffff' size='1.5' align='left'>Nouvelle fiche</t>";

// --- Champ Nom ---
private _cadre = _Telephone_Base ctrlCreate ["RscText",-1,_telephone_Cadre_Base];
_cadre ctrlSetPosition [0.09,0.25,0.42,0.075];
_cadre ctrlSetBackgroundColor [1,1,1,0.08];
_cadre ctrlCommit 0;

private _edit = _Telephone_Base ctrlCreate ["MRP_Telephone_RscEdit_Cadre_Invisible",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Tel_TAJ_Ajout_Champ_Nom",_edit];
_edit ctrlSetPosition [0.105,0.263,0.39,0.05];
_edit ctrlSetFont "SFUIDisplay_46";
_edit ctrlSetFontHeight 0.048;
_edit ctrlSetTextColor [1,1,1,0.4];
_edit ctrlSetText "Nom de la personne";
_edit ctrlCommit 0;

_edit ctrlAddEventHandler ["SetFocus",
{params ["_control"];
	if (ctrlText _control isEqualTo "Nom de la personne") then {_control ctrlSetText "";};
	_control ctrlSetTextColor [1,1,1,1];
}];
_edit ctrlAddEventHandler ["Killfocus",
{params ["_control"];
	if (ctrlText _control isEqualTo "") then {_control ctrlSetTextColor [1,1,1,0.4]; _control ctrlSetText "Nom de la personne";};
}];
_edit ctrlAddEventHandler ["Keydown",{params ["_control"]; [_control,30] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;}];

// --- Bouton bascule Délit / Crime ---
private _pos_Type = [0.09,0.35,0.42,0.07];

private _visuel_Type = _Telephone_Base ctrlCreate ["RscText",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Tel_TAJ_Ajout_Visuel_Type",_visuel_Type];
_visuel_Type ctrlSetPosition _pos_Type;
_visuel_Type ctrlSetBackgroundColor [0.15,0.45,0.85,1];
_visuel_Type ctrlSetText "Type : Délit  (touchez pour changer)";
_visuel_Type ctrlSetTextColor [1,1,1,1];
_visuel_Type ctrlSetFontHeight 0.042;
_visuel_Type ctrlSetShadow 0;
_visuel_Type ctrlSetFont "SFUIDisplay_46";
_visuel_Type ctrlCommit 0;

private _ctrlType = _Telephone_Base ctrlCreate ["MRP_Bouton",-1,_telephone_Cadre_Base];
_ctrlType ctrlSetPosition _pos_Type;
_ctrlType ctrlCommit 0;
_ctrlType setvariable ["_visuel",_visuel_Type];

MRP_Tel_TAJ_Ajout_Mode = "delit";

_ctrlType ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	playsound "MRP_Telephone_Touche_Appli";

	private _visuel = _control getvariable ["_visuel",controlNull];
	[_visuel] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;

	if (MRP_Tel_TAJ_Ajout_Mode isequalto "delit") then
	{
		MRP_Tel_TAJ_Ajout_Mode = "crime";
		_visuel ctrlSetBackgroundColor [0.75,0.25,0.2,1];
		_visuel ctrlSetText "Type : Crime  (touchez pour changer)";
	} else
	{
		MRP_Tel_TAJ_Ajout_Mode = "delit";
		_visuel ctrlSetBackgroundColor [0.15,0.45,0.85,1];
		_visuel ctrlSetText "Type : Délit  (touchez pour changer)";
	};
	_visuel ctrlCommit 0;
}];

// --- Champ Lieu ---
_cadre = _Telephone_Base ctrlCreate ["RscText",-1,_telephone_Cadre_Base];
_cadre ctrlSetPosition [0.09,0.44,0.42,0.075];
_cadre ctrlSetBackgroundColor [1,1,1,0.08];
_cadre ctrlCommit 0;

_edit = _Telephone_Base ctrlCreate ["MRP_Telephone_RscEdit_Cadre_Invisible",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Tel_TAJ_Ajout_Champ_Lieu",_edit];
_edit ctrlSetPosition [0.105,0.453,0.39,0.05];
_edit ctrlSetFont "SFUIDisplay_46";
_edit ctrlSetFontHeight 0.048;
_edit ctrlSetTextColor [1,1,1,0.4];
_edit ctrlSetText "Lieu";
_edit ctrlCommit 0;

_edit ctrlAddEventHandler ["SetFocus",{params ["_control"]; if (ctrlText _control isEqualTo "Lieu") then {_control ctrlSetText "";}; _control ctrlSetTextColor [1,1,1,1];}];
_edit ctrlAddEventHandler ["Killfocus",{params ["_control"]; if (ctrlText _control isEqualTo "") then {_control ctrlSetTextColor [1,1,1,0.4]; _control ctrlSetText "Lieu";};}];
_edit ctrlAddEventHandler ["Keydown",{params ["_control"]; [_control,40] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;}];

// --- Champ Date ---
_cadre = _Telephone_Base ctrlCreate ["RscText",-1,_telephone_Cadre_Base];
_cadre ctrlSetPosition [0.09,0.53,0.42,0.075];
_cadre ctrlSetBackgroundColor [1,1,1,0.08];
_cadre ctrlCommit 0;

_edit = _Telephone_Base ctrlCreate ["MRP_Telephone_RscEdit_Cadre_Invisible",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Tel_TAJ_Ajout_Champ_Date",_edit];
_edit ctrlSetPosition [0.105,0.543,0.39,0.05];
_edit ctrlSetFont "SFUIDisplay_46";
_edit ctrlSetFontHeight 0.048;
_edit ctrlSetTextColor [1,1,1,0.4];
_edit ctrlSetText "Date (ex: 12/08/2026)";
_edit ctrlCommit 0;

_edit ctrlAddEventHandler ["SetFocus",{params ["_control"]; if (ctrlText _control isEqualTo "Date (ex: 12/08/2026)") then {_control ctrlSetText "";}; _control ctrlSetTextColor [1,1,1,1];}];
_edit ctrlAddEventHandler ["Killfocus",{params ["_control"]; if (ctrlText _control isEqualTo "") then {_control ctrlSetTextColor [1,1,1,0.4]; _control ctrlSetText "Date (ex: 12/08/2026)";};}];
_edit ctrlAddEventHandler ["Keydown",{params ["_control"]; [_control,20] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;}];

// --- Champ Infraction ---
_cadre = _Telephone_Base ctrlCreate ["RscText",-1,_telephone_Cadre_Base];
_cadre ctrlSetPosition [0.09,0.62,0.42,0.32];
_cadre ctrlSetBackgroundColor [1,1,1,0.08];
_cadre ctrlCommit 0;

_edit = _Telephone_Base ctrlCreate ["MRP_RscEditMulti",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Tel_TAJ_Ajout_Champ_Infra",_edit];
_edit ctrlSetPosition [0.105,0.633,0.39,0.294];
_edit ctrlSetFont "SFUIDisplay_46";
_edit ctrlSetBackgroundColor [0,0,0,0];
_edit ctrlSetFontHeight 0.048;
_edit ctrlSetTextColor [1,1,1,0.4];
_edit ctrlSetText "Détail de l'infraction";
_edit ctrlCommit 0;

_edit ctrlAddEventHandler ["SetFocus",{params ["_control"]; if (ctrlText _control isEqualTo "Détail de l'infraction") then {_control ctrlSetText "";}; _control ctrlSetTextColor [1,1,1,1];}];
_edit ctrlAddEventHandler ["Killfocus",{params ["_control"]; if (ctrlText _control isEqualTo "") then {_control ctrlSetTextColor [1,1,1,0.4]; _control ctrlSetText "Détail de l'infraction";};}];
_edit ctrlAddEventHandler ["Keydown",{params ["_control"]; [_control,300] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;}];

// Bouton Créer (pleine largeur, bien visible)
private _pos_Creer = [0.09,0.97,0.42,0.08];

private _visuel_Creer = _Telephone_Base ctrlCreate ["RscText",-1,_telephone_Cadre_Base];
_visuel_Creer ctrlSetPosition _pos_Creer;
_visuel_Creer ctrlSetBackgroundColor [0.15,0.45,0.85,1];
_visuel_Creer ctrlSetText "Créer la fiche";
_visuel_Creer ctrlSetTextColor [1,1,1,1];
_visuel_Creer ctrlSetFontHeight 0.05;
_visuel_Creer ctrlSetShadow 0;
_visuel_Creer ctrlSetFont "SFUIDisplay_46";
_visuel_Creer ctrlCommit 0;

private _ctrlCreer = _Telephone_Base ctrlCreate ["MRP_Bouton",-1,_telephone_Cadre_Base];
_ctrlCreer ctrlSetPosition _pos_Creer;
_ctrlCreer ctrlCommit 0;
_ctrlCreer setvariable ["_visuel",_visuel_Creer];

_ctrlCreer ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	private _visuel = _control getvariable ["_visuel",controlNull];
	[_visuel] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;
	playsound "MRP_Telephone_Touche_Appli";
	[] call MRPV2_fnc_MRP_Tel_Menu_TAJ_Action_Ajouter;
}];

// Bouton retour menu principal
[] call MRPV2_fnc_MRP_Tel_Menu_Principal_Action_Retour;

TRUE
// };
