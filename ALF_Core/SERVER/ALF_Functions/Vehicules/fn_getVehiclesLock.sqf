// ALF_Server_fnc_getVehiclesLock = {
params [["_unit",objNull,[objNull]]];
if (isNull _unit) exitWith {};

private _requete = format ["SELECT id, classname, type, pid, alive, active, plate, fuel, insure, locktime FROM vehicles WHERE alive='1' AND active='0' AND lockveh='1' AND pid='%1'",getplayeruid _unit];
private _queryResult = [_requete,2,true] call ALF_Server_fnc_asyncCall;

if (_queryResult isEqualType "") exitWith {[[]] remoteExec ["ALF_fnc_impoundMenuLock",_unit];};

[_queryResult] remoteExec ["ALF_fnc_impoundMenuLock",_unit];
// };