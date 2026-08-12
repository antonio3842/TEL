/*
// alf_fnc_menuBusiness = {

private _building = param [0,objnull];
private _guid = param [1,0];
private _nom = param [2,""];


private _var = _building getVariable ["business",[]];
if (_var isequalto []) exitWith {[_building] call ALF_fnc_createBusiness;};
life_pInact_curTarget = _building;

private _owner = _var # 0;
private _namestr = _var # 1;
private _siretstr = _var # 2;
private _capitalstr = _var # 3;
private _secteur = _var # 4;
private _membres = _var # 5;
private _levelstr = _var # 6;

private _uid = getPlayerUID player;
if (_uid isNotEqualTo _owner) exitWith {["ENTREPRISE","N'étant pas le propriétaire, vous n'avez pas accès au système.","warning"] spawn ALF_fnc_doMsg;};

if !(dialog) then {createDialog "ALF_Business_Dialog";};
disableSerialization;

private _display = findDisplay 29500;
private _name = _display displayCtrl 29501;
private _siret = _display displayCtrl 29502;
private _capital = _display displayCtrl 29503;
private _level = _display displayCtrl 29504;
private _list = _display displayCtrl 29506;
// private _agrandir = _display displayCtrl 29507;
private _recruter = _display displayCtrl 29508;
private _payer = _display displayCtrl 29509;
private _virer = _display displayCtrl 29510;
private _deposer = _display displayCtrl 29512;

_name ctrlSetStructuredText parseText format["<t align='center' shadow='0' color='#000000' size='2.5'>%1</t>",_namestr];
_siret ctrlSetStructuredText parseText format["<t align='center' shadow='0' color='#000000' size='1'>SIRET: %1</t>",_siretstr];
_capital ctrlSetStructuredText parseText format["<t style='0' align='left' shadow='0' color='#000000' size='1'>%1€</t>",[_capitalstr] call ALF_fnc_numberText];

if (_nom isnotequalto "" AND {_guid isNotEqualTo ""}) then 
{
	private _namenew = _display displayCtrl 29513;
	_namenew ctrlsettext _nom;
	private _secunew = _display displayCtrl 29505;
	_secunew ctrlsettext _guid;
};

// private _levelfinal = "Niveau 1";
// if(_levelstr isEqualTo 1) then {_levelfinal = "Niveau 2";};
// _level ctrlSetStructuredText parseText format["<t style='0' align='left' shadow='0' color='#000000' size='1'>%1</t>",_levelfinal];

lbClear _list;
{
	private _membername = _x # 0;
	_list lbAdd format["%1",_membername];
	_list lbSetdata [(lbSize _list)-1,format["%1",_x]];
} forEach _membres;

// _agrandir buttonSetAction "[life_pInact_curTarget] spawn ALF_fnc_agrandirBusiness";
_recruter buttonSetAction "[life_pInact_curTarget] spawn ALF_fnc_recruterBusiness";
_payer buttonSetAction "[life_pInact_curTarget] spawn ALF_fnc_payerBusiness";
_virer buttonSetAction "[life_pInact_curTarget] spawn ALF_fnc_virerBusiness";
_deposer buttonSetAction "[life_pInact_curTarget] spawn ALF_fnc_deposerBusiness";
// };
*/


//alf_fnc_menuBusiness = {
private _building = param [0,objnull];
private _guid = param [1,0];
private _nom = param [2,""];


private _var = _building getVariable ["business",[]];
if (_var isequalto []) exitWith {[_building] call ALF_fnc_createBusiness;};
life_pInact_curTarget = _building;

private _owner = _var # 0;
private _namestr = _var # 1;
private _siretstr = _var # 2;
private _capitalstr = _var # 3;
private _secteur = _var # 4;
private _membres = _var # 5;
private _levelstr = _var # 6;

private _uid = getPlayerUID player;
private _est_autorise =
    (_uid isEqualTo _owner) OR
    {((_membres select {(_x # 1) isEqualTo _uid AND {(_x # 2) >= 3}}) isNotEqualTo [])};

if (!_est_autorise) exitWith {
    ["ENTREPRISE","Vous n'avez pas accès à la gestion de l'entreprise.","warning"] spawn ALF_fnc_doMsg;
};


if !(dialog) then {createDialog "ALF_Business_Dialog";};
disableSerialization;

private _display = findDisplay 29500;
private _name = _display displayCtrl 29501;
private _siret = _display displayCtrl 29502;
private _capital = _display displayCtrl 29503;
private _level = _display displayCtrl 29504;
private _list = _display displayCtrl 29506;
private _recruter = _display displayCtrl 29508;
private _payer = _display displayCtrl 29509;
private _virer = _display displayCtrl 29510;
private _deposer = _display displayCtrl 29512;

_name ctrlSetStructuredText parseText format["<t align='center' shadow='0' color='#000000' size='2.5'>%1</t>",_namestr];
_siret ctrlSetStructuredText parseText format["<t align='center' shadow='0' color='#000000' size='1'>SIRET: %1</t>",_siretstr];
_capital ctrlSetStructuredText parseText format["<t style='0' align='left' shadow='0' color='#000000' size='1'>%1€</t>",[_capitalstr] call ALF_fnc_numberText];

if (_nom isnotequalto "" AND {_guid isNotEqualTo ""}) then 
{
	private _namenew = _display displayCtrl 29513;
	_namenew ctrlsettext _nom;
	private _secunew = _display displayCtrl 29505;
	_secunew ctrlsettext _guid;
};

lbClear _list;
{
	private _membername = _x # 0;
	_list lbAdd format["%1",_membername];
	_list lbSetdata [(lbSize _list)-1,format["%1",_x]];
} forEach _membres;

_recruter buttonSetAction "[life_pInact_curTarget] spawn ALF_fnc_recruterBusiness";
_payer buttonSetAction "[life_pInact_curTarget] spawn ALF_fnc_payerBusiness";
_virer buttonSetAction "[life_pInact_curTarget] spawn ALF_fnc_virerBusiness";
_deposer buttonSetAction "[life_pInact_curTarget] spawn ALF_fnc_deposerBusiness";
//};