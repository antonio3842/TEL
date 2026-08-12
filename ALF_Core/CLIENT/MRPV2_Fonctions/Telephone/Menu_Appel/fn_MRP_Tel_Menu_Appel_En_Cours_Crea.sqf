// MRPV2_fnc_MRP_Tel_Menu_Appel_En_Cours_Crea = {
// Si le joueur est a terre ou mort ou vient de respawn on quitte
private _MRP_Appel_Etat = player getvariable ["MRP_Appel_Etat",""];
if (_MRP_Appel_Etat isequalto "" OR {lifeState player in ["INCAPACITATED","DEAD"]}) exitwith {};

private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _Telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];

private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];
private _Telephone_Cadre_Base_Tentative = uiNamespace getVariable ["MRP_Telephone_Cadre_Base_Tentative",controlNull];

private _ouverture_Tel_Avec_Appel_En_Cours = FALSE;

if (_Telephone_Cadre_Base_Tentative isNotEquaLTo controlNull) then
{
	[_Telephone_Cadre_Base_Tentative] spawn {params ["_ctrl"]; ctrldelete _ctrl;};
	_ouverture_Tel_Avec_Appel_En_Cours = TRUE;
};

_Telephone_Cadre_Base_Tentative = _Telephone_Base ctrlCreate ["RscControlsGroupNoScrollbars",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Telephone_Cadre_Base_Tentative",_Telephone_Cadre_Base_Tentative];
_Telephone_Cadre_Base_Tentative ctrlSetPosition [0,0,0.56,1.4];
_Telephone_Cadre_Base_Tentative ctrlSetBackgroundColor [0,0,0,0.3];
_Telephone_Cadre_Base_Tentative ctrlCommit 0;

_Telephone_Fond ctrlSetText "MRP_Telephones\Data\Menu_Appel\Fond_Appel_dxt5.paa";

// Cadran numéro
private _edit = _Telephone_Base ctrlCreate ["RscStructuredText",-1,_Telephone_Cadre_Base_Tentative];
_edit ctrlSetPosition [0.03,0.29,0.5,0.12];
_edit ctrlCommit 0;

MRP_Telephone_Numero_Appel = MRP_Telephone_Numero_Appel regexReplace [" ",""];
private _joueur_Expediteur = (allplayers select {_x getvariable ["phoneNumber",""] isEqualTo (MRP_Telephone_Numero_Appel);}) # 0;
private _contact = [MRP_Telephone_Numero_Appel] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Intituler;

if !(isnil {_joueur_Expediteur}) then
{
	// if (_MRP_Appel_Etat isequalto "Appel en cours") exitwith {};
	private _numero_Masquer = _joueur_Expediteur getvariable ["MRP_Telephone_Numero_Cacher",FALSE];
	if (_numero_Masquer) then {_contact = "Numéro masqué";};
};

_edit ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_46' shadow='0' color='#ffffff' size='1.7' align='center'>%1</t>",_contact];

// Champ durée appel
private _texte_Structurer = _Telephone_Base ctrlCreate ["RscStructuredText",-1,_Telephone_Cadre_Base_Tentative];
uiNamespace setVariable ["MRP_Telephone_Appel_En_Cours_Duree",_texte_Structurer];
_texte_Structurer ctrlSetPosition [0.15,0.5,0.5,0.1];
_texte_Structurer ctrlCommit 0;

[] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Affichage_Duree_Appel;

_couleur_Numero_Est_Noir = [] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Couleur_Numero;

if (MRP_Telephone_Duree_Appel isEqualTO 0) then
{
	[] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Duree_Appel;
};

// Bouton Muté
private _RscPicture = _Telephone_Base ctrlCreate ["RscPicture",-1,_Telephone_Cadre_Base_Tentative];
_RscPicture ctrlSetPosition [0.11,0.68,0.125,0.158];
_RscPicture ctrlSetText "MRP_Telephones\Data\Menu_Appel\Icone_Appel_Muet.paa";
_RscPicture ctrlSetTextColor [0.9,0.9,0.9,1];
_RscPicture ctrlCommit 0;

private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_Bouton",-1,_Telephone_Cadre_Base_Tentative];
_ctrlButton ctrlSetPosition [0.11,0.7,0.125,0.158];
_ctrlButton ctrlCommit 0;
_ctrlButton setVariable ["_RscPicture",_RscPicture];

if !(isnil {MRP_Telephone_Est_Muter}) then
{
	_RscPicture ctrlSetTextColor [0,0.9,0,1];
};

_ctrlButton ctrlAddEventHandler ["MouseEnter",
{params ["_control"];
	private _RscPicture = _control getvariable "_RscPicture";

	if (isnil {MRP_Telephone_Est_Muter}) then
	{
		_RscPicture ctrlSetTextColor [1,1,1,1];
	} else
	{
		_RscPicture ctrlSetTextColor [0,1,0,1];
	};
}];

_ctrlButton ctrlAddEventHandler ["MouseExit",
{params ["_control"];
	private _RscPicture = _control getvariable "_RscPicture";

	if (isnil {MRP_Telephone_Est_Muter}) then
	{
		_RscPicture ctrlSetTextColor [0.9,0.9,0.9,1];
	} else
	{
		_RscPicture ctrlSetTextColor [0,0.9,0,1];
	};
}];

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	[_control,1] spawn MRPV2_fnc_MRP_Tel_Divers_Anti_Spam_Bouton;

	private _RscPicture = _control getvariable "_RscPicture";

	// mute
	if (isnil {MRP_Telephone_Est_Muter}) then
	{
		MRP_Telephone_Est_Muter = TRUE;
		_RscPicture ctrlSetTextColor [0,1,0,1];

		["Déconnexion"] spawn MRPV2_fnc_MRP_Tel_Divers_Connexion_TFAR;
	} else
	{
		MRP_Telephone_Est_Muter = nil;
		_RscPicture ctrlSetTextColor [1,1,1,1];

		["Connexion"] spawn MRPV2_fnc_MRP_Tel_Divers_Connexion_TFAR;
	};
}];

