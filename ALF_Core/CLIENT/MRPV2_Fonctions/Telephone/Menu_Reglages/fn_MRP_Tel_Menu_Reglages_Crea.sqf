// MRPV2_fnc_MRP_Tel_Menu_Reglages_Crea = {
private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _Telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];
private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];

_Telephone_Fond ctrlSetText "MRP_Telephones\Data\Menu_Reglages\Menu_reglages.paa";

private _base_Y = 0.496;

// Image Fond Vert Mode avion
private _ctrl_Image_Fond = _Telephone_Base ctrlCreate ["RscPicture",-1,_telephone_Cadre_Base];
_ctrl_Image_Fond ctrlSetPosition [0.4215,_base_Y,0.069,0.09];
_ctrl_Image_Fond ctrlSetText "MRP_Telephones\Data\Menu_Reglages\Petite_icone_reglage_fondvert.paa";
_ctrl_Image_Fond ctrlSetFade 1;
_ctrl_Image_Fond ctrlCommit 0;

// Image Bouton Mode avion
private _ctrl_Image = _Telephone_Base ctrlCreate ["RscPicture",-1,_telephone_Cadre_Base];
_ctrl_Image ctrlSetPosition [0.408,_base_Y,0.069,0.09];
_ctrl_Image ctrlSetText "MRP_Telephones\Data\Menu_Reglages\Petite_icone_reglage_bouton.paa";
_ctrl_Image ctrlCommit 0;

// Bouton Mode avion
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_Bouton",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.05,_base_Y + 0.01,0.46,0.063];
_ctrlButton ctrlCommit 0;
_ctrlButton setVariable ["_Image_Fond_Vert_Avion",_ctrl_Image_Fond];
_ctrlButton setVariable ["_Image_Bouton_Avion",_ctrl_Image];

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	private _Image_Fond_Vert_Avion =  _control getvariable ["_Image_Fond_Vert_Avion",controlNull];
	private _Image_Bouton_Avion = _control getvariable ["_Image_Bouton_Avion",controlNull];

	playsound "MRP_Telephone_Touche_Appli";

	[FALSE,[_Image_Fond_Vert_Avion,_Image_Bouton_Avion],0] call MRPV2_fnc_MRP_Tel_Menu_Reglages_Gestion_Options_Actives;
}];

[TRUE,[_ctrl_Image_Fond,_ctrl_Image],0] call MRPV2_fnc_MRP_Tel_Menu_Reglages_Gestion_Options_Actives;

_base_Y = _base_Y + 0.069;

// Image Fond Vert Mode silencieux
private _ctrl_Image_Fond = _Telephone_Base ctrlCreate ["RscPicture",-1,_telephone_Cadre_Base];
_ctrl_Image_Fond ctrlSetPosition [0.4215,_base_Y,0.069,0.09];
_ctrl_Image_Fond ctrlSetText "MRP_Telephones\Data\Menu_Reglages\Petite_icone_reglage_fondvert.paa";
_ctrl_Image_Fond ctrlSetFade 1;
_ctrl_Image_Fond ctrlCommit 0;

// Image Bouton Mode silencieux
private _ctrl_Image = _Telephone_Base ctrlCreate ["RscPicture",-1,_telephone_Cadre_Base];
_ctrl_Image ctrlSetPosition [0.408,_base_Y,0.069,0.09];
_ctrl_Image ctrlSetText "MRP_Telephones\Data\Menu_Reglages\Petite_icone_reglage_bouton.paa";
_ctrl_Image ctrlCommit 0;

// Bouton Mode silencieux
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_Bouton",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.05,_base_Y + 0.01,0.46,0.063];
_ctrlButton ctrlCommit 0;
_ctrlButton setVariable ["_Image_Fond_Vert_Silencieux",_ctrl_Image_Fond];
_ctrlButton setVariable ["_Image_Bouton_Silencieux",_ctrl_Image];

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	private _Image_Fond_Vert_Silencieux =  _control getvariable ["_Image_Fond_Vert_Silencieux",controlNull];
	private _Image_Bouton_Silencieux = _control getvariable ["_Image_Bouton_Silencieux",controlNull];

	playsound "MRP_Telephone_Touche_Appli";

	[FALSE,[_Image_Fond_Vert_Silencieux,_Image_Bouton_Silencieux],1] call MRPV2_fnc_MRP_Tel_Menu_Reglages_Gestion_Options_Actives;
}];

