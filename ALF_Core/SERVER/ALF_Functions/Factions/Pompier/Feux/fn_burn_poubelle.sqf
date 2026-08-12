/*_allow_multiples_fire = getNumber(configFile >> "ALF_ConfigClient_Core" >> "ByScream_Incendie_V3" >> "allow_multiples_fire");
if (missionNamespace getVariable ["byscream_incendieencours", false] && (_allow_multiples_fire isEqualTo 0) || !ALF_fireON) exitWith {};*/

_poubelle = param [0, objNull, [objNull]];

_poubelle setVariable ["IsOnfire", true, true];
missionNamespace setVariable ["byscream_incendieencours", true, true];
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

_marker_text = selectRandom (getArray(configFile >> "ALF_ConfigClient_Core" >> "ByScream_Incendie_V3" >> "poubelle_marker_text"));
_Pos = position _poubelle;

/*_marker = createMarker [str _poubelle, _Pos];
_marker setMarkerColor "ColorRed";
_marker setMarkerText _marker_text;
_marker setMarkerType "mil_warning";*/
_info = [str _poubelle, _Pos, "ColorRed", _marker_text, "mil_warning"];
byscream_fires_marker pushBack _info;
publicVariable "byscream_fires_marker";

private _fires = [];

private _feu = "#particlesource" createVehicle _Pos;
_feu setParticleClass "BigDestructionFire";
_feu setParticleFire [0.06, 5, 0.75];
_feu setPos _Pos;
byscream_fires pushBack _feu;
publicVariable "byscream_fires";
_fires pushBack _feu;

_fumee = "#particlesource" createVehicle (_Pos vectorAdd [0,0,5]);
_fumee setParticleClass "BigDestructionSmoke";
_fumee setPos (_Pos vectorAdd [0,0,5]);

_son = createSoundSource ["byscream_son_flamme", _Pos, [], 0];
missionNamespace setVariable [format["flamme_%1",str (getPos _feu)], [_fumee,_son],true];

_poubelle spawn {
	_burntime = getNumber(configFile >> "ALF_ConfigClient_Core" >> "ByScream_Incendie_V3" >> "poubelle_burn_time");
	uiSleep _burntime;
	_this setVariable ["IsOnfire", false, true];
};

while { (_poubelle getVariable "IsOnfire") } do {
	if (objNull in _fires) then {
		{
			_fires = _fires - [objNull]
		} forEach _fires;
	};
	if (((count _fires) < 1)) then {
		_poubelle setVariable ["IsOnfire", false, true];
	};
	uiSleep 15;
};
//deleteMarker _marker;
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
	} forEach (missionNamespace getVariable[format["flamme_%1",str (getPos _x)], []]);
	deleteVehicle _x;

	uiSleep 1 + (random 5);
} forEach (_fires);