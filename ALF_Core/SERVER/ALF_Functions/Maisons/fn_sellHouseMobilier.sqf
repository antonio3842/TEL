/*
	File : fn_sellHousemobilier.sqf
	Author: ALF TEAM

	This file is for Nanou's HeadlessClient.
*/
private _batiment = param [0,objNull];
private _pos = param [1,[0,0,0]];
private _type = param [2,""];


if (isNull _batiment) then 
{
	_batiment = (nearestTerrainObjects [_pos, [], 15] select {_type in str _x}) # 0;
};
if (isnil {_batiment}) exitwith {};

private _mbs = _batiment getVariable["mobiliers",[]];
if(count(_mbs) > 0) then 
{
	{
		private _mobid = (_x getVariable ["mobilier_data",["",-1,"",objNull,"",false]]) # 1;
		if !(_mobid isEqualTo -1) then 
		{
			[format["DELETE FROM mobiliers WHERE id='%1'",_mobid],1] call ALF_Server_fnc_asyncCall;
			deleteVehicle _x;
		};
	} forEach _mbs;
};
_batiment setVariable ["mobiliers",nil];