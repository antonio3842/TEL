#include "\ALF_Client\script_macros.hpp"
/*
File: annulerLeboncoin.sqf
Author: ALF Nanou
*/
disableSerialization;
if((lbCurSel 24532) isEqualTo -1) exitWith {hint "Vous n'avez rien selectionné."};

private _data = CONTROL_DATA(24532);
_data = call compile format["%1",_data];

private _action = ["Etes-vous certain de vouloir annuler cette annonce?","Leboncoin","OUI","NON"] call BIS_fnc_guiMessage;
if (!_action) exitWith {};

private _nop = false;
private _houseCfg = [_data select 3] call ALF_fnc_houseConfig;
if((count _houseCfg) > 0) then {
	private _houseLimitC = ["NUMBER", ["Life_Settings", "house_limit"]] call ALFTools_Client_Config_fnc_getConfig;
	if (life_donOR) then {
		_houseLimitC = ["NUMBER", ["Life_Settings", "house_limit_donor"]] call ALFTools_Client_Config_fnc_getConfig;
	};
	if(count life_houses >= _houseLimitC) then {_nop = true;};
};
if(_nop) exitWith {hint format["Vous ne pouvez pas, vous avez déjà %1 maisons.",_houseLimitC]};

closeDialog 0;

[_data select 0,_data select 2,getPlayerUID player,player] remoteExec ["ALF_Server_fnc_annulerLeboncoin",2];
