/* Copyright 2023 - Association Get Your Path. All rights reserved */
_pid = param [0,"",[""]];
if (_pid isEqualTo "") exitWith {};

private _queryResult = [format ["SELECT id, from_pid, to_pid, from_name, to_name, type, text, side, copy, CONCAT('""',expiration_date,'""'), CONCAT('""',insert_time,'""'), if (expiration_date < CURRENT_DATE, true, false) FROM documents WHERE to_pid='%1' OR send_to_pid='%1' ORDER BY insert_time DESC",_pid],2,true] call DB_fnc_asyncCall;

[_queryResult] remoteExec ["ALF_fnc_resultGet",remoteExecutedOwner];