[TRUE,[_ctrl_Image_Fond,_ctrl_Image],1] call MRPV2_fnc_MRP_Tel_Menu_Reglages_Gestion_Options_Actives;

_base_Y = _base_Y + 0.069;

// Image Fond Vert Cacher numero
private _ctrl_Image_Fond = _Telephone_Base ctrlCreate ["RscPicture",-1,_telephone_Cadre_Base];
_ctrl_Image_Fond ctrlSetPosition [0.4215,_base_Y,0.069,0.09];
_ctrl_Image_Fond ctrlSetText "MRP_Telephones\Data\Menu_Reglages\Petite_icone_reglage_fondvert.paa";
_ctrl_Image_Fond ctrlSetFade 1;
_ctrl_Image_Fond ctrlCommit 0;

// Image Bouton Cacher numero
private _ctrl_Image = _Telephone_Base ctrlCreate ["RscPicture",-1,_telephone_Cadre_Base];
_ctrl_Image ctrlSetPosition [0.408,_base_Y,0.069,0.09];
_ctrl_Image ctrlSetText "MRP_Telephones\Data\Menu_Reglages\Petite_icone_reglage_bouton.paa";
_ctrl_Image ctrlCommit 0;

// Bouton Cacher numero
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_Bouton",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.05,_base_Y + 0.01,0.46,0.063];
_ctrlButton ctrlCommit 0;
_ctrlButton setVariable ["_Image_Fond_Vert_Cacher",_ctrl_Image_Fond];
_ctrlButton setVariable ["_Image_Bouton_Cacher",_ctrl_Image];

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	private _Image_Fond_Vert_Cacher =  _control getvariable ["_Image_Fond_Vert_Cacher",controlNull];
	private _Image_Bouton_Cacher = _control getvariable ["_Image_Bouton_Cacher",controlNull];

	private _mode_Entreprise = player getvariable ["MRP_Telephone_Mode_Entreprise",FALSE];
	if (_mode_Entreprise) exitwith
	{
		["Mode entreprise",format ["<t color='#ffffff' align='center'>%1</t>","Vous ne pouvez pas masquer votre numéro en mode entreprise."],"warning"] spawn ALF_fnc_doMsg;
	};

	playsound "MRP_Telephone_Touche_Appli";

	[FALSE,[_Image_Fond_Vert_Cacher,_Image_Bouton_Cacher],2] call MRPV2_fnc_MRP_Tel_Menu_Reglages_Gestion_Options_Actives;

	private _numero_Masquer = player getvariable ["MRP_Telephone_Numero_Cacher",FALSE];
	player setVariable ["MRP_Telephone_Numero_Cacher",!_numero_Masquer];
}];

[TRUE,[_ctrl_Image_Fond,_ctrl_Image],2] call MRPV2_fnc_MRP_Tel_Menu_Reglages_Gestion_Options_Actives;

_base_Y = _base_Y + 0.069;

// Image Fond Vert Mode entreprise
private _ctrl_Image_Fond = _Telephone_Base ctrlCreate ["RscPicture",-1,_telephone_Cadre_Base];
_ctrl_Image_Fond ctrlSetPosition [0.4215,_base_Y,0.069,0.09];
_ctrl_Image_Fond ctrlSetText "MRP_Telephones\Data\Menu_Reglages\Petite_icone_reglage_fondvert.paa";
_ctrl_Image_Fond ctrlSetFade 1;
_ctrl_Image_Fond ctrlCommit 0;

// Image Bouton Mode entreprise
private _ctrl_Image = _Telephone_Base ctrlCreate ["RscPicture",-1,_telephone_Cadre_Base];
_ctrl_Image ctrlSetPosition [0.408,_base_Y - 0.0005,0.069,0.09];
_ctrl_Image ctrlSetText "MRP_Telephones\Data\Menu_Reglages\Petite_icone_reglage_bouton.paa";
_ctrl_Image ctrlCommit 0;

