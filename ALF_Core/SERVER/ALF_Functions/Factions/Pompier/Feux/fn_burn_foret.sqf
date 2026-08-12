_allow_multiples_fire = getNumber(configFile >> "ALF_ConfigClient_Core" >> "ByScream_Incendie_V3" >> "allow_multiples_fire");
if (missionNamespace getVariable ["byscream_incendieencours", false] && (_allow_multiples_fire isEqualTo 0) || !ALF_fireON) exitWith {};

missionNamespace setVariable ["byscream_incendieencours", true, true];
private _co = nearestObjects [[8000, 8000, 0], ["Land_Caserne_MRP"], 20000];
[_co] spawn {
	private _com = _this select 0;
	private _timer = 0;
	for "_i" from 0 to 1 step 0 do {
		if (_timer > 2) exitWith {};
		_timer = _timer + 1;
		{
			playSound3D ["ALF_Client2\sounds\pompier_alarm.ogg", _x, false, _x modelToWorld [0, 0, 0], 1, 1, 150];
		} forEach _com;
		uiSleep 27;
	};
};

_position = ((selectBestPlaces [[worldSize/2, worldSize/2, 0], (sqrt 2) / 2 * worldSize, "trees", 50, 1]) select 0) select 0;

_marker_text = selectRandom (getArray(configFile >> "ALF_ConfigClient_Core" >> "ByScream_Incendie_V3" >> "foret_marker_text"));
/*_marker = createMarker [str _position, _position];
_marker setMarkerColor "ColorRed";
_marker setMarkerText _marker_text;
_marker setMarkerType "mil_warning";*/
_info = [str _position, _position, "ColorRed", _marker_text, "mil_warning"];
byscream_fires_marker pushBack _info;
publicVariable "byscream_fires_marker";

["INCENDIE",format["Nouvelle intervention: %1",_marker_text]] remoteExec ["ALF_fnc_doMedCall",(playableUnits select {_x getVariable ["MedService",false]})];

_bidon = "ByScream_fire" createVehicle (_position);
[_bidon] spawn ALF_Server_fnc_fire_1;

[] spawn {
	_burntime = getNumber(configFile >> "ALF_ConfigClient_Core" >> "ByScream_Incendie_V3" >> "foret_burn_time");
	uiSleep _burntime;
	{
		_x setDamage 1;
	} forEach (nearestObjects [[worldSize/2, worldSize/2], ["ByScream_fire"], (sqrt 2) / 2 * worldSize]);
};

uiSleep 10;

while { true } do {
	if ((count (nearestObjects [[worldSize/2, worldSize/2], ["ByScream_fire"], (sqrt 2) / 2 * worldSize])) == 0) exitWith {
		//deleteMarker _marker;
		byscream_fires_marker = byscream_fires_marker - [_info];
		publicVariable "byscream_fires_marker";
		missionNamespace setVariable ["byscream_incendieencours", false, true];
	};
	uiSleep 15;
};