/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.



if !(isServer) exitWith {};
if (hasInterface) exitWith {};

private _v = params[
	["_arrayArgs", [], [[]]]
];

if (typeName _arrayArgs isEqualTo "STRING") exitWith { _arrayArgs };

private _totalString = "";
{
	_totalString = _totalString + format["'%1'", _x];

	if !(_forEachIndex isEqualTo ((count _arrayArgs) - 1) ) then {
		_totalString = _totalString + ",";
	};
}forEach _arrayArgs;

(format["[%1]", _totalString])
*/