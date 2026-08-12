/*
  File: CLIENT/MRPV2_Fonctions/Vehicules/fn_Vehicule_ApplyVehicleDamage.sqf
  Desc: applique un profil de dégâts sur le véhicule local, en bornant
        à la vraie liste de hitpoints du modèle.
  Usage (serveur -> client):
    [_veh, _damageArray] remoteExecCall ["MRPV2_fnc_Vehicule_ApplyVehicleDamage", _veh];
*/

params [
  ["_veh", objNull, [objNull]],
  ["_arr", [],      [[]]]
];

if (isNull _veh || {count _arr == 0}) exitWith {};

private _parts   = getAllHitPointsDamage _veh;   // [ [hpNames], [], [values] ]
private _hpNames = _parts # 0;
private _max     = (count _hpNames) min (count _arr);

for "_i" from 0 to (_max - 1) do {
  _veh setHitPointDamage [format["%1", (_hpNames # _i)], _arr # _i];
};
