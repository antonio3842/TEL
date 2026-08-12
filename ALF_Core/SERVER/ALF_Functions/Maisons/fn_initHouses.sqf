/*
	File: fn_initHouses.sqf
*/
private _count = (["SELECT COUNT(*) FROM houses",2] call ALF_Server_fnc_asyncCall) select 0;

diag_log format["================================== HOUSE LOADING (0/%1) ==================================", _count];

for [{_x=0},{_x<=_count},{_x=_x+10}] do {
	diag_log format["HOUSE : SELECT id, pid, pos, sonnette, classname, alarm_gendarmerie FROM houses LIMIT %1,10",_x];
	private _queryResult = [format["SELECT id, pid, pos, sonnette, classname, alarm_gendarmerie FROM houses LIMIT %1,10",_x],2,true] call ALF_Server_fnc_asyncCall;
	diag_log str(_queryResult);
	if(count _queryResult isEqualTo 0) exitWith {diag_log format["HOUSE EXIT 1 : %1", _x];};

	{
	    diag_log format["HOUSE : %1", _x];

		private _house = objNull;
		if ((_x select 4) != "") then {
			_house = nearestObject [(call compile format["%1",_x select 2]), (_x select 4)];
		} else {
			_house = nearestObject [(call compile format["%1",_x select 2]), "House"];
			[format["UPDATE houses SET classname='%1' WHERE id='%2'",typeOf(_house),_x select 0],1] call ALF_Server_fnc_asyncCall;
		};
		if !(_house isEqualTo objNull) then {
			private _name = [format["SELECT name FROM players WHERE playerid='%1'",_x select 1],2] call ALF_Server_fnc_asyncCall;
			_house setVariable ["house_owner",[_x select 1,_name select 0]];
			_house setVariable ["house_id",_x select 0];
			_house setVariable ["sonnette",_x select 3];
			_house setVariable ["alarm_gendarmerie", _x select 5];
			_house setVariable ["ALF_PorteFermer",true,true];
		};
	} forEach _queryResult;
};

diag_log format["================================== HOUSE LOADED (%1/%1) ==================================", _count];