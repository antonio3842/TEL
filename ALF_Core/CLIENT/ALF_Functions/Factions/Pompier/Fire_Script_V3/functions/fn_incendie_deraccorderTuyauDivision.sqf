params [
	["_vanne", 1, [1]]
];
_vehicle = (nearestObjects [getPos player, ["byscream_division_simple_object"],1]) select 0;
_raccord = objNull;
_var_div = _vehicle getVariable ["connectedTo_div", [objNull,objNull]];
switch _vanne do { 
	case 1 : {  
		_raccord = _var_div select 0;
		_var_div set [0,objNull];
		_vehicle setVariable ["connectedTo_div", _var_div, true];
	}; 
	case 2 : {  
		_raccord = _var_div select 1;
		_var_div set [1,objNull];
		_vehicle setVariable ["connectedTo_div", _var_div, true];
	}; 
	case 3 : {  
		_vehicle setVariable ["connectedTo",objNull,true];
	}; 
};

hint "Raccord débranché !";

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