_origFire = param[0,objNull];
_Firecreate =  createVehicle ["ByScream_fire_2", getpos _origFire, [], 0, "CAN_COLLIDE"];
[_Firecreate] spawn ALF_Server_fnc_fire_2;