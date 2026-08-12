#include "\ALF_Client\script_macros.hpp"
/*
File: fn_receptionSmsPhone.sqf
Author: ALF Team
Description:

*/
private["_anonyme","_nameExpediteur","_numberExpediteur","_msg"];
_anonyme = _this select 0;
_numberExpediteur = _this select 1;
_msg = _this select 2;

_nameExpediteur = "Inconnu";
{
	if ((_x select 1) isEqualTo _numberExpediteur) then {_nameExpediteur = _x select 0;};
} forEach life_contacts;
if (_anonyme isEqualTo 1) then {_nameExpediteur = "Anonyme"; _numberExpediteur = "**********";};

private _radios = player call TFAR_fnc_radiosList;
private _radio = tolower (call TFAR_fnc_activeSwRadio);

if(count _radios > 0) then {
	if("alf_3310" in _radio) then {
		hint parseText format ["<t color='#FFCC00'><t size='2'><t align='center'>SMS<br/><t color='#33CC33'><t align='left'><t size='1'><br/><t color='#33CC33'>De: <t color='#ffffff'>%1<br/>(%2)<br/><t color='#33CC33'>Message:<br/><t color='#ffffff'>%3",_nameExpediteur,_numberExpediteur,_msg];
	};
	if ("alf_iphone" in _radio) then {
		[format["%1 - %2",_nameExpediteur,_numberExpediteur],_msg] spawn ALF_fnc_doSms;
	};
	if !(ALF_Phone_Mute) then {
		if("alf_3310" in _radio) then {
			[player,"nokia_sms"] remoteExec ["ALF_fnc_say3D",RANY];
		};
		if ("alf_iphone" in _radio) then {
			[player,"iPhone_sms"] remoteExec ["ALF_fnc_say3D",RANY];
		};
		if("alf_neogend" in _radio) then {
			[player,"Sony_sms"] remoteExec ["ALF_fnc_say3D",RANY];
		};
		if("alf_SonyPo" in _radio) then {
			[player,"Sony_sms"] remoteExec ["ALF_fnc_say3D",RANY];
		};
		if("alf_sonypm" in _radio) then {
			[player,"Sony_sms"] remoteExec ["ALF_fnc_say3D",RANY];
		};
	} else {
		playSound "sms_vibreur";
	};
	ALF_Phone_SMS = true;
};
