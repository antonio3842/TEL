// MRPV2_fnc_MRP_Tel_Menu_FPR_Gestion_Resultat_Liste = {
// Appelée par le relais fn_update2FipSony.sqf (hors dossier Telephone, voir note),
// qui reçoit la réponse du serveur existant (ALF_Server_fnc_loadFipSony ou après
// une suppression) : une liste de [name,motif].
private _resultats = param [0,[]];

private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
if (isnull _Telephone_Base) exitwith {};

private _tv = uiNamespace getVariable ["MRP_Tel_FPR_Liste_Zone_Liste",controlNull];
if (isnull _tv) exitwith {};

{ctrlDelete _x} foreach allControls _tv;

private _cadre_Detail = uiNamespace getVariable ["MRP_Tel_FPR_Liste_Cadre_Detail",controlNull];
_cadre_Detail ctrlShow false;
private _detail = uiNamespace getVariable ["MRP_Tel_FPR_Liste_Zone_Detail",controlNull];
_detail ctrlSetStructuredText parseText "";
private _bouton_Supprimer = uiNamespace getVariable ["MRP_Tel_FPR_Liste_Bouton_Supprimer",controlNull];
_bouton_Supprimer ctrlShow false;
(_bouton_Supprimer getvariable ["_visuel",controlNull]) ctrlShow false;

if (_resultats isequalto []) exitwith
{
	private _vide = _Telephone_Base ctrlcreate ["RscStructuredText",-1,_tv];
	_vide ctrlSetPosition [0.1,0.02,0.4,0.08];
	_vide ctrlCommit 0;
	_vide ctrlSetStructuredText parseText "<t font='SFUIDisplay_20' shadow='0' color='#8fa3bf' size='1.1' align='left'>La liste est vide.</t>";
};

private _position_Verticale = 0;

{
	private _nom = _x select 0;
	private _motif = _x select 1;

	private _interligne = _Telephone_Base ctrlcreate ["MRP_Structured_Text",-1,_tv];
	_interligne ctrlSetPosition [0.11,_position_Verticale,0.4,0.002];
	_interligne ctrlSetBackgroundColor [1,1,1,0.22];
	_interligne ctrlCommit 0;

	private _ctrl_Texte = _Telephone_Base ctrlCreate ["MRP_Structured_Text",-1,_tv];
	_ctrl_Texte ctrlSetPosition [0.1,_position_Verticale + 0.02,0.4,0.05];
	_ctrl_Texte ctrlCommit 0;
	_ctrl_Texte ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_20' shadow='0' color='#ffffff' size='1.2' align='left'>%1</t>",_nom];

	private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_Bouton",-1,_tv];
	_ctrlButton ctrlSetPosition [0.09,_position_Verticale,0.42,0.11];
	_ctrlButton ctrlSetfade 1;
	_ctrlButton ctrlCommit 0;
	_ctrlButton setVariable ["_nom",_nom];
	_ctrlButton setVariable ["_motif",_motif];
	_ctrlButton setVariable ["_fond_Ligne",_ctrl_Texte];

	_ctrlButton ctrlAddEventHandler ["ButtonClick",
	{params ["_control"];
		private _fond_Ligne = _control getvariable ["_fond_Ligne",controlNull];
		[_fond_Ligne] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;
		playsound "MRP_Telephone_Touche_Appli";
		[_control] call MRPV2_fnc_MRP_Tel_Menu_FPR_Action_Selection;
	}];

	_position_Verticale = _position_Verticale + 0.09;
} foreach _resultats;

TRUE
// };
