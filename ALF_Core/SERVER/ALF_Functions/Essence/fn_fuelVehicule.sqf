// /*
//     File: fn_fuelVehicule.sqf
//     Author: NiiRoZz
// */
// ALF_Server_fnc_fuelVehicule = {

params [
	["_veh",objNull,[objNull]],
	["_pistolet",objNull,[objNull]],
	["_player",objNull,[objNull]],
	["_pos",[],[[]]]
];

if (isNull _veh OR {isNull _pistolet OR {isNull _player}}) exitWith {};

_station = nearestObject [_player,"plp_up_PropaneTankA"];
if (isNull _station) exitWith {};

private _vehicleInfo = [typeOf _veh] call ALF_fnc_fetchVehInfo;
private _fuelCapa = _vehicleInfo # 11;
private _timer = _fuelCapa / 1900;
private _litre = 0;

while {fuel _veh < 1 AND {({typeOf _x isEqualTo "ALF_Pistolet_Essence"} count (attachedObjects _veh)) > 0 AND {((_station getVariable ["station_litre", 3000]) - (_litre / 2)) > 0}}} do 
{
	if (_pos distance _veh >= 8) exitWith {[4,_veh] remoteExecCall ["ALF_fnc_pistoletEssence",_player];};
	[_veh,(fuel _veh) + (2/_fuelCapa)] remoteExecCall ["setFuel",_veh];
	_pistolet setVariable ["ALF_NombreLitre",((_pistolet getVariable ["ALF_NombreLitre",0]) + 1),true];
	_litre = _litre + 0.5;
	uiSleep _timer;
};

[-(_litre / 2),_station,_player,getposatl _station] call ALF_Server_fnc_updateStation;

while {({typeOf _x isEqualTo "ALF_Pistolet_Essence"} count (attachedObjects _veh)) > 0} do 
{
	if (_pos distance _veh >= 8) exitWith {[4,_veh] remoteExecCall ["ALF_fnc_pistoletEssence",_player];};
};
// };