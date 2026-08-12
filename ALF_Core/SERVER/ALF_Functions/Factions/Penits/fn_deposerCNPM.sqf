/*
	File: fn_deposerCNPM.sqf
*/
private _value = missionNamespace getVariable ["CNPM",0];
[format["UPDATE cnpm SET bank='%1' WHERE id='1'",_value],1] call ALF_Server_fnc_asyncCall;