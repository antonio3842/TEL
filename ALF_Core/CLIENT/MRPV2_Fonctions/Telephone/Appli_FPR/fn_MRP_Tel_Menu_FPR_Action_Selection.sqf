// MRPV2_fnc_MRP_Tel_Menu_FPR_Action_Selection = {
private _control = param [0,controlNull];

private _nom = _control getvariable ["_nom",""];
private _motif = _control getvariable ["_motif",""];

MRP_Tel_FPR_Selection_Courante = [_nom,_motif];

private _cadre_Detail = uiNamespace getVariable ["MRP_Tel_FPR_Liste_Cadre_Detail",controlNull];
_cadre_Detail ctrlShow true;

private _detail = uiNamespace getVariable ["MRP_Tel_FPR_Liste_Zone_Detail",controlNull];
_detail ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_20' shadow='0' color='#ffffff' size='1.1' align='left'>%1</t>",_motif];

// Suppression réservée aux OPJ (grade élevé), comme sur l'ancien système
private _est_OPJ = (missionNamespace getvariable ["life_copLevel",0]) >= 4;

private _bouton_Supprimer = uiNamespace getVariable ["MRP_Tel_FPR_Liste_Bouton_Supprimer",controlNull];
_bouton_Supprimer ctrlShow _est_OPJ;
(_bouton_Supprimer getvariable ["_visuel",controlNull]) ctrlShow _est_OPJ;

TRUE
// };
