/* Copyright 2023 - Association Get Your Path. All rights reserved */
_player = param [0,objNull,[objNull]];
if (isNull _player) exitWith {};

private _query = [format["SELECT id, type FROM documents WHERE to_pid='%1' AND (expiration_date > CURRENT_DATE)",(getPlayerUID _player)],2,true] call ALF_Server_fnc_asyncCall;

_player setVariable ["documents_list",_query,true];
