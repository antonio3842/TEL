params [
	["_current_obj",objNull]
];

_car = objNull;
_next_veh = _current_obj getVariable ["opposite", objNull];

while {!(isNull _next_veh)} do {
	_current_obj = _next_veh getVariable ["connectedTo", objNull];
	if (typeOf _current_obj isEqualTo "byscream_division_simple_object") then {
		_next_veh = _current_obj;
	} else {
		_next_veh = _current_obj getVariable ["opposite", objNull];
	};
	
};

_car = _current_obj;

_car;