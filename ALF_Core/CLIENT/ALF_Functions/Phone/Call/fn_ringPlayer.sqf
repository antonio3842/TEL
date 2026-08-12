/*
	File: fn_ringPlayer.sqf
	Author: ALF Team
	Input: _Anonyme,_Number,_unit
*/
params [
	["_anonyme",false,[false]],
	["_hisNumber","",[""]]
];
if(_hisNumber isEqualTo "") exitWith {player setVariable ["call_info",0,2];};

//Si pas de tel, exit.
private _radios = player call TFAR_fnc_radiosList;
if(count _radios isEqualTo 0) exitWith {player setVariable ["call_info",0,2];};

//Si en appel ou autre, exit.
if(ALF_Phone_inCall OR {ALF_Phone_Ring} OR {ALF_Phone_tryCall}) exitwith {};

//Si il est en mode avion.
if (ALF_Phone_Avion) exitWith {player setVariable ["call_info",0,2];};

private _radio = tolower (call TFAR_fnc_activeSwRadio);

// Ligne privée : GN / PM / Pompier reçoivent l'appel en service ou hors service.

//Tout est bon. On lance la sonnerie.
ALF_Phone_Ring = true;
ALF_Phone_CallNumber = _hisNumber;
ALF_Phone_CallAnonyme = _anonyme;

private _allRadiosStr = tolower str (player call TFAR_fnc_radiosList);
private _hasTabletteSP = "sonypo" in _allRadiosStr;

[] spawn ALF_fnc_doCallIn;

if !(isNull (findDisplay 20000)) then {
	uiNamespace setVariable ['nokiamenu',0];
	[] call ALF_fnc_menuNokia;
};
if !(isNull (findDisplay 56400)) then {
	uiNamespace setVariable ['iphonemenu',0];
	[] call ALF_fnc_menuiPhone;
};

if ("alf_neogend" in _radio) then {
	if (!isNull (findDisplay 32999)) then {
		uiNamespace setVariable ['sony', 0];
		[] call ALF_fnc_menuSony;
	};
};
if ("alf_sonypo" in _radio) then {
	if (!isNull (findDisplay 38999)) then {
		uiNamespace setVariable ['sonyp', 0];
		[] call ALF_fnc_menuSonyP;
	};
};
if ("alf_sonypm" in _radio) then {
	if (isNull (findDisplay 20520)) then {
		uiNamespace setVariable ['sonypm', 0];
		[] call ALF_fnc_menuSonyPM;
	};
};

private _hour = date select 3;
private _min = date select 4;
if(_min >= 0 && _min <= 9) then {_min = format["0%1", _min];};
private _time = format["%1:%2",_hour,_min];
private _data = [_time,ALF_Phone_CallAnonyme,1,ALF_Phone_CallNumber];
ALF_Phone_Historique pushBack _data;

for "_i" from 0 to 5 step 1 do {
	if !(ALF_Phone_Ring) exitWith {};
	if !(life_is_alive) exitWith {};

	private _radios = player call TFAR_fnc_radiosList;

	if(count _radios < 1) exitWith {};
	if !([(call TFAR_fnc_activeSwRadio),_radio] call TFAR_fnc_isSameRadio) exitWith {};

	if !(ALF_Phone_Mute) then {
		if("alf_3310" in _radio) then {
			[player,"nokia_ring"] remoteExecCall ["ALF_fnc_say3D",0];
		};
		if ("alf_iphone" in _radio) then {
			[] spawn ALF_fnc_iPhoneRing;
		};
		if("alf_neogend" in _radio) then {
			[player,"SonyRing"] remoteExecCall ["ALF_fnc_say3D",0];
		};
		if ("alf_sonypo" in _radio) then {
			[player, "SonyRing"] remoteExecCall ["ALF_fnc_say3D", 0];
		};
		if("alf_sonypm" in _radio) then {
			[player,"SonyRing"] remoteExecCall ["ALF_fnc_say3D",0];
		};
	} else {
		playSound "ring_vibreur";
	};
	sleep 5;
};
if(ALF_Phone_Ring) exitWith {[] call ALF_fnc_resetcall;};