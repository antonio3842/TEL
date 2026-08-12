// MRPV2_fnc_MRP_Tel_Menu_Reglages_Crea_Fond_Sonnerie = {
private _sonnerie = param [0,""];
private _foreachindex = param [1,0];


private _splitstring_Foreachindex = (str(_foreachindex) splitstring "");
private _dernier_Chiffre_Foreachindex = _splitstring_Foreachindex # ((count _splitstring_Foreachindex) - 1);

private _pos_Y = (floor (_foreachindex / 2)) * 0.5;
private _pos_X = 0;

if (_dernier_Chiffre_Foreachindex in ["1","3","5","7","9"]) then
{
	_pos_X = (_foreachindex min 1) * 0.23;
};

private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _Telephone_Reglage_Base_Cadre_Ecran_Scrollable = uiNamespace getVariable ["MRP_Telephone_Reglage_Base_Cadre_Ecran_Scrollable",controlNull];
private _Telephone_Reglage_Cadre_Fond = _Telephone_Base ctrlCreate ["RscControlsGroupNoScrollbars",-1,_Telephone_Reglage_Base_Cadre_Ecran_Scrollable];
_Telephone_Reglage_Cadre_Fond ctrlSetPosition [0.06 + _pos_X,0.01 + _pos_Y,0.2,0.55];
_Telephone_Reglage_Cadre_Fond ctrlCommit 0;

private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_Telephone_Reglage_Cadre_Fond];
_ctrlButton ctrlSetPosition [-0.17,0,0.55,0.4];
_ctrlButton ctrlSetText "MRP_Telephones\Data\Menu_Reglages\Fond_Sonnerie_dxt5.paa";
_ctrlButton ctrlSetTextColor [0.85,0.85,0.85,1];
_ctrlButton ctrlCommit 0;
_ctrlButton setVariable ["_sonnerie",_sonnerie];

_ctrlButton ctrlAddEventHandler ["MouseEnter",
{params ["_control"];
	[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Son;

	private _sonnerie = _control getvariable ["_sonnerie","Erreur"];
	playsound ("MRP_Telephone_Sonnerie_" + _sonnerie);
}];

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	[_control] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;

	playsound "MRP_Telephone_Touche_Appli";

	[_control] spawn
	{params ["_control"];
		sleep 0.2;

		private _telephone_Configuration = profileNamespace getvariable ["MRP_Telephone_Configuration",[]];
		private _sonnerie = _control getvariable ["_sonnerie","Erreur"];
		_control setVariable ["_sonnerie",nil];

		[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Son;

		_telephone_Configuration set [4,_sonnerie];

		[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
		[] call MRPV2_fnc_MRP_Tel_Menu_Reglages_Crea;
	};
}];

// Titre
private _ctrl_Image = _Telephone_Base ctrlCreate ["RscStructuredText",-1,_Telephone_Reglage_Cadre_Fond];
_ctrl_Image ctrlSetPosition [0,0.41,0.21,0.04];
_ctrl_Image ctrlSetScale 0.9;
_ctrl_Image ctrlCommit 0;

private _titre = _sonnerie regexReplace ["MRP_Telephone_Sonnerie_",""];

_ctrl_Image ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_20' shadow='0' color='#000000' size='1' align='center'>%1</t>",_titre];

TRUE
// };