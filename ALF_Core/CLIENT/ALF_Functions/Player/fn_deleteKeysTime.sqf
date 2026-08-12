// ALF_fnc_deleteKeysTime = {['GGGGGGG'] remoteExec ['systemchat',0];
private _batiment = param [0,objNull];
private _pos = param [1,[0,0,0]];
private _type = param [2,""];

if (isServer) exitwith {};


if (isNull _batiment) then 
{
	_batiment = (nearestTerrainObjects [_pos, [], 15] select {_type in str _x}) # 0;	
};
if (isnil {_batiment}) exitwith {};
// ['_batiment ' + str(_batiment)] remoteExec ['systemchat',0];
private _index = life_vehicles find _batiment;
if !(_index isEqualTo -1) then {
	life_vehicles deleteAt _index;
};

_batiment setVariable ["ALF_PorteFermer",nil,true];

// ['ALF_PorteFermer ' + str(_batiment getVariable "ALF_PorteFermer")] remoteExec ['systemchat',0];
// };