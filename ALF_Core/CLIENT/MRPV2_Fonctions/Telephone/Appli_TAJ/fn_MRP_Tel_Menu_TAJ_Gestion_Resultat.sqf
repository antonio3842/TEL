// MRPV2_fnc_MRP_Tel_Menu_TAJ_Gestion_Resultat = {
// Appelée par le relais fn_updateTajSony.sqf (hors dossier Telephone, voir note),
// qui reçoit la réponse du serveur existant (ALF_Server_fnc_selectTajSony) et nous
// la transmet telle quelle : une liste de [nom,type,lieu,date,infra].
private _resultats = param [0,[]];

private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
if (isnull _Telephone_Base) exitwith {};

private _tv = uiNamespace getVariable ["MRP_Tel_TAJ_Zone_Liste",controlNull];
if (isnull _tv) exitwith {};

{ctrlDelete _x} foreach allControls _tv;

private _cadre_Detail = uiNamespace getVariable ["MRP_Tel_TAJ_Cadre_Detail",controlNull];
_cadre_Detail ctrlShow false;
private _detail = uiNamespace getVariable ["MRP_Tel_TAJ_Zone_Detail",controlNull];
_detail ctrlSetStructuredText parseText "";
private _bouton_Supprimer = uiNamespace getVariable ["MRP_Tel_TAJ_Bouton_Supprimer",controlNull];
_bouton_Supprimer ctrlShow false;
(_bouton_Supprimer getvariable ["_visuel",controlNull]) ctrlShow false;

if (_resultats isequalto []) exitwith
{
	private _vide = _Telephone_Base ctrlcreate ["RscStructuredText",-1,_tv];
	_vide ctrlSetPosition [0.1,0.02,0.4,0.08];
	_vide ctrlCommit 0;
	_vide ctrlSetStructuredText parseText "<t font='SFUIDisplay_20' shadow='0' color='#ffffff' size='1.2' align='left'>Casier vierge.</t>";
};

private _position_Verticale = 0;

{
	private _nom = _x select 0;
	private _type = _x select 1;
	private _lieu = _x select 2;
	private _date = _x select 3;
	private _infra = _x select 4;

	private _libelle_Type = ["Délit","Crime"] select (_type isequalto 1);

	// Interligne
	private _interligne = _Telephone_Base ctrlcreate ["MRP_Structured_Text",-1,_tv];
	_interligne ctrlSetPosition [0.11,_position_Verticale,0.4,0.002];
	_interligne ctrlSetBackgroundColor [1,1,1,0.22];
	_interligne ctrlCommit 0;

	private _ctrl_Texte = _Telephone_Base ctrlCreate ["MRP_Structured_Text",-1,_tv];
	_ctrl_Texte ctrlSetPosition [0.1,_position_Verticale + 0.015,0.4,0.075];
	_ctrl_Texte ctrlCommit 0;
	_ctrl_Texte ctrlSetStructuredText parseText format
	[
		"<t font='SFUIDisplay_20' shadow='0' color='#ffffff' size='1.15' align='left'>%1</t><br/><t font='SFUIDisplay_20' shadow='0' color='#8fa3bf' size='0.9' align='left'>%2 — %3</t>",
		_nom,_date,_libelle_Type
	];

	private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_Bouton",-1,_tv];
	_ctrlButton ctrlSetPosition [0.09,_position_Verticale,0.42,0.13];
	_ctrlButton ctrlSetfade 1;
	_ctrlButton ctrlCommit 0;
	_ctrlButton setVariable ["_nom",_nom];
	_ctrlButton setVariable ["_lieu",_lieu];
	_ctrlButton setVariable ["_infra",_infra];
	_ctrlButton setVariable ["_date",_date];
	_ctrlButton setVariable ["_fond_Ligne",_ctrl_Texte];

	_ctrlButton ctrlAddEventHandler ["ButtonClick",
	{params ["_control"];
		private _fond_Ligne = _control getvariable ["_fond_Ligne",controlNull];
		[_fond_Ligne] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;
		playsound "MRP_Telephone_Touche_Appli";
		[_control] call MRPV2_fnc_MRP_Tel_Menu_TAJ_Action_Selection;
	}];

	_position_Verticale = _position_Verticale + 0.115;
} foreach _resultats;

TRUE
// };
