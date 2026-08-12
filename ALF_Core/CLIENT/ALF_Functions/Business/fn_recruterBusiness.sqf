#include "\ALF_Client\script_macros.hpp"
/*
File: recruterBusiness.sqf
Author: ALF Nanou
*/
private["_business"];
_business = _this # 0;

private _var = _business getVariable ["business",[]];
private _siretstr = _var # 2;
private _secteur = _var # 4;
private _membres = _var # 5;
private _levelstr = _var # 6;

private _namenew = ctrlText 29513;
private _secunew = ctrlText 29505;

if(_namenew isEqualTo "" OR {_secunew isEqualTo ""}) exitWith {};

private _myuid = getPlayerUID player;
if(_myuid isEqualTo _secunew) exitWith {["INFO","Vous ne pouvez pas vous ajouter vous-même.","warning"] spawn ALF_fnc_doMsg;};

private _exit = false;
{
	private _uidmember = _x # 1;
	if(_secunew isEqualTo _uidmember) exitWith {_exit = true;};
} forEach _membres;
if (_exit) exitWith {["INFO","Cette personne fait déjà partis de votre personnel.","warning"] spawn ALF_fnc_doMsg;};

private _unit = playableUnits param [playableUnits findIf {getPlayerUID _x isEqualTo _secunew}, objNull];
if (isNull _unit) exitWith {["INFO","Cette personne n'existe pas.","warning"] spawn ALF_fnc_doMsg;};

missionNamespace setVariable ["ALF_DemandeEmployee",""];
[2] remoteExecCall ["ALF_fnc_initBusinessPlayer",_unit];
waitUntil{(missionNamespace getVariable "ALF_DemandeEmployee") isEqualType false};
if (missionNamespace getVariable "ALF_DemandeEmployee") exitWith {["INFO","Cette personne est déjà employée.","warning"] spawn ALF_fnc_doMsg;};

//if(_levelstr isEqualTo 0 AND {count _membres > 5}) exitWith {["INFO","Il faut agrandir votre batiment si vous voulez embaucher plus de monde.","warning"] spawn ALF_fnc_doMsg;};

private _action = [format["Etes-vous certain de vouloir recruter %1 dans votre entreprise ?",_namenew],"Entreprise","OUI","NON"] call BIS_fnc_guiMessage;
if !(_action) exitWith {["INFO","Annulation..","warning"] spawn ALF_fnc_doMsg;};

_membres pushBack [_namenew,_secunew,1];
_var set[10,_membres];

_business setVariable ["business",_var,true];

private _display = findDisplay 29500;
private _list = _display displayCtrl 29506;

lbClear _list;
{
	private _membername = _x # 0;
	_list lbAdd format["%1",_membername];
	_list lbSetdata [(lbSize _list)-1,format["%1",_x]];
} forEach _membres;

["INFO",format["Vous venez d'être recruter dans l'entreprise de %1.",name player],"success"] remoteExec ["ALF_fnc_doMsg",_unit];
[0,_secteur,_siretstr] remoteExec ["ALF_fnc_initBusinessPlayer",_unit];
[_siretstr,_membres] remoteExec ["ALF_Server_fnc_recruterBusiness",2];