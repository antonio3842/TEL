params ["_obj","_variableName"];

_var = _obj getVariable _variableName;

systemchat format ["[DEBUG SingleVar] _var = %1",_var];
systemchat format ["[DEBUG SingleVar] remoteExecutedOwner = %1",remoteExecutedOwner];

if (isNil "_var") exitWith {_obj setVariable [_variableName,"NO_VAR",remoteExecutedOwner];};
_obj setVariable ["singleSyncReturn",_var,remoteExecutedOwner];
_obj setVariable [_variableName,_var,remoteExecutedOwner];
_var