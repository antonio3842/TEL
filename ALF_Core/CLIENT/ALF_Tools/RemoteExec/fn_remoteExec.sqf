/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
if (isServer) exitWith {};

private _v = params[
	["_iJXa4aiozbpCoNyr54ci", "", [""]],
	["_target"],
	["_functionName", "", [""]],
	["_isCall", nil, [false]],
	["_isCommand", nil, [false]],
	["_arguments", [], [[]]]
];

if !(_v) exitWith {};

if (_target isEqualTo 2) then {
	[_iJXa4aiozbpCoNyr54ci, _functionName, _isCall, _isCommand, _arguments] remoteExec["ALFTools_Server_fnc_receiveRemoteExec", 2];
}else{
	[_iJXa4aiozbpCoNyr54ci, _target, _functionName, _isCall, _isCommand, _arguments, true] remoteExec["ALFTools_Server_fnc_remoteExec", 2];
};
