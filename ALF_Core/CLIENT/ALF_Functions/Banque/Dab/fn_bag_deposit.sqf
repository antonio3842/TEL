/*
	File: fn_bag_deposit.sqf
	Author: ALF Dev Team
*/

params [
	["_dab",objNull,[objNull]]
];

if (isNull _dab) exitWith {};
if (life_action_inUse || {life_istazed} || {ALF_ActivePrisePistolet} || {ALF_Phone_tryCall} || {ALF_Phone_inCall} || {[player] call ALF_fnc_checkMenotter} || {[player] call ALF_fnc_checkSurrender} || {animationState player isEqualTo "crew"} || {lifeState player isEqualTo "INCAPACITATED"} || {!alive player} || {player getVariable ["ReviveMedic",false]}) exitWith {};

private _obj = player getVariable ["wallet_obj", objNull];
if (isNull(_obj)) exitWith {
	["Distributeur", "Vous n'avez pas de valise de billets.", "warning"] spawn ALF_fnc_doMsg;
};

private _building = objNull;
{
	if (((_x getVariable ["business",["","",""]]) select 2) isEqualTo (player getVariable ["isEmployed",""])) exitWith {
		_building = _x;
	};
} forEach ALF_allBusinesss;

if (isNull _building) exitWith {
	["Distributeur", "Vous n'êtes pas employé dans une entreprise.", "warning"] spawn ALF_fnc_doMsg;
};

// Vérifier si le DAB est plein via la BDD AVANT de supprimer la valise
private _pos = getPos _dab;
private _posKey = format ["%1_%2", round (_pos # 0), round (_pos # 1)];

ALF_DAB_CheckResult = nil;
[_posKey, player] remoteExecCall ["ALF_Server_fnc_checkDABDispo", hc_3];

private _timeout = diag_tickTime + 5;
waitUntil {!isNil "ALF_DAB_CheckResult" OR {diag_tickTime > _timeout}};

if (isNil "ALF_DAB_CheckResult") exitWith {
	["Distributeur", "Erreur de connexion au serveur.", "danger"] spawn ALF_fnc_doMsg;
};

if (ALF_DAB_CheckResult >= 200000) exitWith {
	ALF_DAB_CheckResult = nil;
	["Distributeur", "Le distributeur est déjà plein.", "danger"] spawn ALF_fnc_doMsg;
};
ALF_DAB_CheckResult = nil;

life_action_inUse = true;

player playMove "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";
uiSleep 1.5;
detach _obj;
deleteVehicle _obj;
player setVariable ["wallet_obj", objNull];

[_posKey, 20000, player] remoteExecCall ["ALF_Server_fnc_updateDABDispo", hc_3];

private _var = _building getVariable ["business",[]];
private _capitalstr = _var select 3;
private _siretstr = _var select 2;

private _newvalue = floor(_capitalstr + 15000);
_var set[3,_newvalue];

_building setVariable ["business",_var,true];

[_siretstr,_newvalue] remoteExec ["ALF_Server_fnc_capitalBusiness",2];

["Distributeur", "Vous avez ajouté 20k€ au distributeur !", "success"] spawn ALF_fnc_doMsg;
life_action_inUse = false;