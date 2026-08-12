#include "\ALF_Client\script_macros.hpp"
/*
File: achatLeboncoin.sqf
Author: ALF Nanou
*/
disableSerialization;
if((lbCurSel 24532) isEqualTo -1) exitWith {hint "Vous n'avez rien selectionné."};
private _nop = false;

private _data = CONTROL_DATA(24532);
_data = call compile format["%1",_data];

private _houseCfg = [_data select 3] call ALF_fnc_houseConfig;
if((count _houseCfg) > 0) then {
	private _houseLimitC = ["NUMBER", ["Life_Settings", "house_limit"]] call ALFTools_Client_Config_fnc_getConfig;
	if (life_donOR) then {
		_houseLimitC = ["NUMBER", ["Life_Settings", "house_limit_donor"]] call ALFTools_Client_Config_fnc_getConfig;
	};
	if(count life_houses >= _houseLimitC) then {_nop = true;};
};
if(_nop) exitWith {hint format["Vous ne pouvez pas acheter plus de %1 maisons.",_houseLimitC]};

private _action = [format["Etes-vous certain de vouloir acheter ce véhicule/maison d'une valeur de %1€?",[_data select 6] call ALF_fnc_numberText],"Leboncoin","OUI","NON"] call BIS_fnc_guiMessage;
if (!_action) exitWith {["INFO","Annulation..","warning"] spawn ALF_fnc_doMsg;};

closeDialog 0;

[_data select 0,_data select 2,_data select 6,player,_data select 1] remoteExec ["ALF_Server_fnc_checkLeboncoin",2];
