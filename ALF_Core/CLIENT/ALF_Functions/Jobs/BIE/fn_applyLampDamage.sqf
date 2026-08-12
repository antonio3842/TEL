/*
    File: fn_applyLampDamage.sqf
    Author: ALF TEAM
*/
params [
    ["_lamp", objNull, [objNull]],
    ["_damage", 0, [0]]
];
if (isNull _lamp) exitWith {};

_lamp setHitPointDamage ["#light_1_hitpoint", _damage];
_lamp setHitPointDamage ["#light_2_hitpoint", _damage];
_lamp setHitPointDamage ["#light_3_hitpoint", _damage];
_lamp setHitPointDamage ["#light_4_hitpoint", _damage];