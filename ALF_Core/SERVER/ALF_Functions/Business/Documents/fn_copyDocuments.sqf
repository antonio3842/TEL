/* Copyright 2023 - Association Get Your Path. All rights reserved */
params [
    ["_from_name","",[]],
    ["_to_name","",[]],
    ["_type","",[""]],
    ["_text","",[]],
    ["_side","",[]],
    ["_copyDocumentID",0,[0]],
    ["_expirationDate","",[]],
    ["_sendToPID","",[""]]
];

private _query = format ["INSERT INTO documents (from_pid, to_pid, from_name, to_name, type, text, side, copy, expiration_date, send_to_pid) VALUES ('0', '0', '%1', '%2', '""%3""', '""%4""', '%5', '%6', %7, '%8')",_from_name,_to_name,_type,_text,_side,_copyDocumentID,_expirationDate,_sendToPID];
[_query,1] call ALF_Server_fnc_asyncCall;
