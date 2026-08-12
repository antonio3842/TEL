params[
	["_longueur",0],
	["_diametre",45]
];

_dir = getDir player;
_pos = getPosATL player;
_tuyau = objNull;
_demi_raccord_1 = objNull;
_demi_raccord_2 = objNull;
_tuyau_obj_classname = "byscream_tuyau_enroule_rouge";
_pos1 = ASLToATL (player modelToWorldWorld [1,0.5,0.1]);
_pos2 = ASLToATL (player modelToWorldWorld [1.1,0.5,0.1]);
switch (_diametre) do {
	case 45: {
		_demi_raccord_1 = createVehicle ["byscream_demi_raccord45", _pos1, [], 0, "CAN_COLLIDE"];
		_demi_raccord_2 = createVehicle ["byscream_demi_raccord45", _pos2, [], 0, "CAN_COLLIDE"];
		_demi_raccord_1 setPosATL _pos1;
		_demi_raccord_2 setPosATL _pos2;
		_rope_memory = _demi_raccord_2 selectionPosition "rope_memory";
		_tuyau = ropeCreate [_demi_raccord_2, _rope_memory, _demi_raccord_1, _rope_memory, _longueur,["", [0,0,-1]],["", [0,0,-1]],"ByScream_Tuyau45"];
		if (_longueur == 20) then {
			player removeMagazine "byscream_tuyau20_45_simple";
		} else {
			player removeMagazine "byscream_tuyau40_45_simple";
		};
	};
	case 70: {
		_demi_raccord_1 = createVehicle ["byscream_demi_raccord70", _pos1, [], 0, "CAN_COLLIDE"];
		_demi_raccord_2 = createVehicle ["byscream_demi_raccord70", _pos2, [], 0, "CAN_COLLIDE"];
		_demi_raccord_1 setPosATL _pos1;
		_demi_raccord_2 setPosATL _pos2;
		_rope_memory = _demi_raccord_2 selectionPosition "rope_memory";
		_tuyau = ropeCreate [_demi_raccord_2, _rope_memory, _demi_raccord_1, _rope_memory, _longueur,["", [0,0,-1]],["", [0,0,-1]],"ByScream_Tuyau70"];
		if (_longueur == 20) then {
			player removeMagazine "byscream_tuyau20_70_simple";
		} else {
			player removeMagazine "byscream_tuyau40_70_simple";
		};
	};
	case 110: {
		_tuyau_obj_classname = "byscream_tuyau_enroule_gris";
		_demi_raccord_1 = createVehicle ["byscream_demi_raccord110", _pos1, [], 0, "CAN_COLLIDE"];
		_demi_raccord_2 = createVehicle ["byscream_demi_raccord110", _pos2, [], 0, "CAN_COLLIDE"];
		_demi_raccord_1 setPosATL _pos1;
		_demi_raccord_2 setPosATL _pos2;
		_rope_memory = _demi_raccord_2 selectionPosition "rope_memory";
		_tuyau = ropeCreate [_demi_raccord_2, _rope_memory, _demi_raccord_1, _rope_memory, _longueur,["", [0,0,-1]],["", [0,0,-1]],"ByScream_Tuyau110"];
		if (_longueur == 10) then {
			player removeMagazine "byscream_tuyau10_110_simple";
		};
		if (_longueur == 20) then {
			player removeMagazine "byscream_tuyau20_110_simple";
		};
		if (_longueur == 40) then {
			player removeMagazine "byscream_tuyau40_110_simple";
		};
	};
};

_demi_raccord_1 setVariable ["opposite",_demi_raccord_2,true];
_demi_raccord_2 setVariable ["opposite",_demi_raccord_1,true];
_demi_raccord_1 setVariable ["longueur",_longueur,true];
_demi_raccord_2 setVariable ["longueur",_longueur,true];

_velocity = 16;
switch _longueur do {
	case 20: {
		_velocity = 16;
	};
	case 40: {
		_velocity = 20;
	};
	case 10: {
		_velocity = 10;
	};
		
};
_demi_raccord_1 setDir (_dir+180);
_demi_raccord_2 setDir _dir;
_demi_raccord_2 setVelocity [(sin _dir * _velocity),(cos _dir * _velocity), 0];
_tuyau_obj = createVehicle [_tuyau_obj_classname, ASLtoATL (player modelToWorldWorld [1.1,0.5,0]), [], 0, "CAN_COLLIDE"];
_tuyau_obj attachTo [_demi_raccord_2,[0,0,0]];
_tuyau_obj setVectorDirAndUp [[-0.0259298,-0.998207,-0.0539533], [0.999413,-0.0270951,0.0209789]];
_tuyau_obj disableCollisionWith player;
_demi_raccord_1 lock true;
_demi_raccord_1 lockInventory true;
_demi_raccord_2 lock true;
_demi_raccord_2 lockInventory true;
sleep 2;
deleteVehicle _tuyau_obj;
_demi_raccord_2 setVelocity [0,0,0];