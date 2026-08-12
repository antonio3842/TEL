params [
	["_object", objNull, [objNull]]
];

_last_raccord=objNull;
_tuyauIn = _object getVariable ["tuyauxIn", ["NUMBER", ["ByScream_Incendie_V3","devidoirs",typeOf _object,"nb_tuyau"]] call ALFTools_Client_Config_fnc_getConfig];
if (_tuyauIn == 0) exitWith {
	hint "Le dévidoir est vidé de ses tuyaux !";
};
hint "Déchargement dans 3";
sleep 1;
hint "Déchargement dans 2";
sleep 1;
hint "Déchargement dans 1";
sleep 1;
hint "Déchargement de tuyau en cours";
_pos = _object modelToWorld [0,-1,0];
_azimut = (getDir _object)+180;
["TaskAssigned",["","Pour stopper le déroulement, appuie sur la touche O, et finissez de dérouler le tuyau en cours"]] call BIS_fnc_showNotification;
_number=0;
byscream_devidoir = true;
last_raccord = objNull;
for "_i" from (_tuyauIn-1) to 0 step -1 do {
	if (isNil "byscream_devidoir") exitWith {};
	_demi_raccord_1 = createVehicle ["byscream_demi_raccord70", _pos, [], 0, "CAN_COLLIDE"];
	_demi_raccord_2 = createVehicle ["byscream_demi_raccord70", _pos, [], 0, "CAN_COLLIDE"];
	_demi_raccord_1 setVariable ["opposite",_demi_raccord_2,true];
	_demi_raccord_2 setVariable ["opposite",_demi_raccord_1,true];
	_demi_raccord_1 setVariable ["longueur",40,true];
	_demi_raccord_2 setVariable ["longueur",40,true];
	_demi_raccord_2 setDir (_azimut);


	_demi_raccord_1 lock true;
	_demi_raccord_1 lockInventory true;
	_demi_raccord_2 lock true;
	_demi_raccord_2 lockInventory true;

	if !(isNull last_raccord) then {
		_demi_raccord_memory = _demi_raccord_2 selectionPosition "demi_raccord_memory";
		_demi_raccord_2 attachTo [last_raccord,[-(_demi_raccord_memory select 2),(_demi_raccord_memory select 1) + (_demi_raccord_memory select 1),(_demi_raccord_memory select 2)]];   
		_demi_raccord_2 setVectorDirAndUp [[0,-1,0], [1,0,0]];
		_demi_raccord_2 setVariable ["connectedTo", last_raccord, true];
		last_raccord setVariable ["connectedTo", _demi_raccord_2, true];
	};

	_rope_memory = _demi_raccord_2 selectionPosition "rope_memory";
	_myRope = ropeCreate [_demi_raccord_1, _rope_memory, _demi_raccord_2, _rope_memory, 1,["", [0,0,-1]],["", [0,0,-1]],"ByScream_Tuyau70"];
	sleep 0.1;
	_demi_raccord_1 attachTo [_object, [0,-0.3,0.5]];
	ropeUnwind [ropes _demi_raccord_1 select 0, 4.5, 39, true];
	sleep 0.5;
	waitUntil { count (ropes _demi_raccord_1) > 0 && {ropeUnwound (ropes _demi_raccord_1 select 0)} };
	sleep 0.3;
	detach _demi_raccord_1;
	_position = _object modelToWorld [0,-1,0];
	_demi_raccord_1 setPos [_position select 0, _position select 1, 0];
	_demi_raccord_1 setDir (getDir _object);
	_pos = _object modelToWorld [0,-1,0];
	_azimut = (getDir _demi_raccord_1)+180;
	last_raccord = _demi_raccord_1;
	_number=_i;
	hint format ["Il reste %1m/200m",_number*40];
};
byscream_devidoir = nil;
_tuyauIn = _number;
_object setVariable ["tuyauxIn", _number, true];
if (_tuyauIn > 0) then {
	["TaskSucceeded",["",format ["Déroulement terminé ! Il reste désormais %1m/200m dans le dévidoir", _tuyauIn*40]]] call BIS_fnc_showNotification;
} else {
	["TaskSucceeded",["","Le dévidoir est désormais vidé de ses tuyaux !"]] call BIS_fnc_showNotification;
};