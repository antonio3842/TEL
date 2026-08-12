// MRPV2_fnc_MRP_Tel_Menu_Annuaire_Gestion_Liste = {
private _liste_Entreprise = param [0,createHashMap];


private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _texte_Recherche = ctrltext (_Telephone_Base displayctrl 645);

private _tv = uiNamespace getVariable ["MRP_Telephone_Menu_Annuaire_Ctrl_Liste",controlNull];

{ctrlDelete _x} foreach allControls _tv;

if (_tv isEqualTo controlNull) then
{
	private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];
	_tv = _Telephone_Base ctrlCreate ["RscControlsGroupNoScrollbars",-1,_telephone_Cadre_Base];
	uiNamespace setVariable ["MRP_Telephone_Menu_Annuaire_Ctrl_Liste",_tv];
	_tv ctrlSetPosition [0.045,0.32,0.47,0.95];
	_tv ctrlCommit 0;
};

private _liste_Annuaire_Trier = [];
private _SMS_Liste_Position_Verticale_Cumuler = 0;

{
	private _id = _x get "CID";
	private _liste_Pos = _x get "POSS";
	private _numero = _x get "PHONE";
	private _nom = _x get "NAME";
	private _description = _x get "DESC";
	private _a_Employer_Tel = _x get "OPEN";

	// Formatage numero
	if (count (_numero splitstring "") > 2) then
	{
		_numero = _numero insert [2," "];
		_numero = _numero insert [5," "];
		_numero = _numero insert [8," "];
		_numero = _numero insert [11," "];
	};

	if (tolowerANSI _texte_Recherche isEqualTo "" OR {tolowerANSI _texte_Recherche in tolowerANSI _nom}) then
	{
		_liste_Annuaire_Trier pushback [_nom,_description,_numero,_liste_Pos,_id,_a_Employer_Tel];
	};
} foreach _liste_Entreprise;

private _SMS_Liste_Position_Verticale_Cumuler = 0;

{
	private _nom = _x # 0;
	private _description = _x # 1;
	private _numero = _x # 2;
	private _liste_Pos = _x # 3;
	private _id_entreprise = _x # 4;
	private _a_Employer_Tel = _x # 5;

	// Interligne
	private _interligne = _Telephone_Base ctrlcreate ["MRP_Structured_Text",-1, _tv];
	_interligne ctrlSetPosition [0,_SMS_Liste_Position_Verticale_Cumuler,0.6,0.002];
	_interligne ctrlSetBackgroundColor [0,0,0,0.2];
	_interligne ctrlCommit 0;

	// Cadre principal contact SMS
	private _cadre_Contact = _Telephone_Base ctrlCreate ["MRP_Structured_Text",-1,_tv];
	_cadre_Contact ctrlSetPosition [0,_SMS_Liste_Position_Verticale_Cumuler,0.5,0.11];
	_cadre_Contact ctrlSetBackgroundColor [1,1,1,1];
	_cadre_Contact ctrlCommit 0;

	// Cadre Titre
	private _ctrl_Image = _Telephone_Base ctrlCreate ["MRP_RscTextMulti",-1,_tv];
	_ctrl_Image ctrlSetPosition [0.02,_SMS_Liste_Position_Verticale_Cumuler + 0.005,0.54,0.06];
	_ctrl_Image ctrlSetScale 0.75;
	_ctrl_Image ctrlCommit 0;
	_ctrl_Image ctrlSetText (_nom + " (" + _numero + ")");
	_ctrl_Image ctrlSetTextColor [0,0,0,1];
	_ctrl_Image ctrlSetBackgroundColor [1,1,1,1];
	_ctrl_Image ctrlSetFontHeight 0.06;
	_ctrl_Image ctrlSetShadow 0;
	_ctrl_Image ctrlSetFont "SFUIDisplay_46";

	// Cadre Icone vers SMS
	private _ctrl_Image = _Telephone_Base ctrlCreate ["RscPicture",-1,_tv];
	_ctrl_Image ctrlSetPosition [0.43,_SMS_Liste_Position_Verticale_Cumuler + 0.02,0.025,0.025];
	_ctrl_Image ctrlSetText "MRP_Telephones\Data\Menu_SMS\Icone_Fleche_dxt5.paa";
	_ctrl_Image ctrlCommit 0;

	// Cadre _description
	private _ctrl_Image = _Telephone_Base ctrlCreate ["MRP_RscTextMulti",-1,_tv];
	_ctrl_Image ctrlSetPosition [0.02,_SMS_Liste_Position_Verticale_Cumuler + 0.05,0.53,0.08];
	_ctrl_Image ctrlSetScale 0.75;
	_ctrl_Image ctrlCommit 0;
	_ctrl_Image ctrlSetText _description;
	_ctrl_Image ctrlSetTextColor [0.3,0.3,0.3,0.7];
	_ctrl_Image ctrlSetBackgroundColor [1,1,1,1];
	_ctrl_Image ctrlSetFontHeight 0.04;
	_ctrl_Image ctrlSetShadow 0;
	_ctrl_Image ctrlSetFont "SFUIDisplay_20";

	private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_Bouton",-1,_tv];
	_ctrlButton ctrlSetPosition [0,_SMS_Liste_Position_Verticale_Cumuler,0.5,0.11];
	_ctrlButton ctrlCommit 0;
	_ctrlButton setvariable ["_numero",_numero];

	_ctrlButton ctrlAddEventHandler ["ButtonClick",
	{params ["_control"];
		private _numero = _control getvariable ["_numero",""];
		_numero = _numero regexreplace [" ",""];

		MRP_Telephone_Gestion_Numero_Interne = _numero;
		MRP_Telephone_Numero_Appel = _numero;

		[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
		[] call MRPV2_fnc_MRP_Tel_Menu_Appel_Crea;
	}];

	// Bouton marqueur
	private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_tv];
	_ctrlButton ctrlSetText "MRP_Telephones\Data\Icones_Applications\Icone_Pin_Rouge.paa";
	_ctrlButton ctrlSetPosition [0.425,_SMS_Liste_Position_Verticale_Cumuler + 0.028,0.04,0.1];
	_ctrlButton ctrlSetTextColor [0.9,0.9,0.9,1];
	_ctrlButton ctrlCommit 0;
	_ctrlButton setvariable ["_liste_Pos",_liste_Pos];
	_ctrlButton setvariable ["_nom",_nom];

	if (_a_Employer_Tel) then {_ctrlButton ctrlSetText "MRP_Telephones\Data\Icones_Applications\Icone_Pin_Vert.paa";};

	_ctrlButton ctrlAddEventHandler ["ButtonClick",
	{params ["_control"];
		private _liste_Pos = _control getvariable ["_liste_Pos",[]];
		private _nom = _control getvariable ["_nom",""];
		[_liste_Pos,_nom] call MRPV2_fnc_MRP_Tel_Menu_Annuaire_Crea_Marqueur;
		[_control] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;
	}];

	_SMS_Liste_Position_Verticale_Cumuler = _SMS_Liste_Position_Verticale_Cumuler + 0.12;
} foreach _liste_Annuaire_Trier;

TRUE
// };