// MRPV2_fnc_MRP_Tel_Menu_FPR_Crea_Liste = {
private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _Telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];
private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];

_Telephone_Fond ctrlSetText "MRP_icone_tel\Data\Fond\Neogend_Fond_PC_Storm_Vide.paa";

// Bouton retour à la recherche rapide (RscText visuel + MRP_Bouton invisible superposé)
private _pos_Bouton_Retour = [0.09,0.095,0.13,0.05];

private _visuel_Retour = _Telephone_Base ctrlCreate ["RscText",-1,_telephone_Cadre_Base];
_visuel_Retour ctrlSetPosition _pos_Bouton_Retour;
_visuel_Retour ctrlSetBackgroundColor [1,1,1,0.1];
_visuel_Retour ctrlSetText "Retour";
_visuel_Retour ctrlSetTextColor [1,1,1,1];
_visuel_Retour ctrlSetFontHeight 0.04;
_visuel_Retour ctrlSetShadow 0;
_visuel_Retour ctrlSetFont "SFUIDisplay_46";
_visuel_Retour ctrlCommit 0;

private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_Bouton",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition _pos_Bouton_Retour;
_ctrlButton ctrlCommit 0;
_ctrlButton setvariable ["_visuel",_visuel_Retour];

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
_titre ctrlSetStructuredText parseText "<t font='SFUIDisplay_20' shadow='0' color='#ffffff' size='1.5' align='left'>Liste des recherchés</t>";

// Carte détail (motif de la personne sélectionnée)
private _cadre_Detail = _Telephone_Base ctrlCreate ["RscText",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Tel_FPR_Liste_Cadre_Detail",_cadre_Detail];
_cadre_Detail ctrlSetPosition [0.09,0.24,0.41,0.13];
_cadre_Detail ctrlSetBackgroundColor [1,1,1,0.06];
_cadre_Detail ctrlShow false;
_cadre_Detail ctrlCommit 0;

private _detail = _Telephone_Base ctrlCreate ["RscStructuredText",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Tel_FPR_Liste_Zone_Detail",_detail];
_detail ctrlSetPosition [0.11,0.255,0.33,0.1];
_detail ctrlCommit 0;

// Bouton supprimer (masqué par défaut, visible seulement si sélection + OPJ)
private _pos_Bouton_Suppr = [0.43,0.253,0.06,0.05];

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
uiNamespace setVariable ["MRP_Tel_FPR_Liste_Bouton_Supprimer",_ctrlSupprimer];
_ctrlSupprimer ctrlSetPosition _pos_Bouton_Suppr;
_ctrlSupprimer ctrlShow false;
_ctrlSupprimer ctrlCommit 0;
_ctrlSupprimer setvariable ["_visuel",_visuel_Suppr];

_ctrlSupprimer ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	private _visuel = _control getvariable ["_visuel",controlNull];
	[_visuel] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;
	playsound "MRP_Telephone_Touche_Appli";
	[] call MRPV2_fnc_MRP_Tel_Menu_FPR_Action_Supprimer;
}];

// Zone liste
private _tv = _Telephone_Base ctrlCreate ["RscControlsGroupNoScrollbars",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Tel_FPR_Liste_Zone_Liste",_tv];
_tv ctrlSetPosition [0.09,0.39,0.42,0.81];
_tv ctrlCommit 0;

[player] remoteExec ["ALF_Server_fnc_loadFipSony",2];

// Bouton retour menu principal
[] call MRPV2_fnc_MRP_Tel_Menu_Principal_Action_Retour;

TRUE
// };
