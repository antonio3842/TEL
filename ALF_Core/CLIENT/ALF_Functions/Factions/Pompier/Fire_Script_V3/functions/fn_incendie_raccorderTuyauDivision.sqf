params [
	["_vanne", 1,[1]]
];
_vehicle = (nearestObjects [getPos player, ["byscream_division_simple_object"],1]) select 0;
_arrayPosition	= [];
_yaw = 0;
_pitch = 0;
_var_div = _vehicle getVariable ["connectedTo_div", [objNull,objNull]];
_raccord = byscream_demi_raccord_hand;
_exit = false;
switch _vanne do {
	case 1: {
		_arrayPosition = [-0.29,0.005,-0.027];
		_var_div set [0,_raccord];
		_vehicle setVariable ["connectedTo_div", _var_div, true];
		_yaw = 48;     
		_pitch = 0;
		if (typeOf _raccord isNotEqualTo "byscream_demi_raccord45") then {_exit = true;};
	};
	case 2: {
		_arrayPosition = [0.29,0.005,-0.027];
		_var_div set [1,_raccord];
		_vehicle setVariable ["connectedTo_div", _var_div, true];
		_yaw = -48;     
		_pitch = 0;
		if (typeOf _raccord isNotEqualTo "byscream_demi_raccord45") then {_exit = true;};
	};
	case 3: {
		_arrayPosition = [0,0.95,-0.013];
		_vehicle setVariable ["connectedTo",_raccord,true];
		_yaw = 180;     
		_pitch = 0;
		if (typeOf _raccord isNotEqualTo "byscream_demi_raccord70") then {_exit = true;};
	};	
};
if (_exit) exitWith {hint "Ce n'est pas le bon diamètre !"};
detach _raccord;
byscream_demi_raccord_hand = objNull;
_demi_raccord_memory_2 = _raccord selectionPosition "demi_raccord_memory";
_raccord attachTo [_vehicle,_arrayPosition vectorAdd [0,-(_demi_raccord_memory_2 select 1), -(_demi_raccord_memory_2 select 2)]];


private _dir = [ 
    (sin _yaw) * (cos _pitch), 
    (cos _yaw) * (cos _pitch), 
    (sin _pitch) 
]; 
 
private _up = [ 
    -(sin _yaw) * (sin _pitch), 
    -(cos _yaw) * (sin _pitch), 
    (cos _pitch) 
]; 
_raccord setVectorDirAndUp [_dir, _up];


//_raccord setPos [_position select 0, _position select 1, _arrayPosition select 2];
hint "Raccord raccordé !";

_raccord setVariable ["connectedTo", _vehicle, true];