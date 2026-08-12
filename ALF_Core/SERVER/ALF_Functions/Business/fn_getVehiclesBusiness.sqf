// ALF_Server_fnc_getVehiclesBusiness = {
params[
	["_building",objNull,[objNull]],
	["_type","",[""]],
	["_pid","",[""]],
	["_unit",objNull,[objNull]]
];
if(isNull _building OR {_type isEqualTo ""} OR {_pid isEqualTo ""} OR {isNull _unit}) exitWith {};

private _queryResult = [format["SELECT id, classname, alive, active, plate, fuel, insure FROM vehicles WHERE type='%1' AND alive='1' AND active='0' AND lockveh='0'",_type],2,true] call ALF_Server_fnc_asyncCall;
if(_queryResult isEqualType "") exitWith {[[],_building] remoteExec ["ALF_fnc_impoundMenuBusiness",_unit];};


[_queryResult,_building] remoteExec ["ALF_fnc_impoundMenuBusiness",_unit];
// };