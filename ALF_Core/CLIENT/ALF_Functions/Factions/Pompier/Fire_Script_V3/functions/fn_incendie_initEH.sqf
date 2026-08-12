(findDisplay 46) displayAddEventHandler ["KeyDown", {
	params [
		"_ctrl",
		"_code",
		"_shift",
		"_ctrlKey",
		"_alt"
	];
	if (_code == 24 && !(isNil "byscream_devidoir")) then {
		byscream_devidoir = nil;
		hint "Déroulement du dévidoir stoppé au prochain tuyau";
	};
}];

player addEventHandler ["put", {
	params ["_unit", "_container", "_item"];
	if (_item isEqualTo "ByScream_LDV500" && !(isNull (player getVariable ["connectedTo", objNull]))) then {
		if ((typeOf _container) isEqualTo "GroundWeaponHolder") then {
			_container addWeaponCargoGlobal ["ByScream_LDV500", -1];
			_pos = ASLToATL (player modelToWorldWorld [0, 0.6, 0]);
			_ldv = createVehicle ["byscream_ldv500_object", _pos, [], 0, "CAN_COLLIDE"];
			_ldv setPosATL _pos;
			_ldv setDir (direction player);
			_raccord = player getVariable ["connectedTo", objNull];
			_raccord setVariable ["connectedTo", _ldv, true];
			_ldv setVariable ["connectedTo", _raccord, true];
			_raccord attachTo [_ldv, [0.015, -0.457, 0.016]];
			_raccord lock true;
			player setVariable ["connectedTo", objNull, true];

			if !(isNull byscream_ldt_hand) then {
				_ldv setVariable ["LDT", byscream_ldt_hand, true];
				byscream_ldt_hand = objNull;
			};
		} else {
			_itemContents = weaponCargo _container;
			_itemContents deleteAt (_itemContents findIf {
				_x isEqualTo _item
			});
			_itemContents = _itemContents call BIS_fnc_consolidateArray;
			clearWeaponCargoGlobal _container;
			{
				_container addWeaponCargoGlobal _x;
			} forEach _itemContents;
			player addWeapon "byscream_LDV500";
			player addPrimaryWeaponItem "byscream_LDV500_chargeur";
			hint "Vous ne pouvez pas poser la lance ici car elle est connectée à un tuyau.";
		};
	};
	if (_item isEqualTo "ByScream_LDT" && !(isNull (player getVariable ["connectedTo", objNull]))) then {
		if ((typeOf _container) isEqualTo "GroundWeaponHolder") then {
			_container addWeaponCargoGlobal ["ByScream_LDT", -1];
			_pos = ASLToATL (player modelToWorldWorld [0, 0.6, 0]);
			_ldv = createVehicle ["byscream_ldt_object", _pos, [], 0, "CAN_COLLIDE"];
			_ldv setPosATL _pos;
			_ldv setDir (direction player);
			_raccord = player getVariable ["connectedTo", objNull];
			_raccord setVariable ["connectedTo", _ldv, true];
			_ldv setVariable ["connectedTo", _raccord, true];
			_raccord attachTo [_ldv, [0, -0.3, 0]];
			player setVariable ["connectedTo", objNull, true];
			_raccord lock true;

			if !(isNull byscream_ldt_hand) then {
				_ldv setVariable ["LDT", byscream_ldt_hand, true];
				byscream_ldt_hand = objNull;
			};
		} else {
			_itemContents = weaponCargo _container;
			_itemContents deleteAt (_itemContents findIf {
				_x isEqualTo _item
			});
			_itemContents = _itemContents call BIS_fnc_consolidateArray;
			clearWeaponCargoGlobal _container;
			{
				_container addWeaponCargoGlobal _x;
			} forEach _itemContents;
			player addWeapon "byscream_LDT";
			player addPrimaryWeaponItem "byscream_LDV500_chargeur";
			hint "Vous ne pouvez pas poser la lance ici car elle est connectée à un tuyau.";
		};
	};
	if (_item isEqualTo "byscream_division_simple" && (typeOf _container) isEqualTo "GroundWeaponHolder") then {
		_container addMagazineCargoGlobal ["byscream_division_simple", -1];
		_pos = ASLToATL (player modelToWorldWorld [0, 0.3, 0]);
		_ldv = createVehicle ["byscream_division_simple_object", _pos, [], 0, "CAN_COLLIDE"];
		_ldv setPosATL _pos;
		_ldv setDir ((direction player)+180);
	};
}];
player addEventHandler["fired", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
	if (!(_weapon in ["ByScream_LDV500", "ByScream_LDT","ByScream_Extincteur"])) exitWith {};

	if (_weapon in ["ByScream_LDV500", "ByScream_LDT"]) then {
		_vehicle = [player getVariable ["connectedTo", objNull]] call ALF_fnc_incendie_remoteHoses;
		if (isNull _vehicle) exitWith {
			hint "La lance n'est connectée à aucun camion !";
		};
		_reservoir = _vehicle getVariable ["byscream_incendie_reservoir", ["NUMBER", ["ByScream_Incendie_V3","vehicles",typeOf _vehicle,"reservoir"]] call ALFTools_Client_Config_fnc_getConfig];
		if (_reservoir <= 0) exitWith {
			hint "Le réservoir du camion n'a plus assez d'eau !";
		};

		_debit = 250;
		if (_weapon isEqualTo "ByScream_LDT") then {
			_debit = 150;
		};

		_vehicle setVariable ["byscream_incendie_reservoir", _reservoir-(_debit/625), true];
		_bar = _vehicle getVariable ["byscream_incendie_pression", 0];

		if (_bar == 0) exitWith {
			hint "La pompe n'est pas allumée !";
		};

		if (count (_vehicle getVariable ["byscream_hydrants_connected", []]) > 0) then {
			hintSilent parseText format ["<t align='center' font='puristaBold' size='1.5'>%1</t><br/><br/><t align='left'>Débit de la lance: %3L/min<br />Eau dans le véhicule: %2L<br />Alimenté: <t color='#00ff00'>Oui</t>", getText (configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName"), _reservoir-(_debit/625), _debit];
		} else {
			hintSilent parseText format ["<t align='center' font='puristaBold' size='1.5'>%1</t><br/><br/><t align='left'>Débit de la lance: %3L/min<br />Eau dans le véhicule: %2L<br />Alimenté: <t color='#ff0000'>Non</t>", getText (configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName"), _reservoir-(_debit/625), _debit];
		};

		_muzzleDiameter = 0.75;

		if (_weapon isEqualTo "ByScream_LDT") then {
			_muzzleDiameter = 0.5;
		};

		_muzzleSpread = 1;
		_vectorDir = player weaponDirection currentWeapon player;
		_from = getPosASL _projectile vectorAdd (_vectorDir vectorMultiply 0.25);
		_vel = _vectorDir;
		_particleWeight = 1;
		_particleVolume = 0;

		_estimatedTime = 7;

		_initSpeed = (_bar-2)*1.75;
		_projectile setPosASL _from;
		_projectile setVelocity (_vectorDir vectorMultiply _initSpeed);

		// ([_projectile] call life_fnc_calculateTrajectory) params ["_estimatedTime"];

		_fromVel = velocity _unit;

		[_estimatedTime, _from, _muzzleDiameter, _muzzleSpread, _vectorDir, _vel, _initSpeed, _particleWeight, _particleVolume] remoteExec ["ALF_fnc_incendie_jetEau", 0];

		[_projectile, _debit] spawn {
			_projectile = param[0, objNull];
			_debit = param[1, 250];
			_pos = nil;
			while { !(isNull _projectile) } do {
				_pos = getPosATL _projectile;
				uiSleep 0.05;
			};
			_fire = _pos nearObjects 10;
			_fire = [_fire, [], {
				_x distance _pos
			}, "ASCEND"] call BIS_fnc_sortBy;
			_firetarget = objNull;

			_damage = ((["NUMBER", ["ByScream_Incendie_V3","lance_rate"]] call ALFTools_Client_Config_fnc_getConfig)*(_debit/250));
			{
				if (typeOf _x in ["byscream_fire", "byscream_fire_2", "byscream_fire_3"] || _x in byscream_fires) exitWith {
					_firetarget = _x;
				};
			} forEach _fire;

			if (!isNull _firetarget) then {
				if ((damage _firetarget) >= 1) then {
					byscream_fires = byscream_fires - [_firetarget];
					publicVariable "byscream_fires";
					if !(typeOf _firetarget in ["byscream_fire", "byscream_fire_2", "byscream_fire_3"]) then {
						{
							deleteVehicle _x;
						} forEach (missionNamespace getVariable[format["flamme_%1", str (getPos _firetarget)], []]);
						deleteVehicle _firetarget;

						_SteamPos = getPos _firetarget;
						_sources = []; 
						for "_i" from 0 to 119 do { 
						uiSleep 0.05; 
						_stone = "FxExploArmor3" createVehicle _SteamPos; 
						uiSleep 0.05; 
						_steamSource = "#particlesource" createVehicle _SteamPos; 
						_steamSource setParticleRandom [1, [2, 2, -10], [0.175, 0.175, 0], 0.25, 0.25, [0, 0, 0, 0], 1, 0.25]; 
						_steamSource setParticleParams [["\A3\data_f\ParticleEffects\Universal\smoke.p3d", 1, 0, 1], "", "Billboard", 1, 5, [0, 0, -8], [0, 0, 0.75], 0, 10.25, 8.5, 0.075, [2, 3, 4], [[0.92, 0.8, 0.7, 0.065], [0.82, 0.8, 0.8, 0.06], [0.8, 0.8, 0.8, 0.015]], [0.08], 1, 0.25, "", "", _stone]; 
						_steamSource setDropInterval 0.05; 
						_sources pushBack _steamSource;
						_sources pushBack _stone;

						}; 
						
						{
						deleteVehicle _x;
						} forEach _sources;
					};
				} else {
					_firetarget setDamage ((damage _firetarget) + _damage);
					[[format ["Extinction: %1 %%", ((damage _firetarget)*100) toFixed 1], 0, 0]] spawn BIS_fnc_EXP_camp_SITREP;
				};
			};
		};
	} else {


		_muzzleDiameter = 1;
		_muzzleSpread = 2;
		_vectorDir = player weaponDirection currentWeapon player;
		_from = getPosASL _projectile vectorAdd (_vectorDir vectorMultiply 0.25);
		_vel = _vectorDir;
		_particleWeight = 1;
		_particleVolume = 0;

		_estimatedTime = 7;

		_initSpeed = 1.75;
		_projectile setPosASL _from;
		_projectile setVelocity (_vectorDir vectorMultiply _initSpeed);

		// ([_projectile] call life_fnc_calculateTrajectory) params ["_estimatedTime"];

		_fromVel = velocity _unit;

		[_estimatedTime, _from, _muzzleDiameter, _muzzleSpread, _vectorDir, _vel, _initSpeed, _particleWeight, _particleVolume] remoteExec ["ALF_fnc_incendie_jetEau", 0];

		[_projectile] spawn {
			_projectile = param[0, objNull];
			_pos = nil;
			while { !(isNull _projectile) } do {
				_pos = getPosATL _projectile;
				uiSleep 0.05;
			};
			_fire = _pos nearObjects 10;
			_fire = [_fire, [], {
				_x distance _pos
			}, "ASCEND"] call BIS_fnc_sortBy;
			_firetarget = objNull;

			_damage = (["NUMBER", ["ByScream_Incendie_V3","extinguisher_rate"]] call ALFTools_Client_Config_fnc_getConfig);
			{
				if (typeOf _x in ["byscream_fire", "byscream_fire_2", "byscream_fire_3"] || _x in byscream_fires) exitWith {
					_firetarget = _x;
				};
			} forEach _fire;

			if (!isNull _firetarget) then {
				if ((damage _firetarget) >= 1) then {
					byscream_fires = byscream_fires - [_firetarget];
					publicVariable "byscream_fires";
					if !(typeOf _firetarget in ["byscream_fire", "byscream_fire_2", "byscream_fire_3"]) then {
						{
							deleteVehicle _x;
						} forEach (missionNamespace getVariable[format["flamme_%1", str (getPos _firetarget)], []]);
						deleteVehicle _firetarget;

						_SteamPos = getPos _firetarget;
						_sources = []; 
						for "_i" from 0 to 119 do { 
							uiSleep 0.05; 
							_stone = "FxExploArmor3" createVehicle _SteamPos; 
							uiSleep 0.05; 
							_steamSource = "#particlesource" createVehicle _SteamPos; 
							_steamSource setParticleRandom [1, [2, 2, -10], [0.175, 0.175, 0], 0.25, 0.25, [0, 0, 0, 0], 1, 0.25]; 
							_steamSource setParticleParams [["\A3\data_f\ParticleEffects\Universal\smoke.p3d", 1, 0, 1], "", "Billboard", 1, 5, [0, 0, -8], [0, 0, 0.75], 0, 10.25, 8.5, 0.075, [2, 3, 4], [[0.92, 0.8, 0.7, 0.065], [0.82, 0.8, 0.8, 0.06], [0.8, 0.8, 0.8, 0.015]], [0.08], 1, 0.25, "", "", _stone]; 
							_steamSource setDropInterval 0.05; 
							_sources pushBack _steamSource;
							_sources pushBack _stone;

						}; 
						
						{
							deleteVehicle _x;
						} forEach _sources;
					};
				} else {
					_firetarget setDamage ((damage _firetarget) + _damage);
					[[format ["Extinction: %1 %%", ((damage _firetarget)*100) toFixed 1], 0, 0]] spawn BIS_fnc_EXP_camp_SITREP;
				};
			};
		};
	};
	
}];