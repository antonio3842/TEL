// MRPV2_fnc_MRP_Tel_Menu_TAJ_Action_Selection = {
private _control = param [0,controlNull];

private _nom = _control getvariable ["_nom",""];
private _lieu = _control getvariable ["_lieu",""];
private _infra = _control getvariable ["_infra",""];
private _date = _control getvariable ["_date",""];

MRP_Tel_TAJ_Selection_Courante = [_lieu,_infra,_date];

private _cadre_Detail = uiNamespace getVariable ["MRP_Tel_TAJ_Cadre_Detail",controlNull];
_cadre_Detail ctrlShow true;

private _detail = uiNamespace getVariable ["MRP_Tel_TAJ_Zone_Detail",controlNull];
_detail ctrlSetStructuredText parseText format
[
	"<t font='SFUIDisplay_20' shadow='0' color='#ffffff' size='1.2' align='left'>%1</t><br/><t font='SFUIDisplay_20' shadow='0' color='#8fa3bf' size='0.9' align='left'>Lieu</t><br/><t font='SFUIDisplay_20' shadow='0' color='#ffffff' size='1.1' align='left'>%2</t><br/><br/><t font='SFUIDisplay_20' shadow='0' color='#8fa3bf' size='0.9' align='left'>Infraction</t><br/><t font='SFUIDisplay_20' shadow='0' color='#ffffff' size='1.05' align='left'>%3</t>",
	_nom,_lieu,_infra
];

private _bouton_Supprimer = uiNamespace getVariable ["MRP_Tel_TAJ_Bouton_Supprimer",controlNull];
_bouton_Supprimer ctrlShow true;
(_bouton_Supprimer getvariable ["_visuel",controlNull]) ctrlShow true;

TRUE
// };
