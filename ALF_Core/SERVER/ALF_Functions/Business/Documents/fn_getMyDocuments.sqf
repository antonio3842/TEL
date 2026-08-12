/*
    Author: Yuri Zoko
    Web site: www.the-programmer.com
    Discord: https://discord.the-programmer.com

    Terms of use:
      - This file is forbidden unless you have permission from the author. If you have this file without permission to use it please do not use it and do not share it.
      - If you have permission to use this file, you can use it on your server however it is strictly forbidden to share it.
      - Out of respect for the author please do not delete this information.
*/ 
_pid = param [0,"",[""]];
if (_pid isEqualTo "") exitWith {};

private _query = format ["SELECT id, from_pid, to_pid, from_name, to_name, type, text, side, copy, CONCAT('""',expiration_date,'""'), CONCAT('""',insert_time,'""'), if (expiration_date < CURRENT_DATE, true, false) FROM documents WHERE from_pid='%1' ORDER BY insert_time DESC",_pid];
private _queryResult = [_query,2,true] call DB_fnc_asyncCall;

[_queryResult] remoteExec ["advanced_documents_tpfn_resultGet",remoteExecutedOwner];
