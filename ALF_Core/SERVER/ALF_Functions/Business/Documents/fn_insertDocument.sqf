/* Copyright 2023 - Association Get Your Path. All rights reserved */
params [
    ["_doc","",[""]],
    ["_from_uid","",[""]],
    ["_to_UID","",[""]],
    ["_expiration",0,[0]],
    ["_text","",[]],
    ["_to","",[]],
    ["_from","",[]],
    ["_side","",[]]
];

private _text = [_text] call theprogrammer_core_fnc_stringToDB;

if (_expiration isEqualTo 0) then {
    _expiration = "'2035-01-01 00:00:01'";
} else {
    _expiration = format ["DATE_ADD(CURRENT_TIMESTAMP, INTERVAL %1 DAY)",_expiration];
};

[format["INSERT INTO documents (from_pid, to_pid, from_name, to_name, type, text, side, expiration_date) VALUES ('%1', '%2', '%3', '%4', '""%5""', '""%6""', '%7', %8)",_from_uid,_to_UID,_from,_to,_doc,_text,_side,_expiration],1] call ALF_Server_fnc_asyncCall;
