// MRPV2_fnc_MRP_Tel_Menu_Contact_Modif_Crea = {
private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _Telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];
private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];

_Telephone_Fond ctrlSetText "MRP_Telephones\Data\Menu_Contact\Menu_Contact_Modifier_Nouveau_dxt5.paa";

// Bouton Annuler
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.025,0.07,0.15,0.1];
_ctrlButton ctrlSetText "MRP_Telephones\Data\Menu_Contact\Icone_Annuler.paa";
_ctrlButton ctrlSetTextColor [0.8,0.8,0.8,1];
_ctrlButton ctrlCommit 0;

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	[_control] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;

	playsound "MRP_Telephone_Touche_Appli";

	[] spawn
	{
		sleep 0.2;
		[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;

		private _liste_Contact = profileNamespace getvariable ["MRP_Telephone_Liste_Contact",createhashmap];
		private _info_Contact = _liste_Contact getOrDefault [MRP_Telephone_Gestion_Numero_Interne,[]];

		if (_info_Contact isequalto []) then {MRP_Telephone_Gestion_Numero_Interne = nil;};

		if (isnil {MRP_Telephone_Gestion_Numero_Interne}) then
		{
			[] call MRPV2_fnc_MRP_Tel_Menu_Contact_Crea;
		} else
		{
			[] call MRPV2_fnc_MRP_Tel_Menu_Contact_Lecture_Fiche;
		};
	};
}];

