/*
	File: fn_updateCNG.sqf
*/
private _num = _this select 0;
if(isNil "_num") exitWith {};
[format["UPDATE cnpm SET bank='%1' WHERE id='1'",_num],1] call ALF_Server_fnc_asyncCall;
missionNamespace setVariable ["CNPM",_num,true];
