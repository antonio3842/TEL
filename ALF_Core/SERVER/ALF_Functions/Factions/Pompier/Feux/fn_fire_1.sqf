_object = param[0,objNull];
if !(alive _object) exitWith {


	//REMOTE EXEC
	[_object] remoteExec ["ALF_fnc_local_delete_fire",-2];
	deleteVehicle (_object getVariable "effects");
	uiSleep 0.1;
	deleteVehicle _object;
};


_object setVariable ["effects",[],true];
[_object] remoteExec ["ALF_fnc_local_fire_1",-2];


_OverWater0 = surfaceIsWater (getpos _object);
if (_OverWater0) exitWith {

	//remote exec
	[_object] remoteExec ["ALF_fnc_local_delete_fire",-2];
	deleteVehicle (_object getVariable "effects");
	deleteVehicle _object;
};

_objPos = getpos _object;
_burned_grnd = createSimpleObject ["burned_grd_light", AGLtoASL _objPos];
_burned_grnd setVectorUP (surfaceNormal [(getPosATL _burned_grnd) select 0,(getPosATL _burned_grnd) select 1]);

[_object] remoteExec ["ALF_fnc_steam_fire",-2];
_pos01 = getPos _object;
_son = createSoundSource ["byscream_son_flamme", _pos01, [], 0];
_son attachto [_object,[0,0,0]];
_object setVariable ["effects",_son,true];
_markerfire_1 = createMarkerLocal [("fire1" + str _pos01), _pos01];
_markerfire_1 setMarkerShape "ELLIPSE";
_markerfire_1 setMarkerBrush "Solid";
_markerfire_1 setMarkerSizeLocal [8, 8];
_markerfire_1 setMarkerColorLocal "ColorRed";

_coeff = getNumber (configFile >> "ALF_ConfigClient_Core" >> "ByScream_Incendie_V3" >> "coefficient_propagation");
if (_coeff == 0) then {_coeff = 1;}; 
_boolean = false;
for "_i" from 0 to 16 step 1 do {
	{_x setDamage (getDammage _x + 0.020);} foreach ((nearestObjects [_object,[],10]) - ((nearestObjects [_object,["ByScream_fire","byscream_demi_raccord45"],15])) - allPlayers);
	if !(alive _object) exitWith {
		_markerfire_1 setMarkerColorLocal "ColorBlack";
		_boolean = true;
	};
	uiSleep ((1.0 + random 1.0)*_coeff);
};


if (!_boolean) then {
	[_object] spawn ALF_Server_fnc_fire_prop_L;
	_markerfire_1 setMarkerSizeLocal [11, 11];
	deleteMarkerLocal ("fire1" + str _pos01);
};

[_object] remoteExec ["ALF_fnc_local_delete_fire",-2];
deleteVehicle (_object getVariable "effects");
uiSleep 1;
deleteVehicle _object;