// /*
// 	File: fn_getVehicles.sqf
// 	Author: ALF TEAM
// */
// ALF_Server_fnc_getVehicles = {
params [
	["_pid","",[""]],
	["_type","",[""]],
	["_unit",objNull,[objNull]]
];

//Error checks
if(_pid isEqualTo "" OR {_type isEqualTo ""} OR {isNull _unit}) exitWith 
{
	if !(isNull _unit) then {[[]] remoteExec ["ALF_fnc_impoundMenu",_unit];};
};

private _query = format["SELECT id, classname, type, pid, alive, active, plate, fuel, insure, insurecount, lockveh, locktime, damage, id_garage, pos_save FROM vehicles WHERE pid='%1' AND alive='1' AND active='0' AND type='%2'",_pid,_type];
private _queryResult = [_query,2,true] call ALF_Server_fnc_asyncCall;

if(_queryResult isEqualType "") exitWith {[[]] remoteExec ["ALF_fnc_impoundMenu",_unit];};

//plate + damage
private ["_plate","_damage"];
{
	_plate = [_x # 6] call ALF_Server_fnc_mresToArray;
	if(_plate isEqualType "") then {_plate = call compile format["%1", _plate];};

	_damage = [_x # 12] call ALF_Server_fnc_mresToArray;
	// if(_damage isEqualType "") then {_damage = call compile format["%1", _plate];};
	if(_damage isEqualType "") then {_damage = call compile format["%1", _damage];};

	_pos = [_x # 14] call ALF_Server_fnc_mresToArray;
	if(_pos isEqualType "") then {_pos = call compile format["%1", _pos];};

	_x set[6,_plate];
	_x set[12,_damage];
	_x set[14,_pos];
} forEach _queryResult;

private _nonfourriere = _queryResult select {(_x # 10) isEqualTo 0};
private _fourriere = _queryResult select {(_x # 10) isEqualTo 1};
// private _pos_veh = _queryResult select {};

[_nonfourriere,_fourriere] remoteExec ["ALF_fnc_impoundMenu",_unit];
// };