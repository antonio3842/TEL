/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
if (isServer) exitWith {};

private _v = params[
	["_functionName", "", [""]],
	["_isCall", nil, [false]],
	["_isCommand", nil, [false]],
	["_arguments", nil, [[]]]
];

if !(_v) exitWith {};

if (_isCommand) exitWith {
	switch(_functionName) do {
		default {};
	};
};

if (_isCall) then {
	_arguments call (missionNamespace getVariable[_functionName, {}]);
}else{
	_arguments spawn (missionNamespace getVariable[_functionName, {}]);
};
