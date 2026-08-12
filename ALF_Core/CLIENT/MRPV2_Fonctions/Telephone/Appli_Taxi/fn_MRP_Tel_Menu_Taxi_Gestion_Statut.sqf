// MRPV2_fnc_MRP_Tel_Menu_Taxi_Gestion_Statut = {

private _lists = [] call ALF_fnc_iPhoneTaxiFetchLists;
private _appelables = (_lists # 1) select {
	private _u = _x # 0;
	(assignedItems _u select { "MRP_Item_Iphone_12" in _x || { "MRP_Item_Neogend" in _x } }) isNotEqualTo []
};

private _nombre = count _appelables;

private _ctrl_Statut = uiNamespace getVariable ["MRP_Tel_Menu_Taxi_Statut", controlNull];
if (isNull _ctrl_Statut) exitWith {};

private _texte_Statut = if (_nombre > 0) then {
	format ["Taxi en ligne : %1", _nombre]
} else {
	"Aucun taxi en ligne"
};

_ctrl_Statut ctrlSetStructuredText parseText format [
	"<t font='SFUIDisplay_46' shadow='0' color='#000000' size='1.5' align='center'>%1</t>",
	_texte_Statut
];

private _ctrlButton = uiNamespace getVariable ["MRP_Tel_Menu_Taxi_Bouton_Appel", controlNull];
if (!isNull _ctrlButton) then {
	_ctrlButton ctrlEnable (_nombre > 0);
};

TRUE
// };
