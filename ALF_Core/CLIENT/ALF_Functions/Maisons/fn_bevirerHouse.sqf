private["_house","_uid","_action","_houseCfg"];
_house = param [0,objNull,[objNull]];
_uid = param [1,""];

if (isNull _house) exitWith {};

deleteMarkerLocal format["house_%1",_uid];

[0] call SOCK_fnc_updatePartial;

_index = life_vehicles find _house;

if(_index != -1) then {	life_vehicles deleteAt _index;};

_index = life_houses find (str(getPosATL _house));
if(_index != -1) then {	life_houses deleteAt _index;};