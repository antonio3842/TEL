_raccord1 = (nearestObjects[player, ["byscream_demi_raccord45","byscream_demi_raccord70","byscream_demi_raccord110"], 2]) select 0;
_raccord2 = _raccord1 getVariable "opposite";
if (!((_raccord1 getVariable ["connectedTo", objNull]) isEqualTo objNull) || !((_raccord2 getVariable ["connectedTo", objNull]) isEqualTo objNull)) exitWith {
	hint "L'un des demi-raccords est branché à quelque chose !";
};

_longueur = _raccord1 getVariable ["longueur",20];
deleteVehicle _raccord2;
_classname = typeOf _raccord1;
deleteVehicle _raccord1;

_item = createVehicle ["groundWeaponHolder", ASLToATL (getPosASL player), [], 0, "CAN_COLLIDE"];

if (_classname isEqualTo "byscream_demi_raccord45") then {
	if (_longueur == 20) then {
		_item addItemCargoGlobal ["byscream_tuyau20_45_simple",1];
	} else {
		_item addItemCargoGlobal ["byscream_tuyau40_45_simple",1];
	};
};
if (_classname isEqualTo "byscream_demi_raccord70") then {
	if (_longueur == 20) then {
		_item addItemCargoGlobal ["byscream_tuyau20_70_simple",1];
	} else {
		_item addItemCargoGlobal ["byscream_tuyau40_70_simple",1];
	};
};
if (_classname isEqualTo "byscream_demi_raccord110") then {
	if (_longueur == 10) then {
		_item addItemCargoGlobal ["byscream_tuyau10_110_simple",1];
	};
	if (_longueur == 20) then {
		_item addItemCargoGlobal ["byscream_tuyau20_110_simple",1];
	};
	if (_longueur == 40) then {
		_item addItemCargoGlobal ["byscream_tuyau40_110_simple",1];
	};
};