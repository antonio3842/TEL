#include "\ALF_Client\script_macros.hpp"
/*
	File: fn_lbChangedSmsSony.sqf
	Author: ALF Nanou
*/
disableSerialization;
private _text = ((findDisplay 20520) displayCtrl 39145);
private _data = lbData[39144,lbCurSel (39144)];
private _replyButton = ((findDisplay 20520) displayCtrl 39146);
if(_data isEqualTo "Vous n'avez pas de messages.") then {
	_text ctrlSetStructuredText parseText  format["<t shadow='0' color='#000000' font='HelveticaLTLight' size='1'>Vous n'avez pas de messages.</t>"];
} else {
	private _data = call compile _data;
	private _number = _data select 0;
	private _name = _data select 1;
	private _msg = _data select 2;
	private _anonyme = _data select 3;
	if(_anonyme isEqualTo "1") then {
		_number = "**********";
		_name = "Anonyme";
		_text ctrlSetStructuredText parseText format ["<t shadow='0' color='#000000' font='HelveticaLTLight' size='1'>%2 - %3 : %1</t>", _msg,_name,_number];
		_replyButton ctrlShow false;
	} else {
		_text ctrlSetStructuredText parseText format ["<t shadow='0' color='#000000' font='HelveticaLTLight' size='1'>%2 - %3 : %1</t>", _msg,_name,_number];
		_replyButton ctrlShow true;
		_replyButton buttonSetAction "uiNamespace setVariable ['sonypm',13]; [] call ALF_fnc_menuSonyPM;";
	};
};
