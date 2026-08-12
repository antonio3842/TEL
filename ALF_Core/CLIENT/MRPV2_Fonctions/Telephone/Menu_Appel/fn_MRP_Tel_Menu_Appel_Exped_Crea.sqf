// MRPV2_fnc_MRP_Tel_Menu_Appel_Exped_Crea = {
player setvariable ["MRP_Appel_Etat","Tentative appel expéditeur",true];

private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _Telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];
private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];

_Telephone_Fond ctrlSetText "MRP_Telephones\Data\Menu_Appel\Fond_Appel_dxt5.paa";

private _Telephone_Cadre_Base_Tentative = _Telephone_Base ctrlCreate ["RscControlsGroupNoScrollbars",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Telephone_Cadre_Base_Tentative",_Telephone_Cadre_Base_Tentative];
_Telephone_Cadre_Base_Tentative ctrlSetPosition [0,0,0.56,1.4];
_Telephone_Cadre_Base_Tentative ctrlSetBackgroundColor [0,0,0,0.3];
_Telephone_Cadre_Base_Tentative ctrlCommit 0;

private _liste_Enfants = allControls _telephone_Cadre_Base;

{
	_x ctrlShow FALSE;
} foreach _liste_Enfants - [_Telephone_Cadre_Base_Tentative];

private _intituler_Identifiant = [MRP_Telephone_Numero_Appel] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Intituler;

// Cadran numéro
private _edit = _Telephone_Base ctrlCreate ["RscStructuredText",-1,_Telephone_Cadre_Base_Tentative];
_edit ctrlSetPosition [0.03,0.29,0.5,0.12];
_edit ctrlCommit 0;
_edit ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_46' shadow='0' color='#ffffff' size='1.7' align='center'>%1</t>",_intituler_Identifiant];

// Si le joueur est toujours en mode entrprise pour le tel mais nest plus en service on desactive le mdoe entreprise sur le tel
if !(b_enService) then 
{
	private _telephone_Configuration = profileNamespace getvariable ["MRP_Telephone_Configuration",[]];
	_telephone_Configuration set [11,FALSE];
	profileNamespace setVariable ["MRP_Telephone_Configuration",_telephone_Configuration];
	player setvariable ["MRP_Telephone_Mode_Entreprise",FALSE];
};

private _mode_Entreprise = player getvariable ["MRP_Telephone_Mode_Entreprise",FALSE];
if (_mode_Entreprise) then
{
	// Mode entreprise
	private _edit = _Telephone_Base ctrlCreate ["RscStructuredText",-1,_Telephone_Cadre_Base_Tentative];
	_edit ctrlSetPosition [0.03,0.4,0.5,0.08];
	_edit ctrlCommit 0;
	_edit ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_46' shadow='0' color='#ffffff' size='1' align='center'>%1</t>","Mode entreprise"];
};

// Bouton Raccrocher
private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_Telephone_Cadre_Base_Tentative];
_ctrlButton ctrlSetPosition [0.19,1.05,0.18,0.18];
_ctrlButton ctrlSetText "MRP_Telephones\Data\Menu_Appel\Icone_Appel_Raccrocher.paa";
_ctrlButton ctrlSetTextColor [0.9,0.9,0.9,1];
_ctrlButton ctrlCommit 0;

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	[_control,2] spawn MRPV2_fnc_MRP_Tel_Divers_Anti_Spam_Bouton;

	player setvariable ["MRP_Appel_Etat","Arret tentative"];

	private _est_Pas_Numero_Speciale = !(MRP_Telephone_Numero_Appel in str MRP_Liste_Numeros_Services);
	if (MRP_Compteur_Tonaliter > 1 AND {_est_Pas_Numero_Speciale}) then
	{
		[2] call MRPV2_fnc_MRP_Tel_Menu_Historique_Gestion_Histo;

		if !(isnil {MRP_Telephone_Appel_Id_Destinataire}) then
		{
			private _numero_Expediteur = player getvariable ["phoneNumber",""];
			
			private _mode_Entreprise = player getvariable ["MRP_Telephone_Mode_Entreprise",FALSE];
			if (_mode_Entreprise) then {_numero_Expediteur = player getVariable ["TelPro",""];};
	
			[0,_numero_Expediteur] remoteExec ["MRPV2_fnc_MRP_Tel_Menu_Historique_Gestion_Histo",MRP_Telephone_Appel_Id_Destinataire];

			private _joueur_Destinataire = (allplayers select {_x getvariable ["phoneNumber",""] isEqualTo (MRP_Telephone_Numero_Appel)}) # 0;
			if !(isnil {_joueur_Destinataire}) then 
			{
				_joueur_Destinataire setvariable ["MRP_Appel_Etat","Arret tentative"];
			};
		};

		[] call MRPV2_fnc_MRP_Tel_Divers_Crea_Liste_Nombre_Appel;
	};
}];

TRUE
// };