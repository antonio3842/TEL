// MRPV2_fnc_MRP_Tel_Menu_Bloc_Gestion_Liste_Note = {
private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];

private _tv = uiNamespace getVariable ["MRP_Telephone_Menu_Note_Ctrl_Liste",controlNull];
private _texte_Recherche = ctrltext (_Telephone_Base displayctrl 645);

{ctrlDelete _x} foreach allControls _tv;

if (_tv isEqualTo controlNull) then
{
	_tv = _Telephone_Base ctrlCreate ["RscControlsGroupNoScrollbars",-1,_telephone_Cadre_Base];
	uiNamespace setVariable ["MRP_Telephone_Menu_Note_Ctrl_Liste",_tv];
	_tv ctrlSetPosition [0.045,0.32,0.47,0.95];
	_tv ctrlCommit 0;
};

private _Telephone_Liste_Note = profileNamespace getvariable ["MRP_Telephone_Liste_Note",createhashmap];
private _Telephone_Liste_Note_Trier = [];
private _SMS_Liste_Position_Verticale_Cumuler = 0;

{
	private _info_Note = _y;
	private _titre = _info_Note # 0;

	if (tolowerANSI _texte_Recherche isEqualTo "" OR {tolowerANSI _texte_Recherche in tolowerANSI _titre}) then
	{
		_Telephone_Liste_Note_Trier pushback [_x,_y];
	};
} foreach _Telephone_Liste_Note;

{
	private _cle = _x # 0;
	private _titre = _x # 1 # 0;
	private _texte = _x # 1 # 1;

	// Interligne
	private _interligne = _Telephone_Base ctrlcreate ["MRP_Structured_Text",-1, _tv];
	_interligne ctrlSetPosition [0,_SMS_Liste_Position_Verticale_Cumuler,0.6,0.002];
	_interligne ctrlSetBackgroundColor [0,0,0,0.2];
	_interligne ctrlCommit 0;

	// Cadre principal contact SMS
	private _cadre_Contact = _Telephone_Base ctrlCreate ["RscStructuredText",-1,_tv];
	
	_cadre_Contact ctrlSetPosition [0,_SMS_Liste_Position_Verticale_Cumuler,0.5,0.11];
	_cadre_Contact ctrlSetBackgroundColor [1,1,1,1];
	_cadre_Contact ctrlCommit 0;

	// Cadre Titre
	private _ctrl_Image = _Telephone_Base ctrlCreate ["MRP_RscTextMulti",-1,_tv];
	_ctrl_Image ctrlSetPosition [0,_SMS_Liste_Position_Verticale_Cumuler + 0.01,0.5,0.06];
	_ctrl_Image ctrlSetScale 0.85;
	_ctrl_Image ctrlCommit 0;
	_ctrl_Image ctrlSetText _titre;
	_ctrl_Image ctrlSetTextColor [0,0,0,1];
	_ctrl_Image ctrlSetBackgroundColor [1,1,1,1];
	_ctrl_Image ctrlSetFontHeight 0.06;
	_ctrl_Image ctrlSetShadow 0;
	_ctrl_Image ctrlSetFont "SFUIDisplay_46";

	// Cadre Icone vers SMS
	private _ctrl_Image = _Telephone_Base ctrlCreate ["RscPicture",-1,_tv];
	_ctrl_Image ctrlSetPosition [0.43,_SMS_Liste_Position_Verticale_Cumuler + 0.02,0.025,0.025];
	_ctrl_Image ctrlSetText "MRP_icone_tel\Data\Menu_SMS\Icone_Fleche_dxt5.paa";
	_ctrl_Image ctrlCommit 0;

	// Cadre _texte
	private _ctrl_Image = _Telephone_Base ctrlCreate ["MRP_RscTextMulti",-1,_tv];
	_ctrl_Image ctrlSetPosition [0.02,_SMS_Liste_Position_Verticale_Cumuler + 0.05,0.54,0.06];
	_ctrl_Image ctrlSetScale 0.75;
	_ctrl_Image ctrlCommit 0;
	_ctrl_Image ctrlSetText _texte;
	_ctrl_Image ctrlSetTextColor [0,0,0,1];
	_ctrl_Image ctrlSetBackgroundColor [1,1,1,1];
	_ctrl_Image ctrlSetFontHeight 0.06;
	_ctrl_Image ctrlSetShadow 0;
	_ctrl_Image ctrlSetFont "SFUIDisplay_46";

	private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_Bouton",-1,_tv];
	_ctrlButton ctrlSetPosition [0,_SMS_Liste_Position_Verticale_Cumuler,0.5,0.11];
	_ctrlButton ctrlCommit 0;
	_ctrlButton setvariable ["_cle_Hashmap",_cle];
	_ctrlButton setVariable ["MRP_Telephone_Menu_Note_Ctrl_Cadre",_cadre_Contact];

	_ctrlButton ctrlAddEventHandler ["ButtonClick",
	{params ["_control"];
		private _Ctrl_Cadre = _control getVariable ["MRP_Telephone_Menu_Note_Ctrl_Cadre",controlNull];
		[_Ctrl_Cadre] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;
	
		playsound "MRP_Telephone_Touche_Appli";
	
		[_control] spawn
		{params ["_control"];
			sleep 0.2;
			private _cle = _control getvariable ["_cle_Hashmap",""];

			[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
			[_cle] call MRPV2_fnc_MRP_Tel_Menu_Bloc_Lecture_Note;
		};
	}];

	_SMS_Liste_Position_Verticale_Cumuler = _SMS_Liste_Position_Verticale_Cumuler + 0.12;
} foreach _Telephone_Liste_Note_Trier;

TRUE
// };