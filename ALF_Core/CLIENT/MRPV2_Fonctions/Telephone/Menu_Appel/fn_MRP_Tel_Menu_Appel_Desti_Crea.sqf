// MRPV2_fnc_MRP_Tel_Menu_Appel_Desti_Crea = {
private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
if (_Telephone_Base isEqualTo displaynull) exitwith {};

private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];
private _Telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];

private _fond = ctrltext _Telephone_Fond;
uiNamespace setVariable ["MRP_Telephone_Fond_Menu_En_Attente",_fond];

_Telephone_Fond ctrlSetText "MRP_icone_tel\Data\Menu_Appel\Fond_Appel_dxt5.paa";

private _liste_Enfants = allControls _telephone_Cadre_Base;
{
	_x ctrlShow FALSE;
} foreach _liste_Enfants - [_telephone_Cadre_Base];

private _Telephone_Cadre_Base_Tentative = _Telephone_Base ctrlCreate ["RscControlsGroupNoScrollbars",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Telephone_Cadre_Base_Tentative",_Telephone_Cadre_Base_Tentative];
_Telephone_Cadre_Base_Tentative ctrlSetPosition [0,0,0.56,1.4];
_Telephone_Cadre_Base_Tentative ctrlCommit 0;
_Telephone_Cadre_Base_Tentative ctrlshow TRUE;

// Cadran numéro
private _edit = _Telephone_Base ctrlCreate ["RscStructuredText",-1,_Telephone_Cadre_Base_Tentative];
uiNamespace setVariable ["MRP_Telephone_Appel_Destinataire",_edit];
_edit ctrlSetPosition [0.03,0.29,0.5,0.12];
_edit ctrlCommit 0;

MRP_Telephone_Numero_Appel = MRP_Telephone_Numero_Appel regexReplace [" ",""];

private _joueur_Expediteur = (allplayers select {_x getvariable ["phoneNumber",""] isEqualTo (MRP_Telephone_Numero_Appel)}) # 0;
private _intituler_Identifiant = [MRP_Telephone_Numero_Appel] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Intituler;

if !(isnull _joueur_Expediteur) then
{
	private _numero_Masquer = _joueur_Expediteur getvariable ["MRP_Telephone_Numero_Cacher",FALSE];
	if (_numero_Masquer) then {_intituler_Identifiant = "Numéro masqué";};
};

_edit ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_46' shadow='0' color='#ffffff' size='1.7' align='center'>%1</t>",_intituler_Identifiant];

// Bouton Refuser
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_Telephone_Cadre_Base_Tentative];
uiNamespace setVariable ["MRP_Telephone_Appel_En_Cours_Bouton_Raccrocher",_ctrlButton];
_ctrlButton ctrlSetPosition [0.08,1,0.18,0.18];
_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Appel\Icone_Appel_Raccrocher.paa";
_ctrlButton ctrlSetTextColor [0.9,0.9,0.9,1];
_ctrlButton ctrlCommit 0;

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	[_control,2] spawn MRPV2_fnc_MRP_Tel_Divers_Anti_Spam_Bouton;

	[0,MRP_Telephone_Numero_Appel] call MRPV2_fnc_MRP_Tel_Menu_Historique_Gestion_Histo;
	[] call MRPV2_fnc_MRP_Tel_Divers_Crea_Liste_Nombre_Appel;

	MRP_Appel_Reponse_Dilemme = "Appel refusé";

	MRP_Telephone_Appel_Id_Expediteur publicVariableClient "MRP_Appel_Reponse_Dilemme";
	MRP_Telephone_Appel_Id_Expediteur publicVariableClient "MRP_Telephone_Appel_Id_Destinataire";
}];

// Bouton Accepter
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_Telephone_Cadre_Base_Tentative];
uiNamespace setVariable ["MRP_Telephone_Appel_En_Cours_Bouton_Accepter",_ctrlButton];
_ctrlButton ctrlSetPosition [0.29,1,0.18,0.18];
_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Appel\Icone_appel.paa";
_ctrlButton ctrlSetTextColor [0.9,0.9,0.9,1];
_ctrlButton ctrlCommit 0;

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	[_control,2] spawn MRPV2_fnc_MRP_Tel_Divers_Anti_Spam_Bouton;

	MRP_Appel_Reponse_Dilemme = "Appel accepté";

	// MRP_Telephone_Appel_Id_Destinataire = clientowner;
	MRP_Telephone_Appel_Id_Expediteur publicVariableClient "MRP_Telephone_Appel_Id_Destinataire";
	MRP_Telephone_Appel_Id_Expediteur publicVariableClient "MRP_Appel_Reponse_Dilemme";

	[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Son;
}];

TRUE
// };