/* Copyright 2023 - Association Get Your Path. All rights reserved */
params [
    ["_id",0,[0]],
    ["_from_uid","",[""]],
    ["_to_uid","",[""]],
    ["_side","",[""]],
    ["_copy",0,[0]]
];

if (_from_uid isEqualTo "") exitWith {};

_query = format ["DELETE FROM documents WHERE id='%1' AND from_pid='%2' AND to_pid='%3' and side='%4'",_id,_from_uid,_to_uid,_side];

if (_copy isEqualTo 0) then {
    _query = format ["UPDATE documents SET to_pid='DELETED' WHERE id='%1' AND from_pid='%2' AND to_pid='%3' and side='%4'",_id,_from_uid,_to_uid,_side];
};

[_query,1] call ALF_Server_fnc_asyncCall;
