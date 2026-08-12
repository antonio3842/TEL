// MRPV2_fnc_MRP_Tel_Menu_Radio_Crea_Cadre_Sauvegarde_Freq = {
private _id = param [0,0];
private _position_X = param [1,0];
private _position_Y = param [2,0];


private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];

private _Telephone_Cadre_Base_Tentative = _Telephone_Base ctrlCreate ["RscControlsGroupNoScrollbars",-1,_telephone_Cadre_Base];
_Telephone_Cadre_Base_Tentative ctrlSetPosition [0.05 + _position_X,0.2,0.2,0.2];
_Telephone_Cadre_Base_Tentative ctrlCommit 0;

// Champ Intitulé Fréquence
private _Intitule = _Telephone_Base ctrlCreate ["RscEdit",-1,_Telephone_Cadre_Base_Tentative];
_Intitule ctrlSetPosition [0,0.001,0.2,0.06];
_Intitule ctrlSetBackgroundColor [1,1,1,0.1];
_Intitule ctrlsettooltip "Intitulé fréquence";
_Intitule ctrlCommit 0;

_Intitule ctrlAddEventHandler ["KeyUp",
{params ["_displayOrControl", "_key"];
	[_displayOrControl,13] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;
}];

_Intitule ctrlAddEventHandler ["KeyDown",
{params ["_displayOrControl", "_key"];
	[_displayOrControl,13] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;
}];

// Champ Fréquence
private _Champ = _Telephone_Base ctrlCreate ["RscEdit",-1,_Telephone_Cadre_Base_Tentative];
_Champ ctrlSetPosition [0.05,0.07,0.1,0.06];
_Champ ctrlSetBackgroundColor [1,1,1,0.1];
_Champ ctrlSetFontHeight 0.05;
_Champ ctrlsettooltip "Fréquence";
_Champ ctrlCommit 0;

_Champ ctrlAddEventHandler ["KeyUp",
{params ["_displayOrControl", "_key"];
	[_displayOrControl,_key,"0123456789."] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Filtrage_Lettres;	
}];

_Champ ctrlAddEventHandler ["KeyDown",
{params ["_displayOrControl", "_key"];
	[_displayOrControl,_key,"0123456789."] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Filtrage_Lettres;	
}];

