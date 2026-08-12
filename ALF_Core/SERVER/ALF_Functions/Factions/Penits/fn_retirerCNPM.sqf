/*
	File: fn_retirerCNPM.sqf
*/
private _uid = _this select 0;
private _name = _this select 1;
private _num = _this select 2;
if(isNil "_uid" OR {isNil "_name"} OR {isNil "_num"}) exitWith {};

_name = str(_name);
private _value = missionNamespace getVariable ["CNPM",0];
[format["UPDATE cnpm SET bank='%1' WHERE id='1'",_value],1] call ALF_Server_fnc_asyncCall;

[format["INSERT INTO cnpm_list (uid, name, value) VALUES ('%1', '%2', '%3')",_uid,_name,_num],1] call ALF_Server_fnc_asyncCall;
