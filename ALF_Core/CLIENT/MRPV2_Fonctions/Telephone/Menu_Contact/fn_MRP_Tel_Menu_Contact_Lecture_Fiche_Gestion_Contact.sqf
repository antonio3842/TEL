// MRPV2_fnc_MRP_Tel_Menu_Contact_Lecture_Fiche_Gestion_Contact = {
private _action = param [0,""];


private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];

private _Telephone_Cadre_Base_Tentative = _Telephone_Base ctrlCreate ["RscControlsGroupNoScrollbars",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Telephone_Cadre_Base_Tentative",_Telephone_Cadre_Base_Tentative];
_Telephone_Cadre_Base_Tentative ctrlSetPosition [0,0,0.56,1.4];
_Telephone_Cadre_Base_Tentative ctrlSetBackgroundColor [0,0,0,0.3];
_Telephone_Cadre_Base_Tentative ctrlCommit 0;

[_Telephone_Cadre_Base_Tentative] call MRPV2_fnc_MRP_Tel_Divers_Fond_Prompt;

private _fond_Ecran = _Telephone_Base ctrlCreate ["RscPicture",-1,_Telephone_Cadre_Base_Tentative];
_fond_Ecran ctrlSetPosition [0.03,1.08,0.5,0.09];
_fond_Ecran ctrlSetText "MRP_Telephones\Data\Menu_Principal\Prompt_dxt5.paa";
_fond_Ecran ctrlSetTextColor [0.9,0.9,0.9,1];
_fond_Ecran ctrlCommit 0;

private _texte_Propmt = _Telephone_Base ctrlcreate ["MRP_Structured_Text",-1, _Telephone_Cadre_Base_Tentative];
_texte_Propmt ctrlSetPosition [0.075,1.105,0.41,0.05];
_texte_Propmt ctrlCommit 0;
_texte_Propmt ctrlenable FALSE;

[] call
{
	if (_action isEquaLTo "Bloquer") exitwith
	{
		private _liste_Contact = profileNamespace getvariable ["MRP_Telephone_Liste_Contact",createhashmap];
		private _info_Contact = _liste_Contact get MRP_Telephone_Gestion_Numero_Interne;
		private _contact_Est_Bloquer = _info_Contact # 5;

		if (_contact_Est_Bloquer) then
		{
			_texte_Propmt ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_20' color='#FF0000' shadow='0' size='1' align='center'>%1</t>","Débloquer le contact"];
		} else
		{
			_texte_Propmt ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_20' color='#FF0000' shadow='0' size='1' align='center'>%1</t>","Bloquer le contact"];
		};
	};

	if (_action isEquaLTo "Supprimer") exitwith
	{
		_texte_Propmt ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_20' color='#FF0000' shadow='0' size='1' align='center'>%1</t>","Supprimer le contact"];
	};

	if (_action isEquaLTo "Supprimer Historique") then
	{
		_texte_Propmt ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_20' color='#FF0000' shadow='0' size='1' align='center'>Supprimer l%1historique</t>",''''];
	};
};

private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_Bouton",-1,_Telephone_Cadre_Base_Tentative];
_ctrlButton ctrlSetPosition [0.06,1.08,0.44,0.09];
_ctrlButton ctrlCommit 0;
_ctrlButton setVariable ["_fond_Supprimer",_fond_Ecran];
_ctrlButton setVariable ["_action",_action];
ctrlsetfocus _ctrlButton;

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	private _fond_Supprimer = _control getvariable ["_fond_Supprimer",controlNull];

	[_fond_Supprimer] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;

	playsound "MRP_Telephone_Touche_Appli";

	private _action = _control getvariable ["_action",""];
	[_action] spawn
	{params ["_action"];
		sleep 0.2;

		[] call 
		{
			if (_action isEquaLTo "Bloquer") exitwith
			{
				private _liste_Contact = profileNamespace getvariable ["MRP_Telephone_Liste_Contact",createhashmap];
				private _info_Contact = _liste_Contact get MRP_Telephone_Gestion_Numero_Interne;
				private _contact_Est_Bloquer = _info_Contact # 5;
				private _bouton_Bloquage = uiNamespace getVariable ["MRP_Telephone_Menu_Contact_Bouton_Bloquage",controlNull];

				if (_contact_Est_Bloquer) then
				{
					_info_Contact set [5,FALSE];
					_bouton_Bloquage ctrlSetText "MRP_Telephones\Data\Menu_Contact\Icone_Bloquer_dxt5.paa";
					_bouton_Bloquage ctrlSetPosition [0.035,0.19,0.11,0.05];
				} else
				{
					_info_Contact set [5,TRUE];
					_bouton_Bloquage ctrlSetText "MRP_Telephones\Data\Menu_Contact\Icone_Debloquer_dxt5.paa";
					_bouton_Bloquage ctrlSetPosition [0.045,0.19,0.11,0.05];
				};

				_bouton_Bloquage ctrlCommit 0;
			};

			if (_action isEquaLTo "Supprimer") exitwith
			{
				private _liste_Contact = profileNamespace getvariable ["MRP_Telephone_Liste_Contact",createhashmap];

				_liste_Contact deleteAt MRP_Telephone_Gestion_Numero_Interne;
				MRP_Telephone_Gestion_Numero_Interne = nil;

				profileNamespace setVariable ["MRP_Telephone_Liste_Contact",_liste_Contact];

				[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
				[] call MRPV2_fnc_MRP_Tel_Menu_Contact_Crea;
			};

			if (_action isEquaLTo "Supprimer Historique") then
			{
				profileNamespace setVariable ["MRP_Telephone_Liste_Historique",[]];

				[] call MRPV2_fnc_MRP_Tel_Menu_Historique_Crea_Liste;
			};
		};
		
		private _Telephone_Cadre_Base_Tentative = uiNamespace getVariable ["MRP_Telephone_Cadre_Base_Tentative",controlNull];
		ctrlDelete _Telephone_Cadre_Base_Tentative;
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
_fond_Ecran ctrlSetText "MRP_Telephones\Data\Menu_Principal\Prompt_dxt5.paa";
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
	playsound "MRP_Telephone_Touche_Appli";

	private _fond_Ecran = _control getvariable ["_fond_Annuler",controlNull];
	[_fond_Ecran] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;

	[] spawn
	{
		sleep 0.2;

		private _Telephone_Cadre_Base_Tentative = uiNamespace getVariable ["MRP_Telephone_Cadre_Base_Tentative",controlNull];
		ctrlDelete _Telephone_Cadre_Base_Tentative;
	};
}];

_ctrlButton ctrlAddEventHandler ["MouseEnter",
{params ["_control"];
	private _fond_Ecran = _control getvariable ["_fond_Annuler",controlNull];
	_fond_Ecran ctrlSetTextColor [1,1,1,1];
}];

_ctrlButton ctrlAddEventHandler ["MouseExit",
{params ["_control"];
	private _fond_Ecran = _control getvariable ["_fond_Annuler",controlNull];
	_fond_Ecran ctrlSetTextColor [0.9,0.9,0.9,1];
}];

TRUE
// };