_Champ ctrlAddEventHandler ["EditChanged",
{params ["_control", "_newText"];
	if ("." in _newText OR {count (_newText splitstring ".") > 1}) then
	{
		if (count ((_newText splitstring ".") # 0) isequalto 1) exitWith {[_control,4] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;};
		if (count ((_newText splitstring ".") # 0) isequalto 2) exitWith {[_control,5] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;};
		if (count ((_newText splitstring ".") # 0) isequalto 3) exitWith {[_control,6] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;};
		[_control,3] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;
	} else
	{
		[_control,3] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;
	};
	
	playsound "MRP_Telephone_Touche_Appli";
}];

private _telephone_Configuration = profileNamespace getvariable ["MRP_Telephone_Configuration",[]];
if ((_telephone_Configuration # 9) isNotequalto []) then
{
	private _liste_Freq_Sauvegarder = (_telephone_Configuration # 9) # _id;
	if (!(isnil {_liste_Freq_Sauvegarder}) AND {_liste_Freq_Sauvegarder isnotequalto []}) then
	{
		private _texte_Intitule = _liste_Freq_Sauvegarder # 0;
		private _texte_Champ = _liste_Freq_Sauvegarder # 1;
		_Intitule ctrlsettext _texte_Intitule;
		_Champ ctrlsettext _texte_Champ;
	};
};

// Bouton Sauvegarder Fréquence
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_Telephone_Cadre_Base_Tentative];
_ctrlButton ctrlSetPosition [0,0.075,0.04,0.05];
_ctrlButton ctrlSetBackgroundColor [0.2,0,0,0.5];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlsettooltip "Sauvegarder";
_ctrlButton ctrlSetText "MRP_Telephones\Data\Menu_Radio\Icone_Radio_Sauvegarder.paa";
_ctrlButton setvariable ["_intitule",_Intitule];
_ctrlButton setvariable ["_frequence",_Champ];
_ctrlButton setvariable ["_id",_id];

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	[_control] spawn MRP_Gestion_Effet_Bouton_Appuyer;
	playsound "MRP_Telephone_Touche_Appli";

	private _ctrl_frequence = _control getvariable ["_frequence",""];
	private _texte_frequence = ctrltext _ctrl_frequence;

	private _telephone_Configuration = profileNamespace getvariable ["MRP_Telephone_Configuration",[]];
	private _liste_Freq_Sauvegarder = _telephone_Configuration # 9;
	private _id = _control getvariable ["_id",0];

	private _controle_intitule =  _control getvariable ["_intitule",""];
	private _intitule = ctrltext _controle_intitule;

	_liste_Freq_Sauvegarder set [_id,[_intitule,_texte_frequence]];
}];

// Bouton fleche vers bas : fréquence radio de sauvegarde vers cadran principal
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_Telephone_Cadre_Base_Tentative];
_ctrlButton ctrlSetPosition [0.05,0.14,0.04,0.05];
_ctrlButton ctrlSetBackgroundColor [0.2,0,0,0.5];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlsettooltip "Transfert fréq. sauv. vers fréq. princ.";
_ctrlButton ctrlSetText "MRP_Telephones\Data\Menu_Radio\Icone_Radio_Fleche_Bas_dxt5.paa";
_ctrlButton setvariable ["_intitule",_Intitule];
_ctrlButton setvariable ["_frequence",_Champ];

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	[_control] spawn MRP_Gestion_Effet_Bouton_Appuyer;
	playsound "MRP_Telephone_Touche_Appli";

	private _texte_ctrl = ctrltext (_control getvariable ["_frequence",""]);
	private _frequence = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwFrequency;

	if (_texte_ctrl isNotequalto "" AND {_texte_ctrl isnotequalto _frequence}) then
	{
		private _frequence_Principale = uiNamespace getVariable ["MRP_Telephone_Appli_Radio_Frequence_Principale",controlNull];

		_frequence_Principale ctrlsettext _texte_ctrl;

		if (_frequence isnotequalto "") then
		{
			playSound "TFAR_rotatorPush";
		};

		private _Bouton_Connecter = uiNamespace getVariable ["MRP_Telephone_Appli_Radio_Connection",controlNull];
		[(call TFAR_fnc_ActiveSwRadio),1,""] call TFAR_fnc_SetChannelFrequency;

		private _configuration_Raccourcis_TFAR = ["TFAR","SWTransmit"] call CBA_fnc_getKeybind;
		_configuration_Raccourcis_TFAR set [3,{[] call TFAR_fnc_hideHint;}];
		_configuration_Raccourcis_TFAR set [4,{[] call TFAR_fnc_hideHint;}];
		_configuration_Raccourcis_TFAR set [8,TRUE];

		_configuration_Raccourcis_TFAR call CBA_fnc_addKeybind;

		_Bouton_Connecter ctrlsettooltip "Se connecter";
		_Bouton_Connecter ctrlSetText "MRP_Telephones\Data\Menu_Radio\Icone_Radio_Connexion_dxt5.paa";


		if  !(isnil {MRP_Telephone_Info_Dispatch}) then
		{
			private _texte = MRP_Telephone_Info_Dispatch getOrDefault ["Principal",""];
			private _liste_Collegues = (allplayers select {([_x] call MRPV2_fnc_MRP_NB_Service_Vers_TXT) isEquaLTo ([] call MRPV2_fnc_MRP_NB_Service_Vers_TXT)}) - [player];

			if (_liste_Collegues isnotequalto []) then {[_texte,_frequence] remoteExec ["MRPV2_fnc_MRP_Tel_Menu_Dispatch_Gestion_Nombre_Connex_Collegue",_liste_Collegues];};

			MRP_Telephone_Info_Dispatch deleteat "Principal";
			player setvariable ["MRP_Telephone_Info_Dispatch",MRP_Telephone_Info_Dispatch,TRUE];
		};
	};
}];

// Bouton fleche vers haut : fréquence radio de cadran principal vers sauvegarde
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_Telephone_Cadre_Base_Tentative];
_ctrlButton ctrlSetPosition [0.11,0.14,0.04,0.05];
_ctrlButton ctrlSetBackgroundColor [0.2,0,0,0.5];
_ctrlButton ctrlSetAngle [180,0.5,0.5,TRUE];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlsettooltip "Transfert fréq. princ. vers fréq. sauv.";
_ctrlButton ctrlSetText "MRP_Telephones\Data\Menu_Radio\Icone_Radio_Fleche_Bas_dxt5.paa";
_ctrlButton setvariable ["_intitule",_Intitule];
_ctrlButton setvariable ["_frequence",_Champ];

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	[_control] spawn MRP_Gestion_Effet_Bouton_Appuyer;
	playsound "MRP_Telephone_Touche_Appli";

	private _ctrl_Frequence_Principale = uiNamespace getVariable ["MRP_Telephone_Appli_Radio_Frequence_Principale",controlNull];
	private _texte_Frequence_Principale = ctrltext _ctrl_frequence_Principale;

	if (["","30-512"] find _texte_Frequence_Principale isequalto -1) then
	{
		private _control_Champ = (_control getvariable ["_frequence",""]);
		_control_Champ ctrlsettext _texte_Frequence_Principale;
	};
}];

// Bouton Supprimer Fréquence
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_Telephone_Cadre_Base_Tentative];
_ctrlButton ctrlSetPosition [0.16,0.075,0.04,0.05];
_ctrlButton ctrlSetBackgroundColor [0.2,0,0,0.5];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlsettooltip "Supprimer";
_ctrlButton ctrlSetText "MRP_Telephones\Data\Menu_Radio\Icone_Radio_Supprimer.paa";
_ctrlButton setvariable ["_intitule",_Intitule];
_ctrlButton setvariable ["_frequence",_Champ];
_ctrlButton setvariable ["_id",_id];

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	[_control] spawn MRP_Gestion_Effet_Bouton_Appuyer;
	playsound "MRP_Telephone_Touche_Appli";

	private _telephone_Configuration = profileNamespace getvariable ["MRP_Telephone_Configuration",[]];
	private _liste_Freq_Sauvegarder = _telephone_Configuration # 9;
	private _id =  _control getvariable ["_id",0];
	_liste_Freq_Sauvegarder set [_id,["",""]];

	private _controle_intitule =  _control getvariable ["_intitule",""];
	private _controle_frequence = _control getvariable ["_frequence",""];

	_controle_intitule ctrlsettext "";
	_controle_frequence ctrlsettext "";
}];

TRUE
// };