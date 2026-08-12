params [
	["_vanne", 1,[1]]
];
_vehicle = cursorObject;
_arrayPosition	= [];
_var = _vehicle getVariable ["connectedTo", [objNull,objNull,objNull,objNull,objNull]];
_raccord = byscream_demi_raccord_hand;
switch _vanne do {
	case 1: {
		_arrayPosition = _vehicle selectionPosition ((["ARRAY", ["ByScream_Incendie_V3","vehicles",typeOf _vehicle,"vannes"]] call ALFTools_Client_Config_fnc_getConfig) select 0);
		_var set [0,_raccord];
	};
	case 2: {
		_arrayPosition = _vehicle selectionPosition ((["ARRAY", ["ByScream_Incendie_V3","vehicles",typeOf _vehicle,"vannes"]] call ALFTools_Client_Config_fnc_getConfig) select 1);
		_var set [1,_raccord];
	};
	case 3: {
		_arrayPosition = _vehicle selectionPosition ((["ARRAY", ["ByScream_Incendie_V3","vehicles",typeOf _vehicle,"vannes"]] call ALFTools_Client_Config_fnc_getConfig) select 2);
		_var set [2,_raccord];
	};	
	case 4: {
		_arrayPosition = _vehicle selectionPosition ((["ARRAY", ["ByScream_Incendie_V3","vehicles",typeOf _vehicle,"vannes"]] call ALFTools_Client_Config_fnc_getConfig) select 3);
		_var set [3,_raccord];
	};	
	case 5: {
		_arrayPosition = _vehicle selectionPosition ((["ARRAY", ["ByScream_Incendie_V3","vehicles",typeOf _vehicle,"vannes"]] call ALFTools_Client_Config_fnc_getConfig) select 4);
		_var set [4,_raccord];
	};	
};



detach _raccord;
byscream_demi_raccord_hand = objNull;
_demi_raccord_memory_2 = _raccord selectionPosition "demi_raccord_memory";
_raccord attachTo [_vehicle,_arrayPosition vectorAdd [0,-(_demi_raccord_memory_2 select 1), -(_demi_raccord_memory_2 select 2)]];

//_raccord setPos [_position select 0, _position select 1, _arrayPosition select 2];
hint "Raccord raccordé !";

_raccord setVariable ["connectedTo", _vehicle, true];
_vehicle setVariable ["connectedTo", _var, true];

while {(_raccord getVariable ["connectedTo", objNull]) isEqualTo _vehicle} do {
	_type_end = [_raccord] call ALF_fnc_incendie_remoteHoses;
	_hydrants = _vehicle getVariable ["byscream_hydrants_connected",[]];
	if (_type_end isKindOf "byscream_borne_incendie") then {


		_reservoir = _vehicle getVariable ["byscream_incendie_reservoir",["NUMBER", ["ByScream_Incendie_V3","vehicles", typeOf _vehicle, "reservoir"]] call ALFTools_Client_Config_fnc_getConfig];
		_qte = _reservoir+(((["NUMBER", ["ByScream_Incendie_V3","hydrant_debit"]] call ALFTools_Client_Config_fnc_getConfig)/60/60)*2);
		if (_qte > ["NUMBER", ["ByScream_Incendie_V3","vehicles", typeOf _vehicle, "reservoir"]] call ALFTools_Client_Config_fnc_getConfig) then {
			_qte = ["NUMBER", ["ByScream_Incendie_V3","vehicles", typeOf _vehicle, "reservoir"]] call ALFTools_Client_Config_fnc_getConfig;
		};
		_vehicle setVariable ["byscream_incendie_reservoir", _qte, true];

		
		if !(_raccord IN _hydrants) then {
			_hydrants pushBack _raccord;
			_vehicle setVariable ["byscream_hydrants_connected",_hydrants,true];
		};
	} else {
		if (_raccord IN _hydrants) then {
			_hydrants = _hydrants - [_raccord];
			_vehicle setVariable ["byscream_hydrants_connected",_hydrants,true];
		};
	};
	uiSleep 2;
};

_hydrants = _vehicle getVariable ["byscream_hydrants_connected",[]];
_hydrants = _hydrants - [_raccord];
_vehicle setVariable ["byscream_hydrants_connected",_hydrants,true];