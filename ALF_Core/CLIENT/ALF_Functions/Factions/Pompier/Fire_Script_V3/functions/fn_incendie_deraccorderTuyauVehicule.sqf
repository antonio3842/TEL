params [
	["_vanne", 1, [1]]
];
_vehicle = cursorObject;
_raccord = objNull;
_var = _vehicle getVariable ["connectedTo",[objNull,objNull,objNull,objNull,objNull]];
switch _vanne do { 
	case 1 : {  
		_raccord = _var select 0;
		_var set [0,objNull];
	}; 
	case 2 : {  
		_raccord = _var select 1;
		_var set [1,objNull];
	}; 
	case 3 : {  
		_raccord = _var select 2;
		_var set [2,objNull];
	}; 
	case 4 : {  
		_raccord = _var select 3;
		_var set [3,objNull];
	}; 
	case 5 : {  
		_raccord = _var select 4;
		_var set [4,objNull];
	}; 
};

hint "Raccord débranché !";

_vehicle setVariable ["connectedTo", _var, true];
_raccord setVariable ["connectedTo", objNull, true];

_demi_raccord_memory = _raccord selectionPosition "demi_raccord_memory";
_raccord attachTo [player,[0,-(_demi_raccord_memory select 1),0],"RightHandMiddle1"];
byscream_demi_raccord_hand = _raccord;

while {!isNull byscream_demi_raccord_hand} do {
	_opposite = byscream_demi_raccord_hand getVariable "opposite";
	_longueur = (byscream_demi_raccord_hand getVariable ["longueur",20]);
	if ((player distance _opposite) > _longueur) then {
		hint "Vous ne pouvez pas aller si loin ! Veuillez redéployer un tuyau.";
		_dir = vectorNormalized ((getPos _opposite) vectorFromTo (getPos player));  // direction du joueur vers l'objet
        _newPos = (getPos _opposite) vectorAdd [(_dir select 0) * (_longueur-1), (_dir select 1) * (_longueur-1), 0];  // position exactement à 20 m
		_newPos set [2, (getPos player) select 2];
        player setPos _newPos;
	};
	sleep 0.1;
};