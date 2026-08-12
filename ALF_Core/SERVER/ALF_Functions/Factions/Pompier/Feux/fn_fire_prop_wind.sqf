_origFire = param[0,objNull];
_timeProp1 = random 4;
_timeProp2 = random 6;
_timeProp3 = random 10;
_timeProp4 = random 12;
_timeProp5 = random 14;
_timeProp = [_timeProp1, _timeProp2, _timeProp3, _timeProp4, _timeProp5] call BIS_fnc_selectRandom;
_DirProp1 = random [-100, 0, 100];
_DirProp2 = random [-130, 0, 130];
_DirProp3 = random [-160, 0, 160];
_DirProp4 = random [-190, 0, 190];
_DirProp5 = random [-220, 0, 220];
_DirProp = [_DirProp1, _DirProp2, _DirProp3, _DirProp4, _DirProp5] call BIS_fnc_selectRandom;

_coeff = getNumber (configFile >> "ALF_ConfigClient_Core" >> "ByScream_Incendie_V3" >> "coefficient_propagation");
if (_coeff == 0) then {_coeff = 1;}; 
uiSleep ((8 + _timeProp)*_coeff);
_origFire setdir winddir;
_distance = random [20,30,60] + ((windStr + 0.1)*10);
_NewPos = _origFire getRelPos [_distance, _DirProp];

if !((count (_origFire nearObjects ["ByScream_fire", 100])) <10) exitWith {};

_flamme_proportionnelles = getText (configFile >> "ALF_ConfigClient_Core" >> "ByScream_Incendie_V3" >> "flammes_proportionelles");
_nb_flamme_par_pompier = getNumber (configFile >> "ALF_ConfigClient_Core" >> "ByScream_Incendie_V3" >> "flammes_par_pompiers");
if ((_flamme_proportionnelles isEqualTo "true") && ((count (nearestObjects [[worldSize/2, worldSize/2], ["ByScream_fire"], (sqrt 2) / 2 * worldSize])) >= (_nb_flamme_par_pompier*({_x getVariable ["MedService",false]} count playableUnits)))) exitWith {};

_nb_flamme_max = getNumber (configFile >> "ALF_ConfigClient_Core" >> "ByScream_Incendie_V3" >> "flammes_max");
if ((_nb_flamme_max != 0) && ((count (nearestObjects [[worldSize/2, worldSize/2], ["ByScream_fire"], (sqrt 2) / 2 * worldSize])) >= _nb_flamme_max)) exitWith {};

_PropFire = "ByScream_fire";
_Firecreate = _PropFire createVehicle getpos _origFire;
[_Firecreate] spawn ALF_Server_fnc_fire_1;
_Firecreate setPos _NewPos;
_Firecreate setdir (winddir + random [-15,0,15]);