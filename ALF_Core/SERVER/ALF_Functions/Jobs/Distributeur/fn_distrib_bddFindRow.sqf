/*
	File: fn_distrib_bddFindRow.sqf
	Retourne [id, posStr, stockStr] de la ligne BDD la plus proche, ou [].
*/
params [["_machine", objNull, [objNull]]];

if (isNull _machine) exitWith { [] };

private _pos = getPosATL _machine;
private _rows = ["SELECT id,pos,stock FROM distributeur_alimentaire", 2, true] call ALF_Server_fnc_asyncCall;

if (!(_rows isEqualType [])) then {
	_rows = [];
};

private _found = [];

{
	if (_x isEqualType [] && {count _x >= 3}) then {
		private _posBdd = parseSimpleArray (_x # 1);

		if (_pos distance2D _posBdd < 5) exitWith {
			_found = _x;
		};
	};
} forEach _rows;

_found
