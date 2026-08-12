params [
    ["_vehicle",objNull,[objNull]]
];
if(isNull _vehicle) exitWith {}; //Bad vehicle type

_vehicle setHitPointDamage ["HitLFWheel",1];
_vehicle setHitPointDamage ["HitRFWheel",1];
