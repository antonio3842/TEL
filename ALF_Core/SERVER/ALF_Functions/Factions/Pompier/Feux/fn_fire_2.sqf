_object = param[0,objNull];
if !(alive _object) exitWith {
	[_object] remoteExec ["ALF_fnc_local_delete_fire",-2];
	deleteVehicle (_object getVariable "effects");
	uiSleep 0.1;
	deleteVehicle _object;
};

_object setVariable ["effects",[],true];

[_object] remoteExec ["ALF_fnc_local_fire_2",-2];

_OverWater0 = surfaceIsWater (getpos _object);
if (_OverWater0) exitWith {
	[_object] remoteExec ["ALF_fnc_local_delete_fire",-2];
	deleteVehicle (_object getVariable "effects");
	uiSleep 0.1;
	deleteVehicle _object;
};

[_object] remoteExec ["ALF_fnc_steam_fire",-2];
_pos01 = getPos _object;
_son = createSoundSource ["byscream_son_flamme", _pos01, [], 0];
_son attachto [_object,[0,0,0]];
_object setVariable ["effects",_son,true];
_markerfire_2 = createMarkerLocal [("fire2" + str _pos01), _pos01];
_markerfire_2 setMarkerShape "ELLIPSE";
_markerfire_2 setMarkerBrush "Solid";
_markerfire_2 setMarkerSizeLocal [11, 11];
_markerfire_2 setMarkerColorLocal "ColorRed";

_coeff = getNumber (configFile >> "ALF_ConfigClient_Core" >> "ByScream_Incendie_V3" >> "coefficient_propagation");
if (_coeff == 0) then {_coeff = 1;}; 
_boolean = false;
for "_i" from 0 to 21 do {
	{_x setDamage (getDammage _x + 0.020);} foreach ((nearestObjects [_object,[],10]) - ((nearestObjects [_object,["ByScream_fire","byscream_demi_raccord45"],15])) - allPlayers);
	if !(alive _object) exitWith {
		(_markerfire_2 setMarkerColorLocal "ColorBlack");
		_boolean = true;
	};
	uiSleep ((1.0 + random 1.0)*_coeff);
};

if !(_boolean) then {
	[_object] spawn ALF_Server_fnc_fire_prop_M;
	_markerfire_2 setMarkerSizeLocal [14, 14];
	deleteMarkerLocal ("fire2" + str _pos01);
};
[_object] remoteExec ["ALF_fnc_local_delete_fire",-2];
deleteVehicle (_object getVariable "effects");
uiSleep 1;
deleteVehicle _object;