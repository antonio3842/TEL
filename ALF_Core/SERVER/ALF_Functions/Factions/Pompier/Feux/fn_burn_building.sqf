_allow_multiples_fire = getNumber(configFile >> "ALF_ConfigClient_Core" >> "ByScream_Incendie_V3" >> "allow_multiples_fire");
if (missionNamespace getVariable ["byscream_incendieencours", false] && (_allow_multiples_fire isEqualTo 0) || !ALF_fireON) exitWith {};

_house = param [0, objNull, [objNull]];
if (isNull _house) exitWith {};

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

_house setVariable ["IsOnfire", true, true];
missionNamespace setVariable ["byscream_incendieencours", true, true];

_marker_text = selectRandom (getArray(configFile >> "ALF_ConfigClient_Core" >> "ByScream_Incendie_V3" >> "building_marker_text"));
/*_marker = createMarkerLocal [str _house, position _house];
	_marker setMarkerColorLocal "ColorRed";
	_marker setMarkerTextLocal _marker_text;
_marker setMarkerTypeLocal "mil_warning";*/
_info = [str _house, position _house, "ColorRed", _marker_text, "mil_warning"];
byscream_fires_marker pushBack _info;
publicVariable "byscream_fires_marker";

["INCENDIE", format["Nouvelle intervention: %1", _marker_text]] remoteExec ["ALF_fnc_doMedCall", (playableUnits select {
	_x getVariable ["MedService", false]
})];

private _positions = _house buildingPos -1;

if (_positions isEqualTo []) then {
	_boudingbox = boundingBox _house;
	_xmin = (_boudingbox select 0) select 0;
	_xmax = (_boudingbox select 1) select 0;
	_ymin = (_boudingbox select 0) select 1;
	_ymax = (_boudingbox select 1) select 1;
	_nombre_flammes = [1, 8] call BIS_fnc_randomInt;
	for "_i" from 1 to _nombre_flammes do {
		_posx = [_xmin, _xmax] call BIS_fnc_randomNum;
		_posy = [_ymin, _ymax] call BIS_fnc_randomNum;
		_pos = _house modelToWorld [_posx, _posy, 0];
		_positions pushBack [_pos select 0, _pos select 1, (getPos _house) select 2];
	};
};

private _fires = [];
{
	if !(((nearestObject[_x, "#particlesource"]) distance _x) < 1.5) then {
		private _feu = "#particlesource" createVehicle _x;
		_feu setParticleClass "BigDestructionFire";
		_feu setParticleFire [0.05, 5, 0.75];
		_feu setPos _x;
		byscream_fires pushBack _feu;
		publicVariable "byscream_fires";
		_fires pushBack _feu;

		_fumee = "#particlesource" createVehicle (_x vectorAdd [0, 0, 5]);
		_fumee setParticleClass "BigDestructionSmoke";
		_fumee setPos (_x vectorAdd [0, 0, 5]);

		_son = createSoundSource ["byscream_son_flamme", _x, [], 0];
		missionNamespace setVariable [format["flamme_%1", str (getPos _feu)], [_fumee, _son], true];
		sleep (random 1);
	};
} forEach _positions;

private _randomizePosition = {
	private _position = param[0, [], [[]]];
	[ (_position select 0) + ((random 6) - 3), (_position select 1) + ((random 6) - 3), 0 ];
};

_house spawn {
	_burntime = getNumber(configFile >> "ALF_ConfigClient_Core" >> "ByScream_Incendie_V3" >> "building_burn_time");
	uiSleep _burntime;
	_this setVariable ["IsOnfire", false, true];
};

while { (_house getVariable "IsOnfire") } do {
	if (objNull in _fires) then {
		{
			_fires = _fires - [objNull];
		} forEach _fires;
	};
	if (((count _fires) < 1)) then {
		_house setVariable ["IsOnfire", false, true];
	};
	if ((count _fires) < 10) then {
		_random = random 10;
		if (_random <= 5) then {
			private _feu = "#particlesource" createVehicle [0, 0, 0];
			_feu setParticleClass "BigDestructionFire";
			_feu setParticleFire [0.05, 5, 0.75];
			_feu setPos ([getPos _house] call _randomizePosition);
			byscream_fires pushBack _feu;
			publicVariable "byscream_fires";
			_fires pushBack _feu;

			_fumee = "#particlesource" createVehicle ((getPos _feu) vectorAdd [0, 0, 5]);
			_fumee setParticleClass "BigDestructionSmoke";
			_fumee setPos (getPos _feu);

			_son = createSoundSource ["byscream_son_flamme", (getPos _feu), [], 0];
			missionNamespace setVariable [format["flamme_%1", str (getPos _feu)], [_fumee, _son], true];
		};
	};
	uiSleep 15;
};
byscream_fires_marker = byscream_fires_marker - [_info];
publicVariable "byscream_fires_marker";
missionNamespace setVariable ["byscream_incendieencours", false, true];
{
	if (_x in byscream_fires) then {
		byscream_fires = byscream_fires - [_x];
		publicVariable "byscream_fires";
	};

	{
		deleteVehicle _x;
	} forEach (missionNamespace getVariable[format["flamme_%1", str (getPos _x)], []]);
	deleteVehicle _x;

	uiSleep 5 + (random 5);
} forEach (_fires);