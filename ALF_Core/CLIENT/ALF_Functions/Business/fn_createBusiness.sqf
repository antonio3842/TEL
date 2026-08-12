// ALF_fnc_createBusiness = {

private _business = _this # 0;
life_pInact_curTarget = _business;

// if (player getVariable ["isEmployed",""] isNotEqualTo "") exitWith {["INFO","Vous êtes déjà employé dans une entreprise.","warning"] spawn ALF_fnc_doMsg;};

if !(dialog) then {createDialog "ALF_CreateBusiness_Dialog";};
disableSerialization;

private _display = findDisplay 28500;
private _filter = _display displayCtrl 28525;
lbClear _filter;
{
	private _nom = _x # 0;
	private _numero_Secteur = _x # 1;
	_filter lbAdd _nom;
	_filter lbSetData [_foreachindex,_numero_Secteur];
} foreach 
[
	["Armurerie", "7"],
	["Communication", "8"],
	["Concessionnaire", "0"],
	["Dépannage", "4"],
	["Distillerie", "0"],
	["Distribution de vêtements", "0"],
	["Évènementiel", "0"],
	["Journalisme", "0"],
	["Loueur", "0"],
	["Non définis", "0"],
	["Restauration", "0"],
	["Ressources ou minerais", "0"],
	["Sécurité", "0"],
	["Service Public (Trib, Pref)", "0"]
];

_filter lbSetCurSel 0;

private _btn = _display displayCtrl 28528;
_btn buttonSetAction "[life_pInact_curTarget] spawn ALF_fnc_btnCreateBusiness;";
// };