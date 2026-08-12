// MRPV2_fnc_MRP_Tel_Menu_Principal_Action_Retour = {
private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];
private _Telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];

private _fond = ctrltext _Telephone_Fond;
private _liste_Fond_Menu_Mode_Sombre = ["Fond_Radio_dxt5","Neogend_Fond_PC_Storm","Neogend_Fond_SP_Vide"];
private _mode_Sombre = FALSE;

{
	if (_x in _fond) exitwith {_mode_Sombre = TRUE;};
} foreach _liste_Fond_Menu_Mode_Sombre;

// Bouton retour menu principal
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText_Inverser",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Telephone_Menu_Principal_Bouton_Retour",_ctrlButton];
_ctrlButton ctrlSetPosition [0.13,1.33,0.3,0.02];

if (_mode_Sombre) then
{
	_ctrlButton ctrlSetText "MRP_Telephones\Data\Menu_Principal\Barre_Retour_Menu_Blanche.paa";
} else
{
	_ctrlButton ctrlSetText "MRP_Telephones\Data\Menu_Principal\Barre_Retour_Menu.paa";
};

_ctrlButton ctrlCommit 0;

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_ctrl"];
	playsound "MRP_Telephone_Touche_Appli";

	[_ctrl] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;

	[] spawn
	{
		sleep 0.2;

		private _telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];		
		private _fond = ctrltext _Telephone_Fond;

		private _adresse_Fond_Appel = "MRP_Telephones\Data\Menu_Appel\Fond_Appel_dxt5.paa";
		if (_fond isequalto _adresse_Fond_Appel) exitwith {};

		private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];
		_telephone_Cadre_Base ctrlRemoveAllEventHandlers "MouseButtonClick";

		if ("Menu_Reglages_dxt5" in ctrltext _Telephone_Fond) then {[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Son;};

		[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
		[] call MRPV2_fnc_MRP_Tel_Menu_Principal_Crea;

		MRP_Telephone_Gestion_Numero_Interne = nil;
		MRP_Telephone_Numero_Appel = nil;
	};
}];

TRUE
// };