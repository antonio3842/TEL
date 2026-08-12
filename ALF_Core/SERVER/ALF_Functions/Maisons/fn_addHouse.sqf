// /*
// 	File: fn_addHouse.sqf
// 	Author: Bryan "Tonic" Boardwine

// 	This file is for Nanou's HeadlessClient.

// 	Description:
// 	Blah
// */
// ALF_Server_fnc_addHouse = {
private _uid = param [0,""];
private _batiment = param [1,objNull];
private _name = param [2,""];
private _pos = param [3,[0,0,0]];
private _type = param [4,""];

if (isNull _batiment) then 
{
	_batiment = (nearestTerrainObjects [_pos, [], 15] select {_type in str _x}) # 0;
};
if (isnil {_batiment}) exitwith {};

private _query = format["INSERT INTO houses (pid, pos, mailbox, classname) VALUES('%1', '%2','""[]""', '%3')",_uid,_pos,_type];
[_query,1] call ALF_Server_fnc_asyncCall;

uiSleep 0.3;

_query = format["SELECT id FROM houses WHERE pos='%1' AND pid='%2'",_pos,_uid];
_queryResult = [_query,2] call ALF_Server_fnc_asyncCall;

_batiment setVariable ["house_id",(_queryResult # 0)];
_batiment setVariable ["house_owner",[_uid,_name]];
_batiment setVariable ["mobiliers",[]];
// };