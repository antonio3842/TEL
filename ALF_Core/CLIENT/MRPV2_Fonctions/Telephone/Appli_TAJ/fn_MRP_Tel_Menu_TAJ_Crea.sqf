// MRPV2_fnc_MRP_Tel_Menu_TAJ_Crea = {
private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _Telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];
private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];

_Telephone_Fond ctrlSetText "MRP_icone_tel\Data\Fond\Neogend_Fond_PC_Storm_Vide.paa";

// Titre
private _titre = _Telephone_Base ctrlCreate ["RscStructuredText",-1,_telephone_Cadre_Base];
_titre ctrlSetPosition [0.09,0.09,0.25,0.07];
_titre ctrlCommit 0;
_titre ctrlSetStructuredText parseText "<t font='SFUIDisplay_20' shadow='0' color='#ffffff' size='1.7' align='left'>TAJ</t>";

// Bouton ajout (RscText visuel + MRP_Bouton invisible superposé)
private _pos_Bouton_Ajout = [0.35,0.098,0.15,0.055];

private _visuel_Ajout = _Telephone_Base ctrlCreate ["RscText",-1,_telephone_Cadre_Base];
_visuel_Ajout ctrlSetPosition _pos_Bouton_Ajout;
_visuel_Ajout ctrlSetBackgroundColor [0.15,0.45,0.85,1];
_visuel_Ajout ctrlSetText "+ Ajouter";
_visuel_Ajout ctrlSetTextColor [1,1,1,1];
_visuel_Ajout ctrlSetFontHeight 0.042;
_visuel_Ajout ctrlSetShadow 0;
_visuel_Ajout ctrlSetFont "SFUIDisplay_46";
_visuel_Ajout ctrlCommit 0;

private _ctrlAjout = _Telephone_Base ctrlCreate ["MRP_Bouton",-1,_telephone_Cadre_Base];
_ctrlAjout ctrlSetPosition _pos_Bouton_Ajout;
_ctrlAjout ctrlCommit 0;
_ctrlAjout setvariable ["_visuel",_visuel_Ajout];

_ctrlAjout ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	private _visuel = _control getvariable ["_visuel",controlNull];
	[_visuel] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;
	playsound "MRP_Telephone_Touche_Appli";
	[] spawn
	{
		sleep 0.2;
		[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
		[] call MRPV2_fnc_MRP_Tel_Menu_TAJ_Crea_Ajout;
	};
}];

// Carte champ recherche (nom)
private _cadre_Champ = _Telephone_Base ctrlCreate ["RscText",-1,_telephone_Cadre_Base];
_cadre_Champ ctrlSetPosition [0.09,0.17,0.41,0.075];
_cadre_Champ ctrlSetBackgroundColor [1,1,1,0.08];
_cadre_Champ ctrlCommit 0;

private _edit = _Telephone_Base ctrlCreate ["MRP_Telephone_RscEdit_Cadre_Invisible",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Tel_TAJ_Champ_Recherche",_edit];
_edit ctrlSetPosition [0.105,0.183,0.35,0.05];
_edit ctrlSetBackgroundColor [0,0,0,0];
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
	if (ctrlText _control isEqualTo "") then
	{
		_control ctrlSetTextColor [1,1,1,0.4];
		_control ctrlSetText "Nom de la personne";
	};
}];

_edit ctrlAddEventHandler ["Keydown",
{params ["_control"];
	[_control,30] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;
}];

_edit ctrlAddEventHandler ["KeyUp",
{params ["_control","_key"];
	if (_key isEqualTo 28) then {[] call MRPV2_fnc_MRP_Tel_Menu_TAJ_Action_Rechercher;};
}];

// Bouton RECHERCHER (RscText visuel + MRP_Bouton invisible superposé)
private _pos_Bouton_Rech = [0.09,0.26,0.41,0.065];

private _visuel_Rech = _Telephone_Base ctrlCreate ["RscText",-1,_telephone_Cadre_Base];
_visuel_Rech ctrlSetPosition _pos_Bouton_Rech;
_visuel_Rech ctrlSetBackgroundColor [0.15,0.45,0.85,1];
_visuel_Rech ctrlSetText "RECHERCHER";
_visuel_Rech ctrlSetTextColor [1,1,1,1];
_visuel_Rech ctrlSetFontHeight 0.045;
_visuel_Rech ctrlSetShadow 0;
_visuel_Rech ctrlSetFont "SFUIDisplay_46";
_visuel_Rech ctrlCommit 0;

