// MRPV2_fnc_MRP_Tel_Menu_FPR_Gestion_Resultat_Recherche = {
// Appelée par le relais fn_update1FipSony.sqf (hors dossier Telephone, voir note),
// qui reçoit la réponse du serveur existant (ALF_Server_fnc_selectFipSony) :
// une liste de [nom,motif] pour chaque personne recherchée correspondante
// (peut en contenir plusieurs en cas d'homonymes).
private _resultats = param [0,[]];

private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
if (isnull _Telephone_Base) exitwith {};

private _zone_OuiNon = uiNamespace getVariable ["MRP_Tel_FPR_Zone_OuiNon",controlNull];
if (isnull _zone_OuiNon) exitwith {};
private _zone_Motif = uiNamespace getVariable ["MRP_Tel_FPR_Zone_Motif",controlNull];

if (_resultats isEqualTo []) exitwith
{
	_zone_OuiNon ctrlSetStructuredText parseText "<t font='SFUIDisplay_20' shadow='0' color='#55ff55' size='1.3' align='left'>NON RECHERCHÉ</t>";
	_zone_Motif ctrlSetStructuredText parseText "";
};

private _entete = ["RECHERCHÉ",format ["RECHERCHÉ (%1 résultats)",count _resultats]] select (count _resultats > 1);
_zone_OuiNon ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_20' shadow='0' color='#ff5555' size='1.3' align='left'>%1</t>",_entete];

private _texte_Motifs = "";
{
	private _nom = _x select 0;
	private _motif = _x select 1;
	_texte_Motifs = _texte_Motifs + format
	[
		"<t font='SFUIDisplay_20' shadow='0' color='#ffffff' size='1.05' align='left'>%1</t><br/><t font='SFUIDisplay_20' shadow='0' color='#c5d2e3' size='0.95' align='left'>%2</t><br/><br/>",
		_nom,_motif
	];
} forEach _resultats;

_zone_Motif ctrlSetStructuredText parseText _texte_Motifs;

TRUE
// };
