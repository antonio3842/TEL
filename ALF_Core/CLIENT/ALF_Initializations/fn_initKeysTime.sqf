#include "\ALF_Client\script_macros.hpp"
/*
	initKeysTime.sqf
*/
params [
	["_data",[],[[]]]
];
if(_data isEqualTo []) exitWith {};

private _entities = entities [["Car","Air","Ship"], [], false, true];

{
	_x params [
		["_mode",-1,[0]],
		["_wtf","",["",[]]]
	];

	if(_mode isEqualTo 0) then {
		// Convertir _wtf en array si c'est une string (plaque d'immatriculation)
		private _plateArray = if (_wtf isEqualType "") then {
			(toArray _wtf) apply {toLower (toString [_x])}
		} else {
			if (_wtf isEqualType []) then { _wtf apply {toLower _x} } else { [] }
		};

		{
			private _veh = _x;
			if (alive _veh) then {
				private _plate = [_veh] call ALF_fnc_getPlaque;
				if(!(isNil "_plate") && {_plateArray isEqualTo _plate}) then {
					if !(_veh in life_vehicles) then {
						life_vehicles pushBack _veh;
					};
				};
			};
		} forEach _entities;
	} else {
		private _house = nearestObject [(call compile format["%1",_wtf]),"House"];
		if !(_house in life_vehicles) then {
			life_vehicles pushBack _house;
		};
	};
} forEach _data;
