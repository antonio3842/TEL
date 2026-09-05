// MRPV2_fnc_MRP_Tel_Menu_SIV_Gestion_Resultat = {
// Appelée par le relais fn_SonyResultPlaque.sqf (hors dossier Telephone, voir note),
// qui reçoit la réponse du serveur existant (ALF_Server_fnc_SonyRecherchePlaque).
params [["_plaque","",[""]],["_classname","",[""]],["_nomProprietaire","",[""]],["_assurance",0,[0]]];

private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
if (isnull _Telephone_Base) exitwith {};

private _resultat = uiNamespace getVariable ["MRP_Tel_SIV_Zone_Resultat",controlNull];
if (isnull _resultat) exitwith {};

private _texte_Assurance = ["Non Assuré","Assuré"] select (_assurance in [1,2,3]);
private _couleur_Assurance = ["#ff5555","#55ff55"] select (_assurance in [1,2,3]);

_resultat ctrlSetStructuredText parseText format
[
	"<t font='SFUIDisplay_20' shadow='0' color='#cccccc' size='1' align='left'>Type de véhicule</t><br/><t font='SFUIDisplay_20' shadow='0' color='#ffffff' size='1.2' align='left'>%1</t><br/><br/>
	<t font='SFUIDisplay_20' shadow='0' color='#cccccc' size='1' align='left'>Immatriculation</t><br/><t font='SFUIDisplay_20' shadow='0' color='#ffffff' size='1.2' align='left'>%2</t><br/><br/>
	<t font='SFUIDisplay_20' shadow='0' color='#cccccc' size='1' align='left'>Propriétaire</t><br/><t font='SFUIDisplay_20' shadow='0' color='#ffffff' size='1.2' align='left'>%3</t><br/><br/>
	<t font='SFUIDisplay_20' shadow='0' color='#cccccc' size='1' align='left'>Assurance</t><br/><t font='SFUIDisplay_20' shadow='0' color='%5' size='1.2' align='left'>%4</t>",
	_classname,_plaque,_nomProprietaire,_texte_Assurance,_couleur_Assurance
];

TRUE
// };
