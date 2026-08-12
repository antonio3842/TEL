/*
	File: fn_getVehiclesCopSP.sqf
	Author: ALF TEAM
*/
params [
	["_type_veh","",[""]],
	["_unit",objNull,[objNull]],
	["_type",-1,[-1]]
];

if(_type_veh isEqualTo "" OR {isNull _unit}) exitWith {
	if !(isNull _unit) then {
		[[]] remoteExec ["ALF_fnc_impoundMenuCopSP",_unit];
	};
};

private _query = format["SELECT id, classname, type, alive, active, plate, fuel, lockveh, locktime, damage, id_garage FROM vehicles_penit WHERE alive='1' AND active='0' AND type='%1'",_type_veh];
private _queryResult = [_query,2,true] call ALF_Server_fnc_asyncCall;

if(_queryResult isEqualType "") exitWith {
	[[]] remoteExec ["ALF_fnc_impoundMenuPenit",_unit];
};

//plate + damage
private ["_plate","_damage"];
{
	_plate = [_x select 5] call ALF_Server_fnc_mresToArray;
	if(_plate isEqualType "") then {_plate = call compile format["%1", _plate];};

	_damage = [_x select 9] call ALF_Server_fnc_mresToArray;
	if(_damage isEqualType "") then {_damage = call compile format["%1", _damage];};
	if(isNil "_damage" || {!(_damage isEqualType [])}) then {_damage = [];};

	_x set[5,_plate];
	_x set[9,_damage];
} forEach _queryResult;

private _nonfourriere = _queryResult select {(_x select 7) isEqualTo 0};
private _fourriere = _queryResult select {(_x select 7) isEqualTo 1};

[_nonfourriere,_fourriere,_type] remoteExec ["ALF_fnc_impoundMenuPenit",_unit];