// Champ Prénom
_edit = _Telephone_Base ctrlCreate ["MRP_Telephone_RscEdit_Cadre_Invisible",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRPV2_fnc_MRP_Tel_Menu_Contact_Modif_Crea_Champs_Prenom",_edit];
_edit ctrlSetPosition [0.03,0.23,0.494,0.104];
_edit ctrlSetFont "SFUIDisplay_46";
_edit ctrlSetFontHeight 0.05;
_edit ctrlSetTextColor [0,0,0,0.3];
_edit ctrlCommit 0;

private _liste_Contact = profileNamespace getvariable ["MRP_Telephone_Liste_Contact",createhashmap];
private _info_Contact = _liste_Contact getOrDefault [MRP_Telephone_Gestion_Numero_Interne,[]];

if (_info_Contact isEqualTo []) then
{
	_edit ctrlSetText "Prénom";
} else
{
	private _prenom = _info_Contact # 0;

	if (_prenom isEqualTo "") then
	{
		_edit ctrlSetText "Prénom";
	} else
	{
		_edit ctrlSetTextColor [0,0,0,0.9];
		_edit ctrlSetText _prenom;
	};
};

_edit ctrlAddEventHandler ["Killfocus",
{params ["_control"];
	private _champ = ctrlText _control;
	if (_champ isEqualTo "") then
	{
		_control ctrlSetTextColor [0,0,0,0.3];
		_control ctrlSetText "Prénom";
	};
}];

_edit ctrlAddEventHandler ["SetFocus",
{params ["_control"];
	private _champ = ctrlText _control;

	if (_champ isEqualTo "Prénom") then {_control ctrlSetText "";};

	_control ctrlSetTextColor [0,0,0,1];
}];

_edit ctrlAddEventHandler ["Keydown",
{params ["_control"];
	[_control,30] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;
}];

_edit ctrlAddEventHandler ["KeyUp",
{
	[] call MRPV2_fnc_MRP_Tel_Menu_Contact_Gestion_Bouton_OK;
}];

// Champ Nom
_edit = _Telephone_Base ctrlCreate ["MRP_Telephone_RscEdit_Cadre_Invisible",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRPV2_fnc_MRP_Tel_Menu_Contact_Modif_Crea_Champs_Nom",_edit];
_edit ctrlSetPosition [0.03,0.358,0.494,0.104];
_edit ctrlSetBackgroundColor [0,0,0,0];
_edit ctrlSetFont "SFUIDisplay_46";
_edit ctrlSetFontHeight 0.05;
_edit ctrlSetTextColor [0,0,0,0.3];
_edit ctrlCommit 0;

if (_info_Contact isEqualTo []) then
{
	_edit ctrlSetText "Nom";
} else
{
	private _nom = _info_Contact # 1;

	if (_nom isEqualTo "") then
	{
		_edit ctrlSetText "Nom";
	} else
	{
		_edit ctrlSetTextColor [0,0,0,0.9];
		_edit ctrlSetText _nom;
	};
};

_edit ctrlAddEventHandler ["Killfocus",
{params ["_control"];
	private _champ = ctrlText _control;
	if (_champ isEqualTo "") then
	{
		_control ctrlSetTextColor [0,0,0,0.3];
		_control ctrlSetText "Nom";
	};
}];

_edit ctrlAddEventHandler ["SetFocus",
{params ["_control"];
	private _champ = ctrlText _control;

	if (_champ isEqualTo "Nom") then {_control ctrlSetText "";};

	_control ctrlSetTextColor [0,0,0,1];
}];

_edit ctrlAddEventHandler ["Keydown",
{params ["_control"];
	[_control,30] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;
}];

_edit ctrlAddEventHandler ["KeyUp",
{
	[] call MRPV2_fnc_MRP_Tel_Menu_Contact_Gestion_Bouton_OK;
}];

// Champ Numéro
_edit = _Telephone_Base ctrlCreate ["MRP_Telephone_RscEdit_Cadre_Invisible",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRPV2_fnc_MRP_Tel_Menu_Contact_Modif_Crea_Champs_Numero",_edit];
_edit ctrlSetPosition [0.03,0.486,0.494,0.104];
_edit ctrlSetFont "SFUIDisplay_46";
_edit ctrlSetFontHeight 0.05;
_edit ctrlSetTextColor [0,0,0,0.3];
_edit ctrlCommit 0;

if (isnil {MRP_Telephone_Gestion_Numero_Interne}) then
{
	_edit ctrlSetText "Numéro de téléphone";
} else
{
	_edit ctrlSetTextColor [0,0,0,0.9];

	private _numero = MRP_Telephone_Gestion_Numero_Interne;
	_numero = _numero insert [2, " "];
	_numero = _numero insert [5, " "];
	_numero = _numero insert [8, " "];
	_numero = _numero insert [11, " "];
	_edit ctrlSetText _numero;
};

_edit ctrlAddEventHandler ["SetFocus",
{params ["_control"];
	private _champ = ctrlText _control;

	if (_champ in ["Numéro de téléphone",""]) then {_control ctrlSetText "06 ";};

	_control ctrlSetTextColor [0,0,0,1];
	_control ctrlSetTextSelection [8,0];
}];

_edit ctrlAddEventHandler ["KeyUp",
{params ["_displayOrControl","_key","_shift"];
	[_displayOrControl,14] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;
	[_displayOrControl] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Filtrage_Lettres;
	[_displayOrControl,_key] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Formatage_Numero;
	[] call MRPV2_fnc_MRP_Tel_Menu_Contact_Gestion_Bouton_OK;
}];

_edit ctrlAddEventHandler ["KeyDown",
{params ["_displayOrControl","_key","_shift"];
	[_displayOrControl,14] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;
	[_displayOrControl] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Filtrage_Lettres;
	[_displayOrControl,_key] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Formatage_Numero;
}];

// Champ nom entreprise
_edit = _Telephone_Base ctrlCreate ["MRP_Telephone_RscEdit_Cadre_Invisible",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRPV2_fnc_MRP_Tel_Menu_Contact_Modif_Crea_Champs_Entreprise",_edit];
_edit ctrlSetPosition [0.03,0.614,0.494,0.104];
_edit ctrlSetFont "SFUIDisplay_46";
_edit ctrlSetFontHeight 0.05;
_edit ctrlSetTextColor [0,0,0,0.3];
_edit ctrlCommit 0;

if (_info_Contact isEqualTo []) then
{
	_edit ctrlSetText "Entreprise";
} else
{
	private _entreprise = _info_Contact # 2;

	if (_entreprise isEqualTo "") then
	{
		_edit ctrlSetText "Entreprise";
	} else
	{
		_edit ctrlSetTextColor [0,0,0,0.9];
		_edit ctrlSetText _entreprise;
	};
};

_edit ctrlAddEventHandler ["Killfocus",
{params ["_control"];
	private _champ = ctrlText _control;
	if (_champ isEqualTo "") then
	{
		_control ctrlSetTextColor [0,0,0,0.3];
		_control ctrlSetText "Entreprise";
	};
}];

_edit ctrlAddEventHandler ["SetFocus",
{params ["_control"];
	private _champ = ctrlText _control;

	if (_champ isEqualTo "Entreprise") then {_control ctrlSetText "";};

	_control ctrlSetTextColor [0,0,0,1];
}];

_edit ctrlAddEventHandler ["Keydown",
{params ["_control"];
	[_control,30] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;
}];

// Champ adresse mail
_edit = _Telephone_Base ctrlCreate ["MRP_Telephone_RscEdit_Cadre_Invisible",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRPV2_fnc_MRP_Tel_Menu_Contact_Modif_Crea_Champs_Mail",_edit];
_edit ctrlSetPosition [0.03,0.742,0.494,0.104];
_edit ctrlSetFont "SFUIDisplay_46";
_edit ctrlSetFontHeight 0.05;
_edit ctrlSetTextColor [0,0,0,0.3];
_edit ctrlCommit 0;

if (_info_Contact isEqualTo []) then
{
	_edit ctrlSetText "Adresse mail";
} else
{
	private _mail = _info_Contact # 3;

	if (_mail isEqualTo "") then
	{
		_edit ctrlSetText "Adresse mail";
	} else
	{
		_edit ctrlSetTextColor [0,0,0,0.9];
		_edit ctrlSetText _mail;
	};
};

_edit ctrlAddEventHandler ["Killfocus",
{params ["_control"];
	private _champ = ctrlText _control;
	if (_champ isEqualTo "") then
	{
		_control ctrlSetTextColor [0,0,0,0.3];
		_control ctrlSetText "Adresse mail";
	};
}];

_edit ctrlAddEventHandler ["SetFocus",
{params ["_control"];
	private _champ = ctrlText _control;

	if (_champ isEqualTo "Adresse mail") then {_control ctrlSetText "";};

	_control ctrlSetTextColor [0,0,0,1];
}];

_edit ctrlAddEventHandler ["KeyUp",
{params ["_control"];
	[_control,40] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;

	private _liste_Lettres_Authoriser = toArray "0123456789abcdefghijklmnopqrstuvwxyz_-.@";
	private _texte = toArray (ctrlText _control);
	private _texte_Filtrer = _texte select {_x in _liste_Lettres_Authoriser};
	_control ctrlSetText toloweransi (tostring _texte_Filtrer);
}];

_edit ctrlAddEventHandler ["Keydown",
{params ["_control"];
	[_control,40] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;

	private _liste_Lettres_Authoriser = toArray "0123456789abcdefghijklmnopqrstuvwxyz_-.@";
	private _texte = toArray (ctrlText _control);
	private _texte_Filtrer = _texte select {_x in _liste_Lettres_Authoriser};
	_control ctrlSetText toloweransi (tostring _texte_Filtrer);
}];

// Notes
_edit = _Telephone_Base ctrlCreate ["MRP_RscEditMulti",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRPV2_fnc_MRP_Tel_Menu_Contact_Modif_Crea_Champs_Notes",_edit];
_edit ctrlSetPosition [0.03,0.865,0.494,0.385];
_edit ctrlSetFont "SFUIDisplay_46";
_edit ctrlSetBackgroundColor [0,0,0,0];
_edit ctrlSetFontHeight 0.05;
_edit ctrlSetTextColor [0,0,0,0.3];
_edit ctrlCommit 0;

if (_info_Contact isEqualTo []) then
{
	_edit ctrlSetText "Notes";
} else
{
	private _notes = _info_Contact # 4;

	if (_notes isEqualTo "") then
	{
		_edit ctrlSetText "Notes";
	} else
	{
		_edit ctrlSetTextColor [0,0,0,0.9];
		_edit ctrlSetText _notes;
	};
};

_edit ctrlAddEventHandler ["Killfocus",
{params ["_control"];
	private _champ = ctrlText _control;
	if (_champ isEqualTo "") then
	{
		_control ctrlSetTextColor [0,0,0,0.3];
		_control ctrlSetText "Notes";
	};
}];

_edit ctrlAddEventHandler ["SetFocus",
{params ["_control"];
	private _champ = ctrlText _control;

	if (_champ isEqualTo "Notes") then {_control ctrlSetText "";};

	_control ctrlSetTextColor [0,0,0,1];
}];

_edit ctrlAddEventHandler ["Keyup",
{params ["_control"];
	[_control,200] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;
}];

_edit ctrlAddEventHandler ["Keydown",
{params ["_control"];
	[_control,200] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;
}];

//////// Exceptionnellement à la fin car je dois avoir remplis les autres champs avant de faire les vérifications pour mettre un bouton OK bleu ou gris
// Bouton OK Nouveau contact
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRPV2_fnc_MRP_Tel_Menu_Contact_Modif_Crea_Bouton_Ok",_ctrlButton];
_ctrlButton ctrlSetPosition [0.47,0.1,0.05,0.05];
_ctrlButton ctrlSetTextColor [1,1,1,1];
_ctrlButton ctrlCommit 0;

private _texte_Prenom = uiNamespace getVariable ["MRPV2_fnc_MRP_Tel_Menu_Contact_Modif_Crea_Champs_Prenom",controlNull];
private _texte_Nom = uiNamespace getVariable ["MRPV2_fnc_MRP_Tel_Menu_Contact_Modif_Crea_Champs_Nom",controlNull];
private _texte_Numero = uiNamespace getVariable ["MRPV2_fnc_MRP_Tel_Menu_Contact_Modif_Crea_Champs_Numero",controlNull];

private _prenom = [ctrlText _texte_Prenom,""] select ((ctrlText _texte_Prenom) in [""," ","Prénom"]);
private _nom = [ctrlText _texte_Nom,""] select ((ctrlText _texte_Nom) in [""," ","Nom"]);
private _numero = [ctrlText _texte_Numero,""] select ((ctrlText _texte_Numero) in [""," ","Numéro de téléphone"]);

private _prenom_Valide = !(_prenom in [""," ","Prénom"]);
private _nom_Valide = !(_nom in [""," ","Nom"]);
private _tel_Valide = !(_numero in [""," ","Numéro de téléphone"]);

if (_tel_Valide) then
{
	_ctrlButton ctrlSetText "MRP_Telephones\Data\Menu_Contact\Icone_OK_Bleu_dxt5.paa";
	_ctrlButton ctrlSetTextColor [0.8,0.8,0.8,1];
} else
{
	_ctrlButton ctrlSetText "MRP_Telephones\Data\Menu_Contact\Icone_OK_dxt5.paa";
};

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	private _ctrl_Numero = uiNamespace getVariable ["MRPV2_fnc_MRP_Tel_Menu_Contact_Modif_Crea_Champs_Numero",controlNull];
	private _texte_Numero = trim ctrlText _ctrl_Numero;
	private _numero = [_texte_Numero,""] select ((_texte_Numero) in ["","Numéro de téléphone"]);

	if ("Icone_OK_Bleu_dxt5" in ctrltext _control) then
	{
		[_control] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;

		playsound "MRP_Telephone_Touche_Appli";

		[_numero] spawn
		{params ["_numero"];
			sleep 0.2;

			private _texte_Prenom = trim ctrlText (uiNamespace getVariable ["MRPV2_fnc_MRP_Tel_Menu_Contact_Modif_Crea_Champs_Prenom",controlNull]);
			private _texte_Nom = trim ctrlText (uiNamespace getVariable ["MRPV2_fnc_MRP_Tel_Menu_Contact_Modif_Crea_Champs_Nom",controlNull]);

			private _texte_Entreprise = trim ctrlText (uiNamespace getVariable ["MRPV2_fnc_MRP_Tel_Menu_Contact_Modif_Crea_Champs_Entreprise",controlNull]);
			private _texte_Mail = trim ctrlText (uiNamespace getVariable ["MRPV2_fnc_MRP_Tel_Menu_Contact_Modif_Crea_Champs_Mail",controlNull]);
			private _texte_Notes = trim ctrlText (uiNamespace getVariable ["MRPV2_fnc_MRP_Tel_Menu_Contact_Modif_Crea_Champs_Notes",controlNull]);

			private _prenom = [_texte_Prenom,""] select ((_texte_Prenom) in ["","Prénom"]);
			private _nom = [_texte_Nom,""] select ((_texte_Nom) in ["","Nom"]);

			private _entreprise = [_texte_Entreprise,""] select ((_texte_Entreprise) in ["","Entreprise"]);
			private _mail = [_texte_Mail,""] select ((_texte_Mail) in ["","Adresse mail"]);
			private _notes = [_texte_Notes,""] select ((_texte_Notes) in ["","Notes"]);

			private _hashmap_Contact = profileNamespace getvariable ["MRP_Telephone_Liste_Contact",createhashmap];
			private _info_Contact = _hashmap_Contact getordefault [_numero,[]];
			private _contact_Est_Bloquer = [_info_Contact # 5,FALSE] select (isnil {_info_Contact # 5});

			[_prenom,_nom,_numero,_entreprise,_mail,_notes,_contact_Est_Bloquer] call MRPV2_fnc_MRP_Tel_Menu_Contact_Ajout_Modif;

			[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
			[] call MRPV2_fnc_MRP_Tel_Menu_Contact_Lecture_Fiche;
		};
	} else
	{
		if (_numero isnotequalto "") then
		{
			[_ctrl_Numero] spawn
			{params ["_ctrl_Numero"];
				private _duree_Action = 0.5;
				_ctrl_Numero ctrlsettextcolor [1,0,0,1];
				_ctrl_Numero ctrlsetfade 0.8;
				_ctrl_Numero ctrlcommit _duree_Action;

				sleep _duree_Action;

				_ctrl_Numero ctrlsetfade 0;
				_ctrl_Numero ctrlcommit _duree_Action;

				sleep _duree_Action;

				_ctrl_Numero ctrlsetfade 0.8;
				_ctrl_Numero ctrlcommit _duree_Action;

				sleep _duree_Action;

				_ctrl_Numero ctrlsetfade 0;
				_ctrl_Numero ctrlcommit _duree_Action;

				sleep _duree_Action;

				_ctrl_Numero ctrlsettextcolor [0,0,0,1];
			};
		};
	};
}];

// Bouton retour menu principal
[] call MRPV2_fnc_MRP_Tel_Menu_Principal_Action_Retour;

TRUE
// };