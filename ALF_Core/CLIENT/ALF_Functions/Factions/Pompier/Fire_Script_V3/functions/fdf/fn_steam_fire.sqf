_object = param[0,objNull];
_SteamPos = nil;
while {alive _object} do {
	uiSleep 0.1;
	_SteamPos = (getpos _object);
};
 
_sources = []; 
_steamSource = nil; 
_stone = nil; 
for "_i" from 0 to 119 do { 
 uiSleep 0.05; 
 _stone = "FxExploArmor3" createVehicleLocal _SteamPos; 
 uiSleep 0.05; 
 _steamSource = "#particlesource" createVehicleLocal _SteamPos; 
 _steamSource setParticleCircle [6, [0, 0, 0]]; 
 _steamSource setParticleRandom [1, [2, 2, -10], [0.175, 0.175, 0], 0.25, 0.25, [0, 0, 0, 0], 1, 0.25]; 
 _steamSource setParticleParams [["\A3\data_f\ParticleEffects\Universal\smoke.p3d", 1, 0, 1], "", "Billboard", 1, 5, [0, 0, -8], [0, 0, 0.75], 0, 10.25, 8.5, 0.075, [2, 3, 4], [[0.92, 0.8, 0.7, 0.065], [0.82, 0.8, 0.8, 0.06], [0.8, 0.8, 0.8, 0.015]], [0.08], 1, 0.25, "", "", _stone]; 
 _steamSource setDropInterval 0.05; 
  _sources pushBack _steamSource;
_sources pushBack _stone;

}; 
 
{
deleteVehicle _x;
} forEach _sources;