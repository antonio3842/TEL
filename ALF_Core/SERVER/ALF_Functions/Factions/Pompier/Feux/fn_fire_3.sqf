_object = param[0,objNull];
if !(alive _object) exitWith {
	[_object] remoteExec ["ALF_fnc_local_delete_fire",-2];
	deleteVehicle (_object getVariable "effects");
	uiSleep 0.1;
	deleteVehicle _object;
};

_object setVariable ["effects",[],true];

[_object] remoteExec ["ALF_fnc_local_fire_3",-2];

_OverWater0 = surfaceIsWater (getpos _object);
if (_OverWater0) exitWith {
	[_object] remoteExec ["ALF_fnc_local_delete_fire",-2];
	deleteVehicle (_object getVariable "effects");
	uiSleep 0.1;
	deleteVehicle _object;
};

_objPos = getpos _object;
_burned_grnd = createVehicle ["Land_ByScream_sol_carbo", _objPos, [], 0, "CAN_COLLIDE"];

[_object] remoteExec ["ALF_fnc_steam_fire",-2];
[_object] spawn ALF_Server_fnc_fire_prop_wind;
[_object] spawn ALF_Server_fnc_fire_prop_wind;
_pos01 = getPos _object;
_son = createSoundSource ["byscream_son_flamme", _pos01, [], 0];
_son attachto [_object,[0,0,0]];
_object setVariable ["effects",_son,true];
_markerfire_3 = createMarkerLocal [("fire3" + str _pos01), _pos01];
_markerfire_3 setMarkerShape "ELLIPSE";
_markerfire_3 setMarkerBrush "Solid";
_markerfire_3 setMarkerSizeLocal [14, 14];
_markerfire_3 setMarkerColorLocal "ColorRed";

_coeff = getNumber (configFile >> "ALF_ConfigClient_Core" >> "ByScream_Incendie_V3" >> "coefficient_propagation");
if (_coeff == 0) then {_coeff = 1;}; 
while {alive _object} do {
	{_x setDamage (getDammage _x + 0.020);} foreach ((nearestObjects [_object,[],10]) - ((nearestObjects [_object,["ByScream_fire","byscream_demi_raccord45"],15])) - allPlayers);
	uiSleep ((1.0 + random 1.0)*_coeff);
};

if !(alive _object) then {
	_markerfire_3 setMarkerColorLocal "ColorBlack";
};


[_object] remoteExec ["ALF_fnc_local_delete_fire",-2];
deleteVehicle (_object getVariable "effects");
uiSleep 1;
deleteVehicle _object;