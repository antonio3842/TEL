_object = param[0,objNull];

_pos01 = getPos _object;
_sourceX1 = "#particlesource" createVehicleLocal _pos01;
_sourceX1 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal",16,10,32,1],"","Billboard",1,0.6,[random 0.5,random 0.5,0],[0,0,0.2],1,1,0.9,0.3,[0.2 + random 1,0.5 + random 1,1 + random 1],[[1,1,1,0.7],[1,1,1,0.5],[1,1,1,0]],[0.1],1,1,"","",_object];
_sourceX1 setParticleRandom [0.2, [1, 1, 0], [2, 2, 1], 0.2, 0.2, [0, 0, 0, 0], 0, 0];
_sourceX1 setDropInterval 0.007;
_sourceX1 attachto [_object,[0,0,-0.5]];

_sourceX2 = "#particlesource" createVehicleLocal _pos01;
_sourceX2 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal",16,10,32,1],"","Billboard",1,1,[0,random 0.5,random 1],[0, 0, 1],10,1,2.0,0.2,[0.7],[[1,1,1,0.5],[1,1,1,0.2],[1,1,1,0]],[0.5,0.5,0],1,1,"","",_object];
_sourceX2 setParticleRandom [0.5, [1, 1, 0.4], [0, 0, 4], 0, 0.6, [0, 0, 0, 0], 0, 0];
_sourceX2 setDropInterval 0.05;
_sourceX2 attachto [_object,[0,0,-0.5]];

_source01 = "#particlesource" createVehicleLocal _pos01;
_randomSource = ["ObjectDestructionFire1Smallx","ObjectDestructionFire2Smallx"] call BIS_fnc_selectRandom;
_source01 setParticleClass _randomSource;
_source01 setDropInterval 0.15;
_source01 setParticleCircle [0.1 + random 0.05,[0.01,0.01,0.025]];
_source01 setParticleRandom [0.7, [0, 0, 0], [0, 0, 0], 0, 0.01, [0.9, 0.3, 0.05, 0.6], 0, 0];
_source01 setParticleFire [0.5,0.5,0.5];
_source01 attachto [_object,[0,0,0]];

_source02 = "#particlesource" createVehicleLocal _pos01;
_source02 setParticleClass "ByScreamBigDestructionSmoke";
_source02 setParticleCircle [0, [0, 0, 0]];
_source02 setParticleRandom [0, [0.25, 0.25, 0], [0.2, 0.2, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
_source02 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal", 16, 7, 48], "", "Billboard", 1, 60, [0, 0, 0], [0, 0, 1.5], 0.0, 10, 7.9, 0.05, [3, 5, 12], [[0.8, 0.8, 0.8, 0.002], [0.7, 0.7, 0.7, 0.01], [0.8, 0.8, 0.8, 0.0010], [1, 1, 1, 0.0005]], [0.125], 1, 0, "", "", _object];
_source02 setDropInterval 0.05;
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

profileNamespace setVariable [format["flamme_%1",str (getPos _object)], [_sourceX1,_sourceX2,_source01,_source02,_source03,_li]];

//diag_log format ["Flamme 1 crée: %1",_object getVariable "effects"];