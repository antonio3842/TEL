#include "\ALF_Client\script_macros.hpp"
/*
  File: fn_minageSystem.sqf
  Farming System by ALF Team
*/
private _rocku = _this select 0;
private _hits = _this select 1;
//reset hit time
if((time - life_hit_time) > 10) then {life_ALF_Hit = 0;};
life_hit_time = time;

life_ALF_Hit = life_ALF_Hit + 1;

//Regulation XP

if (life_ALF_Hit > _hits) then {
	private "_obj";
	private _objects = nearestObjects [player, ["groundweaponholder"], 1.5];
	if (_objects isEqualTo []) then {
		_obj = "groundweaponholder" createVehicle [0,0,0];
		_obj setPosATL (getPosATL player);
	} else {
		_obj = _objects select 0;
	};
	_obj addMagazineCargoGlobal [_rocku,1];
	life_ALF_Hit = 0;
};
