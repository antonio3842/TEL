/*
	File: fn_initCNG.sqf
*/
private _result = [format["SELECT bank FROM cnpm WHERE id='1'"],2] call ALF_Server_fnc_asyncCall;
if(count _result isEqualTo 0) exitWith {};
_result = parseNumber(_result select 0);
missionNamespace setVariable ["CNPM",_result,true];
