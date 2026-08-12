// /*
// 	File: fn_getVehiclesCopSP.sqf
// 	Author: ALF TEAM
// */
// ALF_Server_fnc_getVehiclesCopSP = {
params 
[
	["_type",-1,[-1]],
	["_type_veh","",[""]],
	["_unit",objNull,[objNull]]
];

if(_type_veh isEqualTo "" OR {isNull _unit}) exitWith 
{
	if !(isNull _unit) then {[[]] remoteExec ["ALF_fnc_impoundMenuCopSP",_unit];};
};

private _query = "";
if(_type isEqualTo -1) then 
{
	_query = format["SELECT id,classname, type, alive, active, plate, position, fuel, lockveh, locktime, damage FROM vehicles_cop WHERE alive='1' AND active='0' AND type='%1'",_type_veh];
} else 
{
	_query = format["SELECT id,classname, type, alive, active, plate, pos_save, fuel, lockveh, locktime, damage  FROM vehicles_med WHERE alive='1' AND active='0' AND type='%1'",_type_veh];
};

private _queryResult = [_query,2,true] call ALF_Server_fnc_asyncCall;
if(_queryResult isEqualType "") exitWith {[[]] remoteExec ["ALF_fnc_impoundMenuCopSP",_unit];};

// PERF FIX: Envoyer uniquement au joueur concerné, pas broadcast à tous
queryResult = _queryResult;
(owner _unit) publicVariableClient "queryResult";

private _nonfourriere = _queryResult select {(_x # 8) isEqualTo 0};
private _fourriere = _queryResult select {(_x # 8) isEqualTo 1};

[_nonfourriere,_fourriere,_type] remoteExec ["ALF_fnc_impoundMenuCopSP",_unit];
// };