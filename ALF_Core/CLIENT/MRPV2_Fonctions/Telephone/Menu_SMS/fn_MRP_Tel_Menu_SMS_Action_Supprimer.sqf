private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _Telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];
private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];

private _Telephone_Cadre_Base_Tentative = _Telephone_Base ctrlCreate ["RscControlsGroupNoScrollbars",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Telephone_Cadre_Base_Tentative",_Telephone_Cadre_Base_Tentative];
_Telephone_Cadre_Base_Tentative ctrlSetPosition [0,0,0.56,1.4];
_Telephone_Cadre_Base_Tentative ctrlSetBackgroundColor [0,0,0,0.3];
_Telephone_Cadre_Base_Tentative ctrlCommit 0;

[_Telephone_Cadre_Base_Tentative] call MRPV2_fnc_MRP_Tel_Divers_Fond_Prompt;

private _fond_Ecran = _Telephone_Base ctrlCreate ["RscPicture",-1,_Telephone_Cadre_Base_Tentative];
_fond_Ecran ctrlSetPosition [0.03,1.08,0.5,0.09];
_fond_Ecran ctrlSetText "MRP_icone_tel\Data\Menu_Principal\Prompt_dxt5.paa";
_fond_Ecran ctrlSetTextColor [0.9,0.9,0.9,1];
_fond_Ecran ctrlCommit 0;

private _texte_Propmt = _Telephone_Base ctrlcreate ["MRP_Structured_Text",-1, _Telephone_Cadre_Base_Tentative];
_texte_Propmt ctrlSetPosition [0.075,1.105,0.41,0.05];
_texte_Propmt ctrlCommit 0;
_texte_Propmt ctrlenable FALSE;
_texte_Propmt ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_20' color='#FF0000' shadow='0' size='1' align='center'>%1</t>","Supprimer la conversation"];

private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_Bouton",-1,_Telephone_Cadre_Base_Tentative];
_ctrlButton ctrlSetPosition [0.06,1.08,0.44,0.09];
_ctrlButton ctrlCommit 0;
_ctrlButton setVariable ["_fond_Supprimer",_fond_Ecran];
ctrlsetfocus _ctrlButton;

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	private _fond_Ecran = _control getvariable "_fond_Supprimer";
	[_fond_Ecran] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;

	playsound "MRP_Telephone_Touche_Appli";

	[_control] spawn
	{params ["_control"];
		sleep 0.2;

		private _telephone_Liste_SMS = profileNamespace getvariable ["MRP_Telephone_Liste_SMS",createhashmap];
		_telephone_Liste_SMS deleteAt MRP_Telephone_Gestion_Numero_Interne;
		profileNamespace setVariable ["MRP_Telephone_Liste_SMS",_telephone_Liste_SMS];

		private _telephone_Configuration = profileNamespace getvariable ["MRP_Telephone_Configuration",[]];
		private _hash_Historique_SMS = _telephone_Configuration # 7;
		_hash_Historique_SMS deleteAt MRP_Telephone_Gestion_Numero_Interne;

		profileNamespace setVariable ["MRP_Telephone_Configuration",_telephone_Configuration];

		[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
		[] call MRPV2_fnc_MRP_Tel_Menu_SMS_Crea;
	};
}];

_ctrlButton ctrlAddEventHandler ["MouseEnter",
{params ["_control"];
	private _fond_Supprimer = _control getvariable "_fond_Supprimer";
	_fond_Supprimer ctrlSetTextColor [1,1,1,1];
}];

_ctrlButton ctrlAddEventHandler ["MouseExit",
{params ["_control"];
	private _fond_Supprimer = _control getvariable "_fond_Supprimer";
	_fond_Supprimer ctrlSetTextColor [0.9,0.9,0.9,1];
}];

private _fond_Ecran = _Telephone_Base ctrlCreate ["RscPicture",-1,_Telephone_Cadre_Base_Tentative];
_fond_Ecran ctrlSetPosition [0.03,1.18,0.5,0.09];
_fond_Ecran ctrlSetText "MRP_icone_tel\Data\Menu_Principal\Prompt_dxt5.paa";
_fond_Ecran ctrlSetTextColor [0.9,0.9,0.9,1];
_fond_Ecran ctrlCommit 0;

private _texte_Propmt = _Telephone_Base ctrlcreate ["MRP_Structured_Text",-1, _Telephone_Cadre_Base_Tentative];
_texte_Propmt ctrlSetPosition [0.075,1.205,0.41,0.05];
_texte_Propmt ctrlCommit 0;
_texte_Propmt ctrlenable FALSE;
_texte_Propmt ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_20' color='#006afe' shadow='0' size='1' align='center'>%1</t>","Annuler"];

private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_Bouton",-1,_Telephone_Cadre_Base_Tentative];
_ctrlButton ctrlSetPosition [0.06,1.18,0.44,0.09];
_ctrlButton ctrlCommit 0;
_ctrlButton setVariable ["_fond_Annuler",_fond_Ecran];

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	private _fond_Annuler = _control getvariable "_fond_Annuler";
	[_fond_Annuler] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;

	playsound "MRP_Telephone_Touche_Appli";

	[] spawn
	{
		sleep 0.2;

		private _Telephone_Cadre_Base_Tentative = uiNamespace getVariable ["MRP_Telephone_Cadre_Base_Tentative",controlNull];
		ctrlDelete _Telephone_Cadre_Base_Tentative;
	};
}];

_ctrlButton ctrlAddEventHandler ["MouseEnter",
{params ["_control"];
	private _fond_Ecran = _control getvariable "_fond_Annuler";
	_fond_Ecran ctrlSetTextColor [1,1,1,1];
}];

_ctrlButton ctrlAddEventHandler ["MouseExit",
{params ["_control"];
	private _fond_Ecran = _control getvariable "_fond_Annuler";
	_fond_Ecran ctrlSetTextColor [0.9,0.9,0.9,1];
}];

TRUE