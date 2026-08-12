private["_vehicle", "_fires"];
_vehicle = param [0, objNull, [objNull]];
_allow_multiples_fire = getNumber(configFile >> "ALF_ConfigClient_Core" >> "ByScream_Incendie_V3" >> "allow_multiples_fire");
//if (missionNamespace getVariable ["byscream_incendieencours", false] && (_allow_multiples_fire isEqualTo 0) || !ALF_fireON) exitWith {};
//if (((_vehicle) getHitPointDamage "HitEngine") > 0.9) then {

	_vehicle setVariable ["byscream_incendieencours", true, true];

	_smoke = "#particlesource" createVehicle position _vehicle;
	_smoke setParticleClass "BigDestructionSmoke";
	_smoke attachTo [_vehicle, [0, 0, 0]];

	uiSleep 10;

	_fire = "#particlesource" createVehicle position _vehicle;
	_fire setParticleFire [0, 5, 1];
	_fire attachTo [_vehicle, [0, 0, 0]];
	_fire setParticleClass "MediumDestructionFire";
	byscream_fires pushBack _fire;
	publicVariable "byscream_fires";

	uiSleep (getNumber(configFile >> "ALF_ConfigClient_Core" >> "ByScream_Incendie_V3" >> "vehicle_fire_part1_time"));
	_vehicle setVariable ["byscream_incendieencours", false, true];
	deleteVehicle _smoke;
	if (!isNull _fire) then {
		byscream_fires = byscream_fires - [_fire];
		publicVariable "byscream_fires";
		deleteVehicle _fire;
		_vehicle setVariable ["byscream_incendieencours", true, true];
		_fire = "#particlesource" createVehicle position _vehicle;
		_fire setParticleClass "BigDestructionFire";
		_fire setParticleFire [0, 5, 1];
		byscream_fires pushBack _fire;
		publicVariable "byscream_fires";
		_fire attachTo [_vehicle, [0, 0, 0]];

		_smoke = "#particlesource" createVehicle position _vehicle;
		_smoke setParticleClass "BigDestructionSmoke";
		_smoke attachTo [_vehicle, [0, 0, 0]];
	};
	uiSleep (getNumber(configFile >> "ALF_ConfigClient_Core" >> "ByScream_Incendie_V3" >> "vehicle_fire_part2_time"));
	_vehicle setVariable ["byscream_incendieencours", false, true];
	deleteVehicle _smoke;
	if (!isNull _fire) then {
		byscream_fires = byscream_fires - [_fire];
		publicVariable "byscream_fires";
		deleteVehicle _fire;
		_vehicle setVariable ["byscream_incendieencours", true, true];
		_fires = [];

		_fire = "#particlesource" createVehicle position _vehicle;
		_fire setParticleClass "BigDestructionFire";
		_fire setParticleFire [0, 5, 1];
		_fire attachTo [_vehicle, [0, -1, 0]];
		byscream_fires pushBack _fire;
		publicVariable "byscream_fires";
		_fires pushBack _fire;

		_fire = "#particlesource" createVehicle position _vehicle;
		_fire setParticleClass "BigDestructionFire";
		_fire setParticleFire [0, 5, 1];
		_fire attachTo [_vehicle, [0, 1, 0]];
		byscream_fires pushBack _fire;
		publicVariable "byscream_fires";
		_fires pushBack _fire;

		_smoke = "#particlesource" createVehicle position _vehicle;
		_smoke setParticleClass "BigDestructionSmoke";
		_smoke attachTo [_vehicle, [0, 0, 0]];
	};
	uiSleep (getNumber(configFile >> "ALF_ConfigClient_Core" >> "ByScream_Incendie_V3" >> "vehicle_fire_part3_time"));
	_vehicle setVariable ["byscream_incendieencours", false, true];
	deleteVehicle _smoke;
	_vehicle setVariable ["ALF_InFire",false];
	if (!isNull _fire) then {
		uiSleep 5;
		{
			if (_x in byscream_fires) then {
				byscream_fires = byscream_fires - [_x];
				publicVariable "byscream_fires";
			};
			deleteVehicle _x
		} forEach _fires;
	};
//};