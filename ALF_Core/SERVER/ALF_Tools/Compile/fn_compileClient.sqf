/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
if !(isServer) exitWith {};
if (hasInterface) exitWith {};

private _v = params[
	["_prefix", "", [""]],
	["_functionName", "", [""]],
	["_function", "", [""]]
];

// if !(_v) exitWith {};
// private _debugMode = getMissionConfigValue["ALF_DebugMode", 0];
// private _finalFunctionName = format["%1_fnc_%2",_prefix, _functionName];
// if (_debugMode isEqualTo 1) then {
// 	missionNamespace setVariable[_finalFunctionName,(compile _function), true];
// } else {
// 	missionNamespace setVariable[_finalFunctionName,(compileFinal _function), true];
// };

// diag_log format["==> [ALF_Core] CLIENT Function : %1 Initialized", _finalFunctionName];


if !(_v) exitWith {};
private _debugMode = getMissionConfigValue["ALF_DebugMode", 0];
private _finalFunctionName = format["%1_fnc_%2",_prefix, _functionName];

// Le 3ème paramètre TRUE rend la variable globale et la synchronise avec tous les clients
if (_debugMode isEqualTo 1) then
{
	missionNamespace setVariable[_finalFunctionName,(compile _function), true];
} else
{
	missionNamespace setVariable[_finalFunctionName,(compileFinal _function), true];
};

diag_log format["==> [ALF_Core] CLIENT Function : %1 Initialized", _finalFunctionName];