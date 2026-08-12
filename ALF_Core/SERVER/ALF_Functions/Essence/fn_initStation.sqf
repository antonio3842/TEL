// /*
// 	File: fn_initStation.sqf
// 	Author: ALF Nanou

// 	This file is for Nanou's HeadlessClient.
// */

// if true exitwith {};
// private["_queryResult","_query","_count"];
// _count = (["SELECT COUNT(*) FROM station",2] call ALF_Server_fnc_asyncCall) select 0;

// diag_log format["================================== STATION LOADING (0/%1) ==================================", _count];

// for [{_x=0},{_x<=_count},{_x=_x+10}] do {
// 	// _query = format[,0];
// 	_queryResult = ["SELECT id, pos, litre FROM station WHERE id = 2",2,true] call ALF_Server_fnc_asyncCall;
// 	['_queryResult' + str(_queryResult)] remoteExec ['systemchat',0];
// 	aqueryResult = [];
// 	aqueryResult = _queryResult;
// 	publicVariable "aqueryResult";
// 	['_queryResult' + str(_queryResult)] remoteExec ['systemchat',0];
// 	if(count _queryResult isEqualTo 0) exitWith {};
// 	{
// 		diag_log format["STATION : %1", _x];
		
// 		private _station = nearestObject [(call compile format["%1",_x select 1]), "plp_up_PropaneTankA"];
// 		if !(isNull _station) then {
// 			private _litre = _x select 2;
// 			_station setVariable ["station_litre",_litre,true];
// 			_station setVariable ["station_id",_x select 0];
// 			switch (true) do {
// 				case (_litre isEqualTo 0): {
// 					_station setObjectTextureGlobal [0, ""];
// 				};
// 				case (_litre <= 500): {
// 					_station setObjectTextureGlobal [0, ""];
// 				};
// 				case (_litre > 500 && _litre <= 1000): {
// 					_station setObjectTextureGlobal [0, ""];
// 				};
// 				case (_litre > 1000 && _litre <= 1500): {
// 					_station setObjectTextureGlobal [0, ""];
// 				};
// 				case (_litre > 1500 && _litre <= 2000): {
// 					_station setObjectTextureGlobal [0, ""];
// 				};
// 				case (_litre > 2000 && _litre <= 2500): {
// 					_station setObjectTextureGlobal [0, ""];
// 				};
// 				case (_litre > 2500): {
// 					_station setObjectTextureGlobal [0, ""];
// 				};
// 			};
// 		};
// 	} forEach _queryResult;
// };
// // 
// diag_log format["================================== STATION LOADED (%1/%1) ==================================", _count];