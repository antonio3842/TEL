/*
  File: fn_playSound3D.sqf
  Description: Joue un son 3D à une position avec distance personnalisée.
*/

params [
	["_soundPath", "", [""]],
	["_object", objNull, [objNull]],
	["_isInside", false, [false]],
	["_pos", [0,0,0], [[]]],
	["_volume", 1, [0]],
	["_pitch", 1, [0]],
	["_distance", 30, [0]]
];

if (isNull _object) exitWith {};
if (_pos isEqualTo [0,0,0]) then { _pos = getPosASL _object; };

playSound3D [_soundPath, _object, _isInside, _pos, _volume, _pitch, _distance];
