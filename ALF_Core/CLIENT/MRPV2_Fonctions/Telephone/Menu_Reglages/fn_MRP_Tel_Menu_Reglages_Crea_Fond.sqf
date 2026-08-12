// MRPV2_fnc_MRP_Tel_Menu_Reglages_Crea_Fond = {
private _fond = param [0,""];
private _foreachindex = param [1,0];

private _splitstring_Foreachindex = (str(_foreachindex) splitstring "");
private _dernier_Chiffre_Foreachindex = _splitstring_Foreachindex # ((count _splitstring_Foreachindex) - 1);

private _pos_Y = (floor (_foreachindex / 2)) * 0.58;
private _pos_X = 0;

if (_dernier_Chiffre_Foreachindex in ["1","3","5","7","9"]) then {_pos_X = (_foreachindex min 1) * 0.23;};

private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _Telephone_Reglage_Base_Cadre_Ecran_Scrollable = uiNamespace getVariable ["MRP_Telephone_Reglage_Base_Cadre_Ecran_Scrollable",controlNull];
private _Telephone_Reglage_Cadre_Fond = _Telephone_Base ctrlCreate ["RscControlsGroupNoScrollbars",-1,_Telephone_Reglage_Base_Cadre_Ecran_Scrollable];
_Telephone_Reglage_Cadre_Fond ctrlSetPosition [0.06 + _pos_X,_pos_Y,0.2,0.55];
_Telephone_Reglage_Cadre_Fond ctrlCommit 0;

private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_Telephone_Reglage_Cadre_Fond];
_ctrlButton ctrlSetPosition [-0.17,0,0.55,0.55];
_ctrlButton ctrlSetText "MRP_Telephones\Data\Fond\" + _fond + ".paa";
_ctrlButton ctrlSetTextColor [0.85,0.85,0.85,1];
_ctrlButton ctrlCommit 0;
_ctrlButton setVariable ["_fond",_fond];

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	[_control] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;

	playsound "MRP_Telephone_Touche_Appli";

	[_control] spawn
	{params ["_control"];
		sleep 0.2;

		private _permission_Joueur = [] call MRPV2_fnc_MRP_NB_Service_Vers_TXT;
		private _telephone_Configuration = profileNamespace getvariable ["MRP_Telephone_Configuration",[]];
		private _fond = _control getvariable ["_fond",""];

		if ("MRP_Item_Iphone_12" in str assignedItems player) then
		{
			(_telephone_Configuration # 3) set [0,_fond];
		} else
		{
			if (_permission_Joueur in ["ENT"]) exitwith {};

			(_telephone_Configuration # 3 # 1) set [0,_fond];
			(_telephone_Configuration # 3 # 1) set [1,_permission_Joueur];
		};

		[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
		[] call MRPV2_fnc_MRP_Tel_Menu_Reglages_Crea;
	};
}];

TRUE
// };