/*
	File: fn_buyForfait.sqf
	Author: ALF Team
*/
params [
	["_uid","",[""]],
	["_mode",-1,[0]],
	["_unit",objNull,[objNull]]
];
if(_uid isEqualTo "" OR {_mode isEqualTo -1} OR {isNull _unit}) exitWith {};

private _metod = 0;
private _time = 0;

//On check si il existe
private _queryResult = [format["SELECT offre, time, number FROM phone WHERE playerid='%1'",_uid],2] call ALF_Server_fnc_asyncCall;

if (count(_queryResult) isEqualTo 0) then {
	_metod = 2;
} else {
	private _offre = _queryResult select 0;
	private _number = "";
	if (count(_queryResult) > 2) then {
		_number = _queryResult select 2;
		if (isNil "_number") then { _number = ""; };
	};
	
	// Si l'offre est résiliée (0) ou si le numéro est vide/null, on traite comme un nouveau forfait
	if (_offre isEqualTo "0" OR {_number isEqualTo ""} OR {_number isEqualTo "NULL"}) then {
		_metod = 2;
	} else {
		_metod = 1;
		_time = _queryResult select 1;
	};
};

private "_query";
switch (_metod) do {
	case 1 : {
		switch (_mode) do {
			case 1 : {
				_time = _time + (60 * 24);
			};
			case 2 : {
				_time = _time + (60 * 24) * 3;
			};
			case 3 : {
				_time = _time + (60 * 24) * 7;
			};
			case 4 : {
				_time = _time + (339 * 60);
			};
		};
		_query = format["UPDATE phone SET offre='1', time='%1' WHERE playerid='%2'",_time,_uid];
	};
	case 2 : {
		switch (_mode) do {
			case 1 : {
				_time = (60 * 24);
			};
			case 2 : {
				_time = (60 * 24) * 3;
			};
			case 3 : {
				_time = (60 * 24) * 7;
			};
			case 4 : {
				_time = 339 * 60;
			};
		};
		// Si l'enregistrement existe déjà avec offre='0', on fait un UPDATE, sinon INSERT
		if (count(_queryResult) isEqualTo 0) then {
			_query = format["INSERT INTO phone (playerid, offre, time, contacts) VALUES ('%1', '1', '%2','""[]""')",_uid,_time];
		} else {
			_query = format["UPDATE phone SET offre='1', time='%1', contacts='""[]""' WHERE playerid='%2'",_time,_uid];
		};
		[_uid,_unit] spawn ALF_Server_fnc_createPhoneNumber;
	};
};

[_query,1] call ALF_Server_fnc_asyncCall;

[_time] remoteExecCall ["ALF_fnc_updateForfait",_unit];
