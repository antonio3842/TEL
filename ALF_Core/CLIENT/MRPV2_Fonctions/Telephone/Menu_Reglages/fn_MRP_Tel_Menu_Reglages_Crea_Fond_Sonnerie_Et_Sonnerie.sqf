// MRPV2_fnc_MRP_Tel_Menu_Reglages_Crea_Fond_Sonnerie_Et_Sonnerie = {
private _type = param [0,""];


private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _Telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];
private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];

_Telephone_Fond ctrlSetText "MRP_icone_tel\Data\Menu_Reglages\Menu_Reglages_dxt5.paa";

// Bouton retour Reglage en haut a gauche
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.005,0.125,0.12,0.04];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetTextColor [0.8,0.8,0.8,1];
_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_SMS\Menu_SMS_Fleche_Retour_dxt5.paa";

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	[_control] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;

	playsound "MRP_Telephone_Touche_Appli";

	[] spawn
	{
		sleep 0.2;

		[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Son;

		[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
		[] call MRPV2_fnc_MRP_Tel_Menu_Reglages_Crea;
	};
}];

private _Telephone_Reglage_Base_Cadre_Ecran_Scrollable = _Telephone_Base ctrlCreate ["RscControlsGroupNoScrollbars",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Telephone_Reglage_Base_Cadre_Ecran_Scrollable",_Telephone_Reglage_Base_Cadre_Ecran_Scrollable];
_Telephone_Reglage_Base_Cadre_Ecran_Scrollable ctrlSetPosition [0,0.226,0.56,1.07];
_Telephone_Reglage_Base_Cadre_Ecran_Scrollable ctrlSetBackgroundColor [0,0,0,0.3];
_Telephone_Reglage_Base_Cadre_Ecran_Scrollable ctrlCommit 0;

private _telephone_Configuration = profileNamespace getvariable ["MRP_Telephone_Configuration",[]];

if (_type isEqualTo "Fond") then
{
	private _liste_Fond_Ecran = flatten (_telephone_Configuration # 5);
	private _permission_Joueur = [] call MRPV2_fnc_MRP_NB_Service_Vers_TXT;

	if ("MRP_Item_Neogend" in str (assignedItems player)) then
	{
		if (_permission_Joueur in ["CIV","ENT","PREF"]) exitwith {_liste_Fond_Ecran = ["Neogend_Fond_Neutre"];};
		if (_permission_Joueur isEqualTo "GN") exitwith {_liste_Fond_Ecran = ["Neogend_Fond_GN_1","Neogend_Fond_GN_2","Neogend_Fond_GN_3"];};
		if (_permission_Joueur isEqualTo "SP") exitwith {_liste_Fond_Ecran = ["Neogend_Fond_SP_1","Neogend_Fond_SP_2","Neogend_Fond_SP_3"];};
		if (_permission_Joueur isEqualTo "AP") then {_liste_Fond_Ecran = ["Neogend_Fond_AP_1","Neogend_Fond_AP_2","Neogend_Fond_AP_3"];};
	};

	// Perso pour le moment supprimer jusqua systeme de fond decran perso integré
	_liste_Fond_Ecran = _liste_Fond_Ecran - ["Perso"];

	{
		[_x,_foreachindex] call MRPV2_fnc_MRP_Tel_Menu_Reglages_Crea_Fond;
	} foreach _liste_Fond_Ecran;
} else
{
	private _liste_Sonnerie = flatten (_telephone_Configuration # 6);

	{
		[_x,_foreachindex] call MRPV2_fnc_MRP_Tel_Menu_Reglages_Crea_Fond_Sonnerie;
	} foreach _liste_Sonnerie;
};

// Bouton retour menu principal
[] call MRPV2_fnc_MRP_Tel_Menu_Principal_Action_Retour;

TRUE
// };