// Bouton Mode entreprise
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_Bouton",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.05,_base_Y + 0.01,0.46,0.063];
_ctrlButton ctrlCommit 0;
_ctrlButton setVariable ["_Image_Fond_Vert_Cacher",_ctrl_Image_Fond];
_ctrlButton setVariable ["_Image_Bouton_Cacher",_ctrl_Image];

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];

	private _Image_Fond_Vert_Cacher =  _control getvariable ["_Image_Fond_Vert_Cacher",controlNull];
	private _Image_Bouton_Cacher = _control getvariable ["_Image_Bouton_Cacher",controlNull];

	if !(b_enService) exitwith
	{
		["Mode entreprise",format ["<t color='#ffffff' align='center'>%1</t>","Vous devez avoir pris votre service pour utiliser le mode entreprise."],"warning"] spawn ALF_fnc_doMsg;
	};

	private _numero_Masquer = player getvariable ["MRP_Telephone_Numero_Cacher",FALSE];
	if (_numero_Masquer) exitwith
	{
		["Mode entreprise",format ["<t color='#ffffff' align='center'>%1</t>","Vous ne pouvez pas passer en mode entreprise si votre numéro est masqué."],"warning"] spawn ALF_fnc_doMsg;
	};

	playsound "MRP_Telephone_Touche_Appli";

	[FALSE,[_Image_Fond_Vert_Cacher,_Image_Bouton_Cacher],11] call MRPV2_fnc_MRP_Tel_Menu_Reglages_Gestion_Options_Actives;

	private _mode_Entreprise = [FALSE,TRUE] select (ctrlfade _Image_Fond_Vert_Cacher);
	player setVariable ["MRP_Telephone_Mode_Entreprise",_mode_Entreprise];
}];

if !(b_enService) then
{
	private _telephone_Configuration = profileNamespace getvariable ["MRP_Telephone_Configuration",[]];
	_telephone_Configuration set [11,FALSE];
	profileNamespace setVariable ["MRP_Telephone_Configuration",_telephone_Configuration];
};

[TRUE,[_ctrl_Image_Fond,_ctrl_Image],11] call MRPV2_fnc_MRP_Tel_Menu_Reglages_Gestion_Options_Actives;

_base_Y = _base_Y + 0.07;

// Champ Fond Ecran
private _ctrlChamps = _Telephone_Base ctrlCreate ["MRP_Structured_Text",-1,_telephone_Cadre_Base];
_ctrlChamps ctrlSetPosition [0.282,_base_Y + 0.02,0.19,0.06];
_ctrlChamps ctrlCommit 0;

private _liste_Configuration = profileNamespace getvariable ["MRP_Telephone_Configuration",[]];
private _conf_Fond_Sonnerie = _liste_Configuration # 3 # 0;

[] call
{
	if ("MRP_Item_Neogend" in str assignedItems player) then
	{
		_conf_Fond_Sonnerie = _liste_Configuration # 3 # 1 # 0;

		if (_conf_Fond_Sonnerie isEqualTo "Neogend_Fond_Neutre") exitwith {_conf_Fond_Sonnerie = "Neutre";};
		if (_conf_Fond_Sonnerie isEqualTo "Neogend_Fond_GN_1") exitwith {_conf_Fond_Sonnerie = "Gend. Nat.";};
		if (_conf_Fond_Sonnerie isEqualTo "Neogend_Fond_GN_2") exitwith {_conf_Fond_Sonnerie = "PMO";};
		if (_conf_Fond_Sonnerie isEqualTo "Neogend_Fond_GN_3") exitwith {_conf_Fond_Sonnerie = "Gend. Mob.";};
		if (_conf_Fond_Sonnerie isEqualTo "Neogend_Fond_SP_1") exitwith {_conf_Fond_Sonnerie = "S.D.I.S";};
		if (_conf_Fond_Sonnerie isEqualTo "Neogend_Fond_SP_2") exitwith {_conf_Fond_Sonnerie = "Dragon 972";};
		if (_conf_Fond_Sonnerie isEqualTo "Neogend_Fond_SP_3") exitwith {_conf_Fond_Sonnerie = "S.S.S.M";};
		if (_conf_Fond_Sonnerie isEqualTo "Neogend_Fond_AP_1") exitwith {_conf_Fond_Sonnerie = "Admin. Pen.";};
		if (_conf_Fond_Sonnerie isEqualTo "Neogend_Fond_AP_2") exitwith {_conf_Fond_Sonnerie = "C.P Ducos";};
		if (_conf_Fond_Sonnerie isEqualTo "Neogend_Fond_AP_3") exitwith {_conf_Fond_Sonnerie = "Police Mun.";};

		private _permission_Joueur = [] call MRPV2_fnc_MRP_NB_Service_Vers_TXT;

		if (_permission_Joueur isEqualTo "GN") exitwith
		{
			if (_conf_Fond_Sonnerie isEqualTo "Generique_1") exitwith {_conf_Fond_Sonnerie = "Gendarmerie";};
		};

		if (_permission_Joueur isEqualTo "SP") exitwith {_conf_Fond_Sonnerie = "Pompier";};
		if (_permission_Joueur isEqualTo "AP") then {_conf_Fond_Sonnerie = "policemunicipale";};
	};

	if (_conf_Fond_Sonnerie isEqualTo "Generique_1") exitwith {_conf_Fond_Sonnerie = "Générique 1";};
	if (_conf_Fond_Sonnerie isEqualTo "Generique_2") exitwith {_conf_Fond_Sonnerie = "Générique 2";};
	if (_conf_Fond_Sonnerie isEqualTo "SC_Vanguard") then {_conf_Fond_Sonnerie = "Vanguard";};
};

