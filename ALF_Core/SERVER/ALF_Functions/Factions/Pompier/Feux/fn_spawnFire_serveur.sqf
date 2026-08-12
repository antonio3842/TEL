uiSleep 30;
byscream_fires = [];
byscream_fires_marker = [];
publicVariable "byscream_fires";
publicVariable "byscream_fires_marker";
uiSleep 30;
_byscream_classes_buildings = (getArray(configFile >> "ALF_ConfigClient_Core" >> "ByScream_Incendie_V3" >> "buildings_whitelisted"));
_byscream_classes_poubelle = (getArray(configFile >> "ALF_ConfigClient_Core" >> "ByScream_Incendie_V3" >> "poubelles_whitelisted"));

_byscream_buildings = (nearestObjects [[worldSize/2, worldSize/2], _byscream_classes_buildings, (sqrt 2) / 2 * worldSize]);
uiSleep 1;
_byscream_poubelles = (nearestObjects [[worldSize/2, worldSize/2], _byscream_classes_poubelle, (sqrt 2) / 2 * worldSize]);

_fire_wait_time = (getNumber(configFile >> "ALF_ConfigClient_Core" >> "ByScream_Incendie_V3" >> "fire_wait_time"));
_fire_wait_time_random = (getNumber(configFile >> "ALF_ConfigClient_Core" >> "ByScream_Incendie_V3" >> "fire_wait_time_random"));

_pourcentage_batiment = (getNumber(configFile >> "ALF_ConfigClient_Core" >> "ByScream_Incendie_V3" >> "feu_de_batiment"));
_pourcentage_poubelle = (getNumber(configFile >> "ALF_ConfigClient_Core" >> "ByScream_Incendie_V3" >> "feu_de_poubelle"));
_pourcentage_foret = (getNumber(configFile >> "ALF_ConfigClient_Core" >> "ByScream_Incendie_V3" >> "feu_de_foret"));

_building_medic_min = (getNumber(configFile >> "ALF_ConfigClient_Core" >> "ByScream_Incendie_V3" >> "building_medic_min"));
_poubelle_medic_min = (getNumber(configFile >> "ALF_ConfigClient_Core" >> "ByScream_Incendie_V3" >> "poubelle_medic_min"));
_foret_medic_min = (getNumber(configFile >> "ALF_ConfigClient_Core" >> "ByScream_Incendie_V3" >> "foret_medic_min"));



/*if ((getNumber(configFile >> "ALF_ConfigClient_Core" >> "ByScream_Incendie_V3" >> "enable_vehicle_fire")) isequalto 1) then {
	[] spawn {
		while {true} do {
			{
				_x removeAllMPEventHandlers "MPHit";
				_x addMPEventHandler ["MPHit",{
					[_this select 0] spawn ALF_Server_fnc_vehiclefire;
				}];
			} foreach allMissionObjects "car";
			uiSleep 60;
		};
	};
};*/


while {true} do {
	uisleep (_fire_wait_time + _fire_wait_time_random);
	_medics = {_x getVariable ["MedService",false]} count playableUnits;

	_array = [];
	_value = nil;
	for "_i" from 1 to _pourcentage_batiment do { _array pushBack 1 };
	for "_i" from 1 to _pourcentage_poubelle do { _array pushBack 2 };
	for "_i" from 1 to _pourcentage_foret do { _array pushBack 3 };
	_value = selectRandom _array;
	switch _value do {
		case 1: {
			if (_medics >= _building_medic_min) then {
				_building = selectRandom _byscream_buildings;
				[_building] spawn ALF_Server_fnc_burn_building;
			};
		};
		case 2: {
			if (_medics >= _poubelle_medic_min) then {
				if !(_byscream_poubelles isEqualTo []) then {
					_poubelle = selectRandom _byscream_poubelles;
					[_poubelle] spawn ALF_Server_fnc_burn_poubelle;
				};
			};
		};
		case 3: {
			if (_medics >= _foret_medic_min) then {
				[] spawn ALF_Server_fnc_burn_foret;
			};
		};
	};
};