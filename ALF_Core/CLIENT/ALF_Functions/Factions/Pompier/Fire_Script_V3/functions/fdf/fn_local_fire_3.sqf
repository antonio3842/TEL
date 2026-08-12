_object = param[0,objNull];
_pos01 = getPos _object;

_sourceX1 = "#particlesource" createVehicleLocal _pos01;
_sourceX1 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal",16,10,32,1],"","Billboard",1,1,[random 0.5,random 0.5,0],[0,0,0.2],1,1,0.9,0.3,[2 + random 1,2 + random 2,4 + random 3],[[1,1,1,0.7],[1,1,1,0.5],[1,1,1,0]],[0.1],1,1,"","",_object];
_sourceX1 setParticleRandom [0.2, [1, 1, 0], [2, 2, 1], 0.2, 0.2, [0, 0, 0, 0], 0, 0];
_sourceX1 setDropInterval 0.05;
_sourceX1 attachto [_object,[0,0,-0.5]];

_sourceX2 = "#particlesource" createVehicleLocal _pos01;
_sourceX2 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal",16,10,32,1],"","Billboard",1,2,[0,random 0.5,random 1],[0, 0, 1],10,1,2.0,0.2,[3.2],[[1,1,1,0.5],[1,1,1,0.2],[1,1,1,0]],[0.5,0.5,0],1,1,"","",_object];
_sourceX2 setParticleRandom [0.5, [1, 1, 0.4], [0, 0, 4], 0, 0.6, [0, 0, 0, 0], 0, 0];
_sourceX2 setDropInterval 0.01;
_sourceX2 attachto [_object,[0,0,-0.5]];

_source01 = "#particlesource" createVehicleLocal _pos01;
_randomSource = ["ObjectDestructionFire1Smallx","ObjectDestructionFire2Smallx"] call BIS_fnc_selectRandom;
_source01 setParticleClass _randomSource;
_source01 setParticleCircle [2.8 + random 2.2,[0.1,0.1,1.4]];
_source01 setParticleRandom [1.2, [0, 0, 0], [0, 0, 0], 0, 1.2, [0.8, 0, 0, 0.8], 0, 0];
_source01 setParticleFire [0.5,0.5,0.5];
_source01 attachto [_object,[0,0,0]];

_source02 = "#particlesource" createVehicleLocal _pos01;
_source02 setParticleClass "ByScreamBigDestructionSmoke";
_source02 attachto [_object,[0,0,0]];

_source03 = "#particlesource" createVehicleLocal _pos01;
_source03 setParticleClass "FireSparks";
_source03 setParticleCircle [0.8 + random 0.4,[0,0,1]];
_source03 attachto [_object,[0,0,0]];

_li = "#lightpoint" createVehicleLocal _pos01;
_li lightAttachObject [_object, [0,0,0]];

_li setLightBrightness 8;
_li setLightAmbient[1,0.5,0];
_li setLightColor[1, 0.5, 0];
_li setLightAttenuation [4,4,4,8];
_li setLightDayLight true;
uiSleep 1;
//_object setVariable ["effects",[_sourceX1,_sourceX2,_source01,_source02,_source03,_li,_son]];
profileNamespace setVariable [format["flamme_%1",str (getPos _object)], [_sourceX1,_sourceX2,_source01,_source02,_source03,_li]];

if ((count (nearestObjects [[worldSize/2, worldSize/2], ["ByScream_fire"], (sqrt 2) / 2 * worldSize])) == 1) then {
	byscream_trg = createTrigger ["EmptyDetector", (getPos _object)];
	byscream_trg setTriggerArea [500, 500, 0, false];
	byscream_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
	byscream_trg setTriggerStatements ["this && ((vehicle player) in thisList)", "if !(isNil 'OutOfTriggerPlayer') exitWith {};
	['Vous entrez dans une zone de feu de forêt, la fumée commence a vous irriter le nez.',10,3] spawn life_fnc_handleMessage;
	OutOfMapPlayer = [] spawn {
		_effprox = ppEffectCreate ['ColorCorrections', 1000];
		while {true} do {
			uiSleep 0.5;
			_firelist = player nearObjects ['ByScream_fire_3', 200];
			_countF = count _firelist;
			_firenear = objNull;
			if (_countF == 0) then {
				'ColorCorrections' ppEffectCommit 3;
				'ColorCorrections' ppEffectEnable true;
				'ColorCorrections' ppEffectAdjust [1.00,1.00,0.00,[0.00,0.00,0.00,0.00],[1.00,1.00,1.00,1.00],[0.50,0.25,0.25,1.00]];
				uiSleep 3.00;
				'ColorCorrections' ppEffectEnable false;
			} else {
				_firenear = _firelist select 0;
			};
			

			if !(isNull _firenear) then {
				_distanceX = player distance _firenear;
				_coeffD = _distanceX;
				_kA = 0.90 + (_coeffD/3000);
				_kB = -0.10 + (_coeffD/3000);
				_kC = 0.05 - (_coeffD/6000);
				_kD = 0.45 - (_coeffD*0.0015);
				_kE = 0.75 - (_coeffD*0.0025);
				_kF = -0.50 + (_coeffD/600);
				_kG = 2.50 - (_coeffD*0.005);
				_kH = 1.70 - (_coeffD*0.00233);
				_kI = 0.60 + (_coeffD*0.00133);
				_kJ = 0.30 + (_coeffD*0.00233);
				_kK = 0.20 + (_coeffD*0.001);
				_kL = 0.30 - (_coeffD*0.00016);
				_kM = 0.20 + (_coeffD*0.00016);
				'ColorCorrections' ppEffectCommit 0.75;
				'ColorCorrections' ppEffectEnable true;
				'ColorCorrections' ppEffectAdjust [1.00,_kA,_kB,[_kC,_kD,_kE,0.00],[_kG,_kH,_kI,_kJ],[_kK,_kL,_kM,1.00]];

				uiSleep 0.8;
			};
		};
	};", "if !(isNil 'OutOfMapPlayer') then {
		['Vous sortez de la zone de feu de forêt, vous respirez tout de suite mieux.',10,1] spawn life_fnc_handleMessage;
		terminate OutOfMapPlayer;
		OutOfMapPlayer = nil;
		'ColorCorrections' ppEffectCommit 3;
		'ColorCorrections' ppEffectEnable true;
		'ColorCorrections' ppEffectAdjust [1.00,1.00,0.00,[0.00,0.00,0.00,0.00],[1.00,1.00,1.00,1.00],[0.50,0.25,0.25,1.00]];
		'ColorCorrections' ppEffectEnable false;
	};"];
};