_ctrlChamps ctrlSetStructuredText parsetext format ["<t font='SFUIDisplay_20' color='#000000' shadow='0' size='1.2' align='right'>%1</t>",_conf_Fond_Sonnerie];

// Bouton Fond Ecran
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_Bouton",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.05,_base_Y + 0.01,0.46,0.063];
_ctrlButton ctrlCommit 0;
_ctrlButton setVariable ["_ctrlChamps",_ctrlChamps];

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	private _ctrlChamps =  _control getvariable ["_ctrlChamps",controlNull];
	[_ctrlChamps] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;

	playsound "MRP_Telephone_Touche_Appli";

	[] spawn
	{
		sleep 0.2;

		[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
		["Fond"] call MRPV2_fnc_MRP_Tel_Menu_Reglages_Crea_Fond_Sonnerie_Et_Sonnerie;
	};
}];

_base_Y = _base_Y + 0.07;

// Champ Sonnerie
private _ctrlChamps = _Telephone_Base ctrlCreate ["MRP_Structured_Text",-1,_telephone_Cadre_Base];
_ctrlChamps ctrlSetPosition [0.23,_base_Y + 0.02,0.24,0.06];
_ctrlChamps ctrlCommit 0;

private _conf_Sonnerie = _liste_Configuration # 4;

if (_conf_Sonnerie isEqualTo "MRP_Telephone_Sonnerie_Apple") then {_conf_Sonnerie = "Apple";};
if (_conf_Sonnerie isEqualTo "MRP_Telephone_Sonnerie_Marimba") then {_conf_Sonnerie = "Marimba";};
if (_conf_Sonnerie isEqualTo "MRP_Telephone_Sonnerie_Tempasta") then {_conf_Sonnerie = "Tempasta";};

_ctrlChamps ctrlSetStructuredText parsetext format ["<t font='SFUIDisplay_20' color='#000000' shadow='0' size='1.2' align='right'>%1</t>",_conf_Sonnerie];

// Bouton Sonnerie
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_Bouton",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.05,_base_Y + 0.01,0.46,0.063];
_ctrlButton ctrlCommit 0;
_ctrlButton setVariable ["_ctrlChamps",_ctrlChamps];

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	private _ctrlChamps =  _control getvariable ["_ctrlChamps",controlNull];
	[_ctrlChamps] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;

	playsound "MRP_Telephone_Touche_Appli";

	[] spawn
	{
		sleep 0.2;

		[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
		["Sonnerie"] call MRPV2_fnc_MRP_Tel_Menu_Reglages_Crea_Fond_Sonnerie_Et_Sonnerie;
	};
}];

// Bouton retour menu principal
[] call MRPV2_fnc_MRP_Tel_Menu_Principal_Action_Retour;

TRUE
// };