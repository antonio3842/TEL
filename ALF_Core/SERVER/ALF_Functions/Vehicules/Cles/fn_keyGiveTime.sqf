/*
	File: fn_keyGiveTime.sqf
	Author: ALF Team
	0 = veh
	1 = house
*/
private _mode = _this select 0;
private _obj = _this select 1;
private _time = _this select 2;
private _unit = _this select 3;
private _player = _this select 4;
private _uid = getPlayerUID _unit;
private _name = getText(configFile >> "CfgVehicles" >> (typeOf _obj) >> "displayName");

switch (_mode) do {
	case 0 : {
		if(_time < 1 OR {_time > 30}) exitWith {["PORTE CLÉS", "Le nombre de jour doit etre entre 1 et 30.", "warning"] remoteExec ["ALF_fnc_doMsg",_player];};
		private _var = _obj getVariable["dbInfo",[]];
		if(count _var isEqualTo 0) exitWith {};
		private _plate = _var select 1;

		private _check = format["SELECT id FROM vehicles WHERE plate='%1'",_plate];
		private _result = [_check,2] call ALF_Server_fnc_asyncCall;
		if(count _result isEqualTo 0) exitWith {};

		private _vid = _result select 0;

		private _count = ([format["SELECT COUNT(*) FROM keysTime WHERE pid='%1' AND idobj='%2' AND mode='%3'",_uid,_vid,_mode],2] call ALF_Server_fnc_asyncCall) select 0;
		if(_count > 0) exitWith {["PORTE CLÉS", "Vous avez déjà donné cette clé !", "warning"] remoteExec ["ALF_fnc_doMsg",_player];};

		private _query = format["INSERT INTO keysTime (pid, mode, idobj, time) VALUES('%1', '%2', '%3','%4')",_uid,_mode,_vid,_time];
		[_query,1] call ALF_Server_fnc_asyncCall;

		[_obj,_unit] remoteExecCAll ["TON_fnc_clientGetKey",_unit];

		["PORTE CLÉS", format["Vous avez reçu un double de clé de: %1 pour %2 jour(s).",_name,_time],"success"] remoteExec ["ALF_fnc_doMsg",_unit];
		["PORTE CLÉS", format["Vous avez donné le double de clé de: %1 pour %2 jour(s).",_name,_time],"success"] remoteExec ["ALF_fnc_doMsg",_player];
	};
	case 1 : {
		if(_time < 1 OR {_time > 30}) exitWith {["PORTE CLÉS", "Le nombre de jour doit etre entre 1 et 30.", "warning"] remoteExec ["ALF_fnc_doMsg",_player];};
		private _dbInfo = _obj getVariable ["house_owner",[]];
		if(count _dbInfo isEqualTo 0) exitWith {};
		if !((getPlayerUID _player) isEqualTo (_dbInfo select 0)) exitWith {["INFO", "Vous n'êtes pas le propriétaire de la maison.", "success"] remoteExec ["ALF_fnc_doMsg",(remoteExecutedOwner)];};

		private _hid = _obj getVariable ["house_id",-1];
		if(_hid isEqualTo -1) exitWith {};

		private _count = ([format["SELECT COUNT(*) FROM keysTime WHERE pid='%1' AND idobj='%2' AND mode='%3'",_uid,_hid,_mode],2] call ALF_Server_fnc_asyncCall) select 0;
		if(_count > 0) exitWith {["PORTE CLÉS", "Vous avez déjà donné cette clé !", "warning"] remoteExec ["ALF_fnc_doMsg",_player];};

		private _query = format["INSERT INTO keysTime (pid, mode, idobj, time) VALUES('%1', '%2', '%3','%4')",_uid,_mode,_hid,_time];
		[_query,1] call ALF_Server_fnc_asyncCall;

		[_obj,_unit] remoteExecCAll ["TON_fnc_clientGetKey",_unit];

		["PORTE CLÉS", format["Vous avez reçu un double de clé de: %1 pour %2 jour(s).",_name,_time],"success"] remoteExec ["ALF_fnc_doMsg",_unit];
		["PORTE CLÉS", format["Vous avez donné le double de clé de: %1 pour %2 jour(s).",_name,_time],"success"] remoteExec ["ALF_fnc_doMsg",_player];
	};
};