// Bouton Haut parleur
private _RscPicture = _Telephone_Base ctrlCreate ["RscPicture",-1,_Telephone_Cadre_Base_Tentative];
_RscPicture ctrlSetPosition [0.33,0.68,0.125,0.158];
_RscPicture ctrlSetText "MRP_Telephones\Data\Menu_Appel\Icone_Appel_Haut_Parleur.paa";
_RscPicture ctrlSetTextColor [0.9,0.9,0.9,1];
_RscPicture ctrlCommit 0;

private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_Bouton",-1,_Telephone_Cadre_Base_Tentative];
_ctrlButton ctrlSetPosition [0.33,0.7,0.125,0.158];
_ctrlButton ctrlCommit 0;
_ctrlButton setVariable ["_RscPicture",_RscPicture];

if !(isnil {MRP_Telephone_Haut_Parleur}) then
{
	_RscPicture ctrlSetTextColor [0,1,0,1];
};

_ctrlButton ctrlAddEventHandler ["MouseEnter",
{params ["_control"];
	private _RscPicture = _control getvariable "_RscPicture";

	if (isnil {MRP_Telephone_Haut_Parleur}) then
	{
		_RscPicture ctrlSetTextColor [1,1,1,1];
	} else
	{
		_RscPicture ctrlSetTextColor [0,1,0,1];
	};
}];

_ctrlButton ctrlAddEventHandler ["MouseExit",
{params ["_control"];
	private _RscPicture = _control getvariable "_RscPicture";

	if (isnil {MRP_Telephone_Haut_Parleur}) then
	{
		_RscPicture ctrlSetTextColor [0.9,0.9,0.9,1];
	} else
	{
		_RscPicture ctrlSetTextColor [0,0.9,0,1];
	};
}];

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	[_control,1] spawn MRPV2_fnc_MRP_Tel_Divers_Anti_Spam_Bouton;

	private _RscPicture = _control getvariable "_RscPicture";
	if (isnil {MRP_Telephone_Haut_Parleur}) then
	{
		MRP_Telephone_Haut_Parleur = TRUE;
		_RscPicture ctrlSetTextColor [0,0.9,0,1];
	} else
	{
		MRP_Telephone_Haut_Parleur = nil;
		_RscPicture ctrlSetTextColor [0.9,0.9,0.9,1];
	};

	[(call TFAR_fnc_ActiveSwRadio)] call TFAR_fnc_setSwSpeakers;
}];

// Bouton Volume +
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_Telephone_Cadre_Base_Tentative];
_ctrlButton ctrlSetPosition [0.15,0.89,0.08,0.1];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetText "MRP_Telephones\Data\Menu_Radio\Icone_Radio_Volume_Augmenter_dxt5.paa";

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	[_control,0.3] spawn MRPV2_fnc_MRP_Tel_Divers_Anti_Spam_Bouton;

	private _volume = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwVolume;

	if (_volume < 9) then
	{
		playSound "TFAR_rotatorPush";

		[(call TFAR_fnc_ActiveSwRadio),_volume + 1] call TFAR_fnc_setSwVolume;
		[(call TFAR_fnc_ActiveSwRadio)] call TFAR_fnc_showRadioVolume;
		player setvariable ["MRP_Telephone_Volume_Appel",(call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwVolume];
	};
}];

// Bouton Volume -
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_Telephone_Cadre_Base_Tentative];
_ctrlButton ctrlSetPosition [0.35,0.89,0.08,0.1];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetText "MRP_Telephones\Data\Menu_Radio\Icone_Radio_Volume_Diminuer.paa";

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	[_control,0.3] spawn MRPV2_fnc_MRP_Tel_Divers_Anti_Spam_Bouton;

	private _volume = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwVolume;

	if (_volume > 0) then
	{
		playSound "TFAR_rotatorPush";

		[(call TFAR_fnc_ActiveSwRadio),_volume - 1] call TFAR_fnc_setSwVolume;
		[(call TFAR_fnc_ActiveSwRadio)] call TFAR_fnc_showRadioVolume;
		player setvariable ["MRP_Telephone_Volume_Appel",(call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwVolume];
	};
}];

