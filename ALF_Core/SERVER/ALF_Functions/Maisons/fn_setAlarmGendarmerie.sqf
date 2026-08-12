/*
	File: fn_setAlarmGendarmerie.sqf
	Toggle alarm_gendarmerie on a house (0 = simple, 1 = gendarmerie)
*/
params [
	["_house", objNull, [objNull]],
	["_unit", objNull, [objNull]],
	["_enable", 0, [0]]
];

if (isNull _house) exitWith {};

private _houseId = _house getVariable ["house_id", ""];
if (_houseId isEqualTo "") exitWith {};

// Update DB
[format["UPDATE houses SET alarm_gendarmerie='%1' WHERE id='%2'", _enable, _houseId], 1] call ALF_Server_fnc_asyncCall;

// Update variable on house
_house setVariable ["alarm_gendarmerie", _enable];

// Confirmation message to player
private _msg = if (_enable isEqualTo 1) then {
	"Alerte gendarmerie activee."
} else {
	"Alerte gendarmerie desactivee."
};
["Alarme", _msg, "success"] remoteExec ["ALF_fnc_doMsg", _unit];
