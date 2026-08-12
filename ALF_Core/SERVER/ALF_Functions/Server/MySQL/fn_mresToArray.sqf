/*
	File: fn_mresToArray.sqf
*/
params [
    ["_array","",["",[]]]
];
if (_array isEqualType []) exitWith {_array};
if (_array isEqualTo "") exitWith {[]};

_array = toArray(_array);

// Strip surrounding double quotes (ASCII 34) ajoutées par la BDD
while {count _array > 0 && {(_array # 0) isEqualTo 34}} do {_array deleteAt 0;};
while {count _array > 0 && {(_array # (count _array - 1)) isEqualTo 34}} do {_array deleteAt (count _array - 1);};

for "_i" from 0 to (count _array)-1 do {
	_sel = _array select _i;
	if (_sel isEqualTo 96) then {
		_array set[_i,39];
	};
};

_array = toString(_array);
_array = call compile format["%1", _array];
if (isNil "_array" || {!(_array isEqualType [])}) then {
	diag_log format["[ERREUR] fn_mresToArray: données corrompues, retour [] - input: %1", _this # 0];
	_array = [];
};
_array;