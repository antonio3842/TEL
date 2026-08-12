/*
    File: fn_actionLamps.sqf
    Author: ALF TEAM
*/

private _lampes = [];
_classesLumieres = [
    "Lamps_base_F",
    "Lamps_City_F",
    "Lamps_Ind_F",
    "Lamps_Military_F",
    "Lamps_Purka_F",
    "Land_LampAirport_F",
    "Land_LampHalogen_F",
    "Land_LampShabby_F",
    "Land_LampStreet_F",
    "Land_LampStreet_small_F",
    "Land_LampWood_F",
    "Land_LampSolar_F",
    "Land_Lamp_Road_F",
    "Land_LampBuilding_F",
	"Land_LampDecor_F",
    "Land_PortableLight_double_F",
    "Lights_base_F",
    "Lights_Interactive_F",
    "PowerLines_base_F",
    "PowerLines_Small_base_F"
];


_lampes = nearestObjects [player, _classesLumieres, 150];

{
    private _lamp = _x;
    private _damage = if ([_lamp] call ALF_fnc_hasEnergy) then { 0 } else { 1 };
	
    _lamp setHitPointDamage ["#light_1_hitpoint", _damage];
    _lamp setHitPointDamage ["#light_2_hitpoint", _damage];
    _lamp setHitPointDamage ["#light_3_hitpoint", _damage];
    _lamp setHitPointDamage ["#light_4_hitpoint", _damage];

    [_lamp, _damage] call ALF_fnc_applyLampDamage;

} forEach _lampes;