// Bouton Raccrocher
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_Telephone_Cadre_Base_Tentative];
_ctrlButton ctrlSetText "MRP_Telephones\Data\Menu_Appel\Icone_Appel_Raccrocher.paa";
_ctrlButton ctrlSetTextColor [0.9,0.9,0.9,1];

private _joueur_est_Destinataire =  (uiNamespace getVariable ["MRP_Telephone_Appel_En_Cours_Bouton_Accepter",controlNull]) isnotEqualTo controlNull;

if (_joueur_est_Destinataire) then
{
	_ctrlButton ctrlSetPosition [0.08,1,0.18,0.18];
	_ctrlButton ctrlCommit 0;

	_ctrlButton ctrlSetPosition [0.19,1.05,0.18,0.18];
	_ctrlButton ctrlCommit 0.5;
} else
{
	_ctrlButton ctrlSetPosition [0.19,1.05,0.18,0.18];
	_ctrlButton ctrlCommit 0;
};

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	[_control,2] spawn MRPV2_fnc_MRP_Tel_Divers_Anti_Spam_Bouton;

	[] call MRPV2_fnc_MRP_Tel_Divers_Fin_Appel_TFAR;

	player setvariable ["MRP_Appel_Etat","Arret appel en cours"];

	// Si joueur appel un CENTRE APPEL
	private _info_Appel_CA_Appelant = player getvariable ["MRP_Tel_CA_Info_Appelant",[]];
	if (_info_Appel_CA_Appelant isNotequalto []) exitwith
	{
		private _liste_Annuaire = profilenamespace getvariable ["MRP_Tel_Liste_Entreprise",[]];
		private _id_Entreprise = ((_liste_Annuaire select {_x get "PHONE" isequalto MRP_Telephone_Numero_Appel}) # 0) get "CID";
		["","Arret civil",clientowner,_id_Entreprise] call MRPV2_fnc_MRP_Tel_Menu_CA_Gestion_Etat;		

		private _liste_id_Appelants = _info_Appel_CA_Appelant # 3;		
		private _numero = player getvariable ["phoneNumber",""];
		[_numero,"Arret opé",clientowner] remoteExec ["MRPV2_fnc_MRP_Tel_Menu_CA_Gestion_Etat",_liste_id_Appelants];
		
		private _siret = _info_Appel_CA_Appelant # 5;
		private _building = objNull;
		{
		  // Rechercher sur le bâtiment principal (Land_ALF_Entreprise) ou les concessionnaires (Land_MRP_Concessionnaire)
		  if (((_x getVariable ["business",["","",""]]) select 2) isEqualTo _siret) exitWith {
				_building = _x;
			};
		} forEach ALF_allBusinesss;

		if (isNull _building) exitWith {};

		private _var = _building getVariable ["business",[]];
		private _name = _var select 1;
		_groupe = ((groups civilian) select {groupId _x isEqualto _name}) # 0;
		_liste_unites_Receptrices = (units _groupe);
				
		[_numero,"Arret opé maj autre opé",clientowner] remoteExec ["MRPV2_fnc_MRP_Tel_Menu_CA_Gestion_Etat",_liste_unites_Receptrices];
	};

	private _joueur_Destinataire = (allplayers select {_x getvariable ["phoneNumber",""] isEqualTo (MRP_Telephone_Numero_Appel)}) # 0;
	if (isnil {_joueur_Destinataire}) then
	{
		_joueur_Destinataire = (allplayers select {_x getvariable ["phoneNumber",""] isEqualTo (MRP_Telephone_Gestion_Numero_Interne)}) # 0;
	};

	// Fonction suivante utiliser en fonction de qui coupe lappel.
	if !(isnil {MRP_Telephone_Appel_Id_Expediteur}) exitwith
	{
		if (_joueur_Destinataire getSlotItemName 611 isequalto "") exitwith {};

		_joueur_Destinataire setvariable ["MRP_Appel_Etat","Arret appel en cours",MRP_Telephone_Appel_Id_Expediteur];
		[] remoteExec ["MRPV2_fnc_MRP_Tel_Divers_Crea_Liste_Nombre_Appel",MRP_Telephone_Appel_Id_Expediteur];
		[] remoteExec ["MRPV2_fnc_MRP_Tel_Divers_Fin_Appel_TFAR",MRP_Telephone_Appel_Id_Expediteur];
	};

	if !(isnil {MRP_Telephone_Appel_Id_Destinataire}) then
	{
		_joueur_Destinataire setvariable ["MRP_Appel_Etat","Arret appel en cours",MRP_Telephone_Appel_Id_Destinataire];
		[] remoteExec ["MRPV2_fnc_MRP_Tel_Divers_Crea_Liste_Nombre_Appel",MRP_Telephone_Appel_Id_Destinataire];
		[] remoteExec ["MRPV2_fnc_MRP_Tel_Divers_Fin_Appel_TFAR",MRP_Telephone_Appel_Id_Destinataire];
	};
}];

TRUE
// };