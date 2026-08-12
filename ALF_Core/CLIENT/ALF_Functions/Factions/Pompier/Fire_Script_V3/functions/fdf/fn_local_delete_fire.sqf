_object = param[0,objNull];

uiSleep 0.1;

//_emitterArray = _object getVariable "effects";
_emitterArray = profileNamespace getVariable [format["flamme_%1",str (getPos _object)],[]];
//deleteVehicle _object; 
//diag_log _emitterArray;
{
	deleteVehicle _x;
} forEach _emitterArray;
profileNamespace setVariable [format["flamme_%1",str (getPos _object)], nil];

if ((count (nearestObjects [[worldSize/2, worldSize/2], ["ByScream_fire"], (sqrt 2) / 2 * worldSize])) == 0) then {
	if !(isNil "byscream_trg") then {
		deleteVehicle byscream_trg;
		terminate OutOfMapPlayer;
		OutOfMapPlayer = nil;
		'ColorCorrections' ppEffectEnable false;
	};
};