private _ctrlButtonRech = _Telephone_Base ctrlCreate ["MRP_Bouton",-1,_telephone_Cadre_Base];
_ctrlButtonRech ctrlSetPosition _pos_Bouton_Rech;
_ctrlButtonRech ctrlCommit 0;
_ctrlButtonRech setvariable ["_visuel",_visuel_Rech];

_ctrlButtonRech ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	private _visuel = _control getvariable ["_visuel",controlNull];
	[_visuel] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;
	playsound "MRP_Telephone_Touche_Appli";
	[] call MRPV2_fnc_MRP_Tel_Menu_TAJ_Action_Rechercher;
}];

// Zone détail (lieu + infraction de la fiche sélectionnée)
private _cadre_Detail = _Telephone_Base ctrlCreate ["RscText",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Tel_TAJ_Cadre_Detail",_cadre_Detail];
_cadre_Detail ctrlSetPosition [0.09,0.345,0.41,0.22];
_cadre_Detail ctrlSetBackgroundColor [1,1,1,0.08];
_cadre_Detail ctrlShow false;
_cadre_Detail ctrlCommit 0;

private _detail = _Telephone_Base ctrlCreate ["RscStructuredText",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Tel_TAJ_Zone_Detail",_detail];
_detail ctrlSetPosition [0.11,0.36,0.36,0.195];
_detail ctrlCommit 0;

// Bouton supprimer la fiche sélectionnée (icône, masqué par défaut)
private _pos_Bouton_Suppr = [0.42,0.358,0.07,0.05];

private _visuel_Suppr = _Telephone_Base ctrlCreate ["RscText",-1,_telephone_Cadre_Base];
_visuel_Suppr ctrlSetPosition _pos_Bouton_Suppr;
_visuel_Suppr ctrlSetBackgroundColor [0.75,0.2,0.2,1];
_visuel_Suppr ctrlSetText "Suppr.";
_visuel_Suppr ctrlSetTextColor [1,1,1,1];
_visuel_Suppr ctrlSetFontHeight 0.035;
_visuel_Suppr ctrlSetShadow 0;
_visuel_Suppr ctrlSetFont "SFUIDisplay_46";
_visuel_Suppr ctrlShow false;
_visuel_Suppr ctrlCommit 0;

private _ctrlSupprimer = _Telephone_Base ctrlCreate ["MRP_Bouton",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Tel_TAJ_Bouton_Supprimer",_ctrlSupprimer];
_ctrlSupprimer ctrlSetPosition _pos_Bouton_Suppr;
_ctrlSupprimer ctrlShow false;
_ctrlSupprimer ctrlCommit 0;
_ctrlSupprimer setvariable ["_visuel",_visuel_Suppr];

_ctrlSupprimer ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	private _visuel = _control getvariable ["_visuel",controlNull];
	[_visuel] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;
	playsound "MRP_Telephone_Touche_Appli";
	[] call MRPV2_fnc_MRP_Tel_Menu_TAJ_Action_Supprimer;
}];

// Zone résultat / liste
private _tv = _Telephone_Base ctrlCreate ["RscControlsGroupNoScrollbars",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Tel_TAJ_Zone_Liste",_tv];
_tv ctrlSetPosition [0.09,0.6,0.42,0.6];
_tv ctrlCommit 0;

private _vide = _Telephone_Base ctrlcreate ["RscStructuredText",-1,_tv];
_vide ctrlSetPosition [0.1,0.02,0.4,0.08];
_vide ctrlCommit 0;
_vide ctrlSetStructuredText parseText "<t font='SFUIDisplay_20' shadow='0' color='#8fa3bf' size='1' align='left'>Recherchez un nom pour afficher son casier.</t>";

// Bouton retour menu principal
[] call MRPV2_fnc_MRP_Tel_Menu_Principal_Action_Retour;

TRUE
// };
