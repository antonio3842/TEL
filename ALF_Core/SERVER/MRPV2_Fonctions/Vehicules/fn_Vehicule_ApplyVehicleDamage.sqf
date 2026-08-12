//nono test git

params ["_veh", "_listeDegats"];

if (isNull _veh || {_listeDegats isEqualTo []}) exitWith {};

private _parts = getAllHitPointsDamage _veh;
if (_parts isEqualTo []) exitWith {};

{
    private _hitPoint = (_parts # 0) # _foreachIndex;
    private _degat = _x;
    _veh setHitPointDamage [_hitPoint, _degat];
} forEach _listeDegats;