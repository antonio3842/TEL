/*
	fetchKeys
*/
params[
	["_uid","",[""]
]];
if(_uid isEqualTo "") exitWith {};

private _keys = [format["SELECT idobj, mode, time FROM keysTime WHERE pid='%1'",_uid],2,true] call ALF_Server_fnc_asyncCall;

private _return = [];
private _toDelete = [];

{
	_x params[
		["_idobj",-1,[0]],
		["_mode",-1,[0]],
		["_time",0,[0]]
	];

	if !(_idobj isEqualTo -1 OR {_mode isEqualTo -1}) then {
		if (_time isEqualTo 0) then {
			_toDelete pushBack [_idobj, _mode];
		} else {
			if(_mode isEqualTo 0) then {
				private _k = [format["SELECT plate FROM vehicles WHERE id='%1' AND active='1' AND alive='1'",_idobj],2] call ALF_Server_fnc_asyncCall;
				if(count _k > 0) then {
					_return pushBack ([0, _k select 0]);
				};
			} else {
				private _k = [format["SELECT pos FROM houses WHERE id='%1'",_idobj],2] call ALF_Server_fnc_asyncCall;
				if(count _k > 0) then {
					_return pushBack ([1,_k select 0]);
				};
			};
		};
	};
} forEach _keys;

{
	_x params ["_idobj", "_mode"];
	[format["DELETE FROM keysTime WHERE pid='%1' AND idobj='%2' AND mode='%3'", _uid, _idobj, _mode], 1] call ALF_Server_fnc_asyncCall;
} forEach _toDelete;

_return
