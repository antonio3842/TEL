// MRPV2_fnc_MRP_Tel_Menu_CA_Ajout_Cadre_Appel = {
private _numero = param [0,""];
private _duree_Appel = param [1,0];
private _etat_Appel = param [2,""];
private _compteur_Verticale = param [3,0];
private _id_Appelant = param [4,0];
private _numero_Masquer = param [5,FALSE];
private _mode_Entreprise = param [6,FALSE];


private _ecart_Taille_Cadre = (0.1 * _compteur_Verticale);
private _ecart_Entre_Cadre = (0.02 * _compteur_Verticale);
private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];

private _ctrl_Liste_Controle_Canaux = uiNamespace getVariable ["MRP_Telephone_Menu_CA_ctrl_Liste_Controle_Canaux",controlNull];
private _CG_CORG_Appel = _Telephone_Base ctrlCreate ["RscControlsGroupNoScrollbars",-1,_ctrl_Liste_Controle_Canaux];
_CG_CORG_Appel ctrlSetPixelPrecision 2;
_CG_CORG_Appel ctrlSetPosition [0.03,_ecart_Taille_Cadre + _ecart_Entre_Cadre,0.42,0.1];
_CG_CORG_Appel ctrlsetfade 1;
_CG_CORG_Appel ctrlCommit 0;
_CG_CORG_Appel ctrlsetfade 0;
_CG_CORG_Appel ctrlCommit 0.3;
_CG_CORG_Appel ctrlsettooltip _numero;
_CG_CORG_Appel ctrlSetTooltipColorText [1,0,0,0];
_CG_CORG_Appel ctrlSetTooltipColorShade [1,0,0,0];
_CG_CORG_Appel ctrlSetTooltipColorBox [1,0,0,0];

// Fond
private _RscBackground = _Telephone_Base ctrlCreate ["RscBackground",-1,_CG_CORG_Appel];
_RscBackground ctrlenable false;
_RscBackground ctrlSetPosition [0,0,0.42,0.1];
_RscBackground ctrlSetPixelPrecision 2;
_RscBackground ctrlSetBackgroundColor [0,0,0,0.3];
_RscBackground ctrlCommit 0;
_CG_CORG_Appel setvariable ["_RscBackground",_RscBackground];

// Cadre CORG
private _Rscframe = _Telephone_Base ctrlCreate ["Rscframe",-1,_CG_CORG_Appel];
_Rscframe ctrlenable false;
_Rscframe ctrlsettextcolor [1,1,1,1];
_Rscframe ctrlSetPosition [0.001,0.001,0.419,0.099];
_Rscframe ctrlSetPixelPrecision 2;
_Rscframe ctrlCommit 0;
_Rscframe ctrlsettooltip _numero;
_Rscframe ctrlSetTooltipColorText [1,0,0,0];
_Rscframe ctrlSetTooltipColorShade [1,0,0,0];
_Rscframe ctrlSetTooltipColorBox [1,0,0,0];

[] call
{
	if (_etat_Appel isEqualTo "Appel") exitwith {_Rscframe ctrlsettextcolor [0,1,0,1];};
	if (_etat_Appel isEqualTo "Pause") then {_Rscframe ctrlsettextcolor [0.9,0.38,0.16,1];};
};

// Numero Appelant
_edit_Texte = _Telephone_Base ctrlCreate ["MRP_Structured_Text",-1,_CG_CORG_Appel];
_edit_Texte ctrlenable false;
_edit_Texte ctrlSetPosition [0,0.03,0.4,0.04];
_edit_Texte ctrlCommit 0;
_edit_Texte ctrlSetTextColor [1,1,1,1];

if (_numero_Masquer) then
{
	_edit_Texte ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_46' shadow='1.5' color='#ffffff' size='1' align='left'>%1</t>","Numéro inconnu"];
} else
{
	private _est_Entreprise_Civil = ([] call MRPV2_fnc_MRP_NB_Service_Vers_TXT) isequalto "ENT";
	private _intituler = _numero;

	if (_est_Entreprise_Civil) then
	{
		_intituler = [_numero] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Intituler;
	} else
	{
		_intituler = _numero insert [2," "];
		_intituler = _intituler insert [5," "];
		_intituler = _intituler insert [8," "];
		_intituler = _intituler insert [11," "];
		
		if (_mode_Entreprise) then
		{
			private _joueur_Destinataire = (allplayers select {_x getvariable ["phoneNumber",""] isEqualTo (_numero)}) # 0;
			_intituler = _joueur_Destinataire getVariable ["entreprise",""];
		};
	};

	_edit_Texte ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_46' shadow='1.5' color='#ffffff' size='1' align='left'>%1</t>",_intituler];
};

// Durée appel
_edit = _Telephone_Base ctrlCreate ["MRP_Structured_Text",-1,_CG_CORG_Appel];
_edit ctrlenable false;
_edit ctrlSetPosition [0.3,0.03,0.15,0.04];
_edit ctrlCommit 0;
_edit ctrlsettooltip "Durée " + str _duree_Appel;
_edit ctrlSetTooltipColorText [1,0,0,0];
_edit ctrlSetTooltipColorShade [1,0,0,0];
_edit ctrlSetTooltipColorBox [1,0,0,0];
_edit ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_46' shadow='1.5' color='#ffffff' size='1' align='left'>%1</t>","00:00:00"];

// Bouton Cadres
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_Bouton",-1,_CG_CORG_Appel];
_ctrlButton ctrlSetPosition [0,0,0.42,0.1];
_ctrlButton ctrlCommit 0;
_ctrlButton setvariable ["_CG_CORG_Appel",_CG_CORG_Appel];
_ctrlButton setvariable ["_Rscframe",_Rscframe];
_ctrlButton setvariable ["_numero",_numero];
_ctrlButton setvariable ["_id_Appelant",[_id_Appelant]];

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_ctrl"];
	playsound "MRP_Telephone_Touche_Appli";

	[_ctrl,0.4] spawn MRP_Gestion_Anti_Spam_Bouton;
	[_ctrl] call MRPV2_fnc_MRP_Tel_Menu_CA_Crea_CG_Actions;
}];

TRUE
// };