/*
  Applique les dégâts 2 fois en différé pour contrer les scripts qui "réparent".
  Usage (serveur):
    [_veh, _damageArray] remoteExec ["MRPV2_fnc_Vehicule_ApplyVehicleDamage_Delayed", _veh];
*/
params [
  ["_veh", objNull, [objNull]],
  ["_arr", [],      [[]]]
];

if (isNull _veh || {count _arr == 0}) exitWith {};

[_veh, _arr] call MRPV2_fnc_Vehicule_ApplyVehicleDamage;
uiSleep 0.2;
[_veh, _arr] call MRPV2_fnc_Vehicule_ApplyVehicleDamage;
uiSleep 2;
[_veh, _arr] call MRPV2_fnc_Vehicule_ApplyVehicleDamage;
