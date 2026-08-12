/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
if !(isServer) exitWith {};

private _v = params[
	["_scriptToken", "", [""]],
	"_target",
	["_functionName", "", [""]],
	["_isCall", nil, [false]],
	["_isCommand", nil, [false]],
	["_arguments", nil, [[]]],
	"_fromClient"
];

if !(_v) exitWith {};

/* -- Check allowed remoteExec -- */
private _config = (configFile >> "Config_ALF_RemoteExecs");
private _loggedTargets = getArray(_config >> "loggedTargets");
private _exceptionToken = getArray(_config >> "exceptionsToken");
private _skip = false;
private _theConfig = "ServerRemotes";

if (!isNil "_fromClient" && _fromClient) then {
	_theConfig =  "ClientsRemotes";
};

if (_scriptToken in _exceptionToken) then {
	/* -- Exception token -- */
	_skip = true;
};

private _clearToken = [_scriptToken] call ALFTools_Server_fnc_getToken;
if (!(isClass (_config >> "ServerRemotes" >> _clearToken)) && (!_skip)) exitWith {
	/* -- Token does not exist -- */
};

private _postConfig = (_config >> "ServerRemotes" >> _clearToken);
private _allowedTargets = getArray(_postConfig >> "allowedRemoteExecs");
private _allowedCommands = getArray(_postConfig >> "allowedCommands");
if  (((_isCommand && !(_functionName in _allowedCommands)) || (!(_isCommand) && !(_functionName in _allowedTargets))) && (!_skip)) exitWith {
	/* -- Remote not allowed -- */
};

if (_target in _loggedTargets) then {
	/* -- Target is logged -- */
};

/* -- Execute remoteExec -- */
[_functionName, _isCall, _isCommand, _arguments] remoteExec["ALFTools_Client_fnc_receiveRemoteExec", _target];
