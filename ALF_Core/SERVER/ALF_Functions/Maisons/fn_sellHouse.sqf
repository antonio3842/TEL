// ALF_Server_fnc_sellHouse = {
private _batiment = param [0,objNull];
private _pos = param [1,[0,0,0]];
private _type = param [2,""];

if (isNull _batiment) then 
{
	_batiment = (nearestTerrainObjects [_pos, [], 15] select {_type in str _x}) # 0;
};
if (isnil {_batiment}) exitwith {};

private _houseID = _batiment getVariable["house_id",-1];
if(_houseID isEqualTo -1) exitWith {};

[format["DELETE FROM houses WHERE id='%1'",_houseID],1] call ALF_Server_fnc_asyncCall;

[format["DELETE FROM keysTime WHERE mode='1' AND idobj='%1'",_houseID],1] call ALF_Server_fnc_asyncCall;

[_batiment,_pos,_type] remoteExec ["ALF_fnc_deleteKeysTime",0,true];

_batiment setVariable ["house_id",nil];
_batiment setVariable ["house_owner",nil];

// };