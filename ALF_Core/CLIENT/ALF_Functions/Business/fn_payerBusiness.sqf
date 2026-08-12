#include "\ALF_Client\script_macros.hpp"
/*
File: recruterBusiness.sqf
Author: ALF Nanou
*/
private _business = _this select 0;

if((lbCurSel 29506) isEqualTo -1) exitWith {};
private _data = lbData[29506,lbCurSel(29506)];
_data = call compile format["%1",_data];
private _namemember = _data select 0;
private _uidmember = _data select 1;

private _num = ctrlText 29514;
if !([_num] call TON_fnc_isnumber) exitWith {};
_num = parseNumber(_num);
if(_num < 1) exitWith {};
_pourcentToPref = (_num * 0.10);

private _var = _business getVariable ["business",[]];
private _capitalstr = _var select 3;
private _siretstr = _var select 2;

if(_capitalstr < (_num + _pourcentToPref)) exitWith {["INFO","Vous n'avez pas assez dans votre capital.","warning"] spawn ALF_fnc_doMsg;};

private _unit = playableUnits param [playableUnits findIf {getPlayerUID _x isEqualTo _uidmember}, objNull];
if(isNull _unit) exitWith {["INFO","Cette personne n'est pas disponible.","warning"] spawn ALF_fnc_doMsg;};

private _action = [format["Etes-vous certain de vouloir payer %1€ cette personne?",_num],"Entreprise","OUI","NON"] call BIS_fnc_guiMessage;
if (!_action) exitWith {["INFO","Annulation..","warning"] spawn ALF_fnc_doMsg;};

private _isDeclare = 0;
_action = [format["Voulez-vous déclarer cette fiche de paie ? Le montant retiré au capital de votre entreprise sera de %1€. Toute non déclaration est sanctionnable par le FISC.",floor(_num*1.15)],"Entreprise","OUI","NON"] call BIS_fnc_guiMessage;
if (_action) then {_isDeclare = 1;};

_capitalstr = floor(_capitalstr - _num);
_var set[3,_capitalstr];

_business setVariable ["business",_var,true];

private _display = findDisplay 29500;
private _capital = _display displayCtrl 29503;
_capital ctrlSetStructuredText parseText format["<t style='0' align='left' shadow='0' color='#000000' size='1'>%1€</t>",[_capitalstr] call ALF_fnc_numberText];

[_num] remoteExec ["ALF_fnc_getPaidBusiness",_unit];

[_siretstr,_capitalstr] remoteExec ["ALF_Server_fnc_capitalBusiness",2];
[_siretstr,_namemember,_num,_isDeclare] remoteExec ["ALF_Server_fnc_BusinessToFisc",2];

if (_isDeclare isequalto 1) then 
{
	private _prefBuilding = ("Land_MRP_Prefecture2" allObjects 0) # 0;
	private _pref = _prefBuilding getVariable ["business",[]];
	_siretPref = _pref # 2;
	_capitalPref = _pref # 3;
	_capitalwithAdd = _capitalPref + _pourcentToPref;
	_pref set[3,_capitalwithAdd];
	_prefBuilding setVariable ["business",_pref,true];
	[_siretPref,_capitalwithAdd] remoteExec ["ALF_Server_fnc_capitalBusiness",2];
};