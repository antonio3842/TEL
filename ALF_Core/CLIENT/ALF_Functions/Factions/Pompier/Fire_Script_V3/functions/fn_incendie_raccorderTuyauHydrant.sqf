params [
	["_vanne", 1,[1]]
];
_vehicle = cursorObject;
_arrayPosition	= [];
_yaw = 0;
_pitch = 0;
_var = _vehicle getVariable ["connectedTo", [objNull,objNull,objNull]];
_raccord = byscream_demi_raccord_hand;
_exit = false;
switch _vanne do {
	case 1: {
		_arrayPosition = [-0.57,0.295,0.01];
		_var set [0,_raccord];
		_yaw = 69;     
		_pitch = 15;
		if (typeOf _raccord isNotEqualTo "byscream_demi_raccord70") then {_exit = true;};
	};
	case 2: {
		_arrayPosition = [0,-0.11,-0.055];
		_var set [1,_raccord];
		_yaw = 0;     
		_pitch = 6;
		if (typeOf _raccord isNotEqualTo "byscream_demi_raccord110") then {_exit = true;};
	};
	case 3: {
		_arrayPosition = [0.57,0.295,0.01];
		_var set [2,_raccord];
		_yaw = -69;     
		_pitch = 15;
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
_vehicle setVariable ["connectedTo", _var, true];