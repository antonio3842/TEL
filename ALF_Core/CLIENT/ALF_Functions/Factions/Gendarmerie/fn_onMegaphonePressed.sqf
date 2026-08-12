/*
	File: fn_onMegaphobePressed.sqf
	Author: ALF Team
*/

if (!(typeOf (vehicle player) in ["V_ALF_GIGN","V_ALF_GIGN_g_naked","V_ALF_SVR_G","V_ALF_DV15_Gendarmerie","ALF_Peugeot_5008_2021_GN"]) && !((typeOf (vehicle player)) find "Gendarmerie" > -1) && !((typeOf (vehicle player)) find "GND" > -1)) exitWith {};

private _freq = (vehicle player) getVariable ["Megaphone",0];
if (_freq isEqualTo 0) exitWith {["INFO","Le mégaphone n'est pas activé dans ce véhicule. CTRL+Y pour l'activer.","warning"] spawn ALF_fnc_doMsg;};
if (ALF_Phone_inCall OR {ALF_Phone_tryCall}) exitWith {["INFO","Vous ne pouvez pas appeler et utiliser le mégaphone en même temps.","warning"] spawn ALF_fnc_doMsg;};

/*
_radio = call TFAR_fnc_activeSwRadio;
[format[localize "STR_transmit",format ["%1<img size='1.5' image='%2'/>", getText (ConfigFile >> "CfgWeapons" >> _radio >> "displayName"),getText(configFile >> "CfgWeapons" >> _radio >> "picture")], 1, _freq],
format[
        "TANGENT	PRESSED	%1%2	%3	%4	%5",
        _freq, _radio call TFAR_fnc_getSwRadioCode, 
        getNumber(configFile >> "CfgWeapons" >> _radio >> "tf_range") * (call TFAR_fnc_getTransmittingDistanceMultiplicator), 
		getText(configFile >> "CfgWeapons" >> _radio >> "tf_subtype"),
        _radio
]] call TFAR_fnc_ProcessTangent;
*/

private _freq = (vehicle player) getVariable ["Megaphone",0];
[
	"", 
	format[
		"TANGENT_LR	PRESSED	%1%2	%3	%4	%5", 
		_freq, "_bluefor",
        10000  * (call TFAR_fnc_getTransmittingDistanceMultiplicator),
		"airborne",
		"alf_megaphone"
	]
] call TFAR_fnc_processTangent;

megaphone_speaking = true;

[] spawn {
	for "_i" from 0 to 1 step 0 do {
		if !(megaphone_speaking) exitWith {};
		if((vehicle player) isEqualTo player) exitWith {[] call ALF_fnc_onMegaphoneReleased;};
		if(!alive player) exitWith {[] call ALF_fnc_onMegaphoneReleased;};
		sleep 0.2;
	};
};