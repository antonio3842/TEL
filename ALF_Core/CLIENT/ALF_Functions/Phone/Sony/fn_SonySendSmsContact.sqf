#include "\ALF_Client\script_macros.hpp"
/*
File: fn_iPhoneSmsContactSend.sqf
Author: ALF Team
Description:
Envois d'un sms depuis l'iPhone'.
*/
private["_number","_datamsg"];
_number = _this select 0;
disableSerialization;
_datamsg = ctrlText 33152;

if(_datamsg isEqualTo "") exitWith {hint "Votre message est vide.";};
private _length = count (toArray(_datamsg));
private _chrByte = toArray (_datamsg);
private _allowed = toArray("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.,'-/[]éàç€!?;:êè)(=+&<>*$ ");
if(_length > 500) exitWith {hint "Vous ne pouvez écrire que 500 caractères max."};
private _badChar = false;
{if(!(_x in _allowed)) exitWith {_badChar = true;};} forEach _chrByte;
if(_badChar) exitWith {hint localize "STR_GNOTF_IncorrectChar";};

if(ALF_Forfait isEqualTo 0) exitWith {hint "Votre forfait est épuisé.";};

private _anonyme = 0;
if (ALF_Phone_Anonyme) then {_anonyme = 1;} else {_anonyme = 0;};

if !(ALF_Phone_Mute) then {
	[player,"message_sent"] remoteExecCall ["ALF_fnc_say3D",0];
} else {
	playSound "message_sent";
};

[_anonyme,ALF_Phone_Number,_number,_datamsg] remoteExec ["ALF_Server_fnc_sendSmsPhone",2];

closeDialog 0;
