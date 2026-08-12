/*
	File: fn_iPhoneRadioDisconnect.sqf
	Author: ALF Team
*/
private _myRadio = _this select 0;
life_radio_connected = false;
player setVariable ["tf_unable_to_use_radio", true];
[_myRadio, 1, getPlayerUID player] call TFAR_fnc_SetChannelFrequency;
[_myRadio, 2, getPlayerUID player] call TFAR_fnc_SetChannelFrequency;
if(ALF_Sony_FreqAdd isEqualTo 60) then {[_myRadio, 1] call TFAR_fnc_setAdditionalSwChannel;};

private _groupe_GN = units ((groups civilian select {"Gendarmerie" in groupid _x}) # 0);
if (isnil {_groupe_GN}) then {_groupe_GN = [];};

private _liste_Id_Groupe_GN = _groupe_GN apply {_x getVariable ["ALF_ownerID",2]};

player setVariable ["SonyFreq",0,[2] + _liste_Id_Groupe_GN];
player setVariable ["SonyFreqAdd",0,[2] + _liste_Id_Groupe_GN];
ALF_Sony_Freq = 0;
ALF_Sony_FreqAdd = 0;