params [
	"_estimatedTime",
	"_from",
	"_muzzleDiameter",
	"_muzzleSpread",
	"_vectorDir",
	"_vel",
	"_initSpeed",
	"_particleWeight",
	"_particleVolume"
];

private _cutOutEffect = {
		params ["_array","_time"] ;
		private _count = count _array ;

		private _return = [] ;
	
		private _index = 0 ;
		for "_i" from 0 to (_estimatedTime min _time) step (_time/_count) do {
			
			_return pushBack (_array#_index) ;
			_index = _index + 1 ;
		} ;
		_return
	};
for "_i" from 0 to 3 do {
			// main waterfall
			//private _weightCoef = random [1,3,5];
			drop [
				["\A3\data_f\ParticleEffects\Universal\smoke.p3d", 1, 0, 1],"","Billboard",1,
				(7 + random 3.5) min _estimatedTime,
				ASLToAGL (_from vectorAdd ([
					random [-0.1 * _muzzleDiameter,0,0.1 * _muzzleDiameter],
					random [-0.1 * _muzzleDiameter,0,0.1 * _muzzleDiameter],
					random [-0.1 * _muzzleDiameter,0,0.1 * _muzzleDiameter]
				]) vectorAdd ((_vectorDir) vectorMultiply (random [0.5,2,4]))),
				((_vel vectorMultiply random [0.9*_initSpeed,1*_initSpeed,1.1*_initSpeed]) vectorAdd [
					random [-0.15 * (_muzzleSpread*1.25 max 1),0,0.15 * (_muzzleSpread*1.25 max 1)],
					random [-0.15 * (_muzzleSpread*1.25 max 1),0,0.15 * (_muzzleSpread*1.25 max 1)],
					random [-0.15 * (_muzzleSpread*1.25 max 1),0,0.15 * (_muzzleSpread*1.25 max 1)]
				]),
				// lifetime, pos, vel
				(random 4) - 2,_particleWeight,_particleVolume * random [0.7,0.9,1.1],0,				// rotationVelocity, weight, volume, rubbing
				[
					[
						0.7 * sqrt ((_muzzleDiameter*1.5) max 1) * ((_muzzleSpread * 0.8) max 1),
						1.8 * random [0.7,1,1.5] * sqrt ((_muzzleDiameter*1.0) max 1) * ((_muzzleSpread * 1) max 1),
						2.2 * random [0.7,1,1.5] * sqrt ((_muzzleDiameter*0.4) max 1) * ((_muzzleSpread * 1) max 1),
						5.5 * random [0.7,1,1.5] * sqrt ((_muzzleDiameter*0.1) max 1) * ((_muzzleSpread * 1) max 1),
						8.5 * random [0.7,1,1.5] * sqrt ((_muzzleDiameter*0.1) max 1) * ((_muzzleSpread * 1) max 1),
						12 * random [0.7,1,1.5] * sqrt ((_muzzleDiameter*0.1) max 1) * ((_muzzleSpread * 1) max 1),
						16 * random [0.7,1,1.5] * sqrt ((_muzzleDiameter*0.1) max 1) * ((_muzzleSpread * 1) max 1)
					],7
				] call _cutOutEffect,
				// sizeOverLifetime
				[
					[
						[0.75,0.85,1.00,0.1],[0.75,0.85,1.00,0.03],[1.00,1.00,1.00,0.00]
					],6
				] call _cutOutEffect, // color
				[0],random [0.01,0.02,0.1],_muzzleSpread/18,			// animationSpeed, randomDirectionPeriod, randomDirectionIntensity
				//"", "lxRF\functions_rf\functions\vehicles\fn_water.sqf", // onTimerScript, beforeDestroyScript
				"", "",					// onTimerScript, beforeDestroyScript
				nil,(random pi) - pi/2,			// angle
				false, -1,				// onSurface, bounceOnSurface
				[[0,0,0,0]]				// emissiveColor
			];

			// sub waterfall
			drop [
				["\A3\data_f\ParticleEffects\Universal\smoke.p3d", 1, 0, 1],"","Billboard",1,
				1.5 * random [1,1.2,1.4] min _estimatedTime,
				ASLToAGL (_from vectorAdd ([
					random [-0.5 * _muzzleDiameter,0,0.5 * _muzzleDiameter],
					random [-0.5 * _muzzleDiameter,0,0.5 * _muzzleDiameter],
					random [-0.5 * _muzzleDiameter,0,0.5 * _muzzleDiameter]
				]) vectorAdd ((_vectorDir) vectorMultiply (random [1.2,1.6,1.9]))),
				(_vel) vectorMultiply random [0.1*_initSpeed,0.3*_initSpeed,0.5*_initSpeed] vectorAdd [
					random [-1.5,0,1.5],
					random [-1.5,0,1.5],
					random [-1.5,0,1.5]
				],
				// lifetime, pos, vel
				(random 4) - 2,_particleWeight * 1.1,_particleVolume * 0.9 * random [0.8,1,1.2],0.03 * (0.1 + random 0.8),				// rotationVelocity, weight, volume, rubbing
				[
					[
						0.5 * sqrt ((_muzzleDiameter*2) max 1) * ((_muzzleSpread * 0.5) max 1),
						0.5 * random [0.7,1,2.5] * sqrt ((_muzzleDiameter*2) max 1) * ((_muzzleSpread * 0.5) max 1),
						2.5 * random [0.7,1,2.5] * sqrt ((_muzzleDiameter*2) max 1) * ((_muzzleSpread * 0.5) max 1),
						5.5 * random [0.7,1,2.5] * sqrt ((_muzzleDiameter*2) max 1) * ((_muzzleSpread * 0.5) max 1)
					],1.5
				] call _cutOutEffect,
				// sizeOverLifetime
				[[0.75,0.85,1.00,0.03],[0.75,0.85,1.00,0.01],[1.00,1.00,1.00,0.00]], // color
				[0],0.35,0.05,			// animationSpeed, randomDirectionPeriod, randomDirectionIntensity
				//"", "lxRF\functions_rf\functions\vehicles\fn_water.sqf", // onTimerScript, beforeDestroyScript
				"", "",					// onTimerScript, beforeDestroyScript
				nil,(random pi) - pi/2,			// angle
				false, -1,				// onSurface, bounceOnSurface
				[[0,0,0,0]]				// emissiveColor
			];
		};
		for "_i" from 0 to 5 do {
			// spill
			drop [
				["\A3\data_f\ParticleEffects\Universal\Universal.p3d", 16, 12, 16, 0],"","Billboard",1,
				(1 + random 1),
				ASLToAGL (_from vectorAdd ([
					random [-0.1 * _muzzleDiameter,0,0.1 * _muzzleDiameter],
					random [-0.1 * _muzzleDiameter,0,0.1 * _muzzleDiameter],
					random [-0.1 * _muzzleDiameter,0,0.1 * _muzzleDiameter]
				]) vectorAdd ((_vectorDir) vectorMultiply ((_initSpeed/450*_i)))),
				(_vel vectorMultiply (random [0.1,0.3,0.5])) vectorAdd [
					random [-8.5,0,8.5],
					random [-8.5,0,8.5],
					random [-8.5,0,8.5]
				],
				// lifetime, pos, vel
				(random 4) - 2,_particleWeight,_particleVolume*0.5,0.3,				// rotationVelocity, weight, volume, rubbing
				[
					0.015 * random [1,3,5]
				],
				// sizeOverLifetime
				[[0.75,0.85,1.00,0.4],[0.75,0.85,1.00,0.01],[1.00,1.00,1.00,0.00]], // color
				[1000],0,0,			// animationSpeed, randomDirectionPeriod, randomDirectionIntensity
				//"", "lxRF\functions_rf\functions\vehicles\fn_water.sqf", // onTimerScript, beforeDestroyScript
				"", "",					// onTimerScript, beforeDestroyScript
				nil,(random pi) - pi/2,			// angle
				false, -1,				// onSurface, bounceOnSurface
				[[0,0,0,0]]				// emissiveColor
			];
		};

	/*for "_i" from 0 to 2 do {
				// muzzle zasleh
				drop [
					["lxRF\functions_rf\functions\bucket\waterZasleh2.p3d", 1, 0, 1],"","SpaceObject",1,
					0.05 + random 0.05,
					ASLToAGL (_from vectorAdd (_vectorDir vectorMultiply random [-0.4,-0.15,2])),
					_vel vectorMultiply (random [0.1,0.3,0.6]) vectorAdd (_fromVel vectorMultiply 0.75),
					// lifetime, pos, vel
					(random 4) - 2,1.277,1,0,				// rotationVelocity, weight, volume, rubbing
					[2.5 * _muzzleDiameter * random [1,1.4,1.8],0],
					// sizeOverLifetime
					[], // color
					[0],0.35,0.35,			// animationSpeed, randomDirectionPeriod, randomDirectionIntensity
					//"", "lxRF\functions_rf\functions\vehicles\fn_water.sqf", // onTimerScript, beforeDestroyScript
					"", "",					// onTimerScript, beforeDestroyScript
					nil,(random pi) - pi/2,			// angle
					false, -1,				// onSurface, bounceOnSurface
					[[0,0,0,0]],				// emissiveColor
					_vectorDir
				];

				// muzzle zasleh static
				drop [
					["lxRF\functions_rf\functions\bucket\waterZasleh2.p3d", 1, 0, 1],"","SpaceObject",1,
					0.01 + random 0.075,
					ASLToAGL (_from vectorAdd (_vectorDir vectorMultiply random [-0.4,-0.2,0.1])),
					_vel vectorMultiply 0.75,
					// lifetime, pos, vel
					(random 4) - 2,1.277,1,0,				// rotationVelocity, weight, volume, rubbing
					[1.5 * _muzzleDiameter * random [1.5,1.8,2],0],
					// sizeOverLifetime
					[], // color
					[0],0.35,0.35,			// animationSpeed, randomDirectionPeriod, randomDirectionIntensity
					//"", "lxRF\functions_rf\functions\vehicles\fn_water.sqf", // onTimerScript, beforeDestroyScript
					"", "",					// onTimerScript, beforeDestroyScript
					nil,(random pi) - pi/2,			// angle
					false, -1,				// onSurface, bounceOnSurface
					[[0,0,0,0]],				// emissiveColor
					_vectorDir
				];
			} ;*/