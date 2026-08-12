/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.



#define ALF_STATUSCODE_FORBIDEN 403
#define ALF_STATUSCODE_UNAUTHORIZED 401
#define ALF_STATUSCODE_NOTFOUND 404
#define ALF_STATUSCODE_OK 200
#define ALF_STATUSCODE_ERROR 500
#define ALF_STATUSCODE_BADREQUEST 400

if (!isServer) exitWith {};
if (hasInterface) exitWith {};
if !(canSuspend) exitWith {
	_this spawn ALFCore_fnc_checkRequests;
};

if !(("ALF_Core" callExtension "ALF_API_GetServerStatus") isEqualTo "STARTED") exitWith {
	diag_log "[ALF_Core - API] ERROR - No server found";
};
private _config = (configFile >> "Config_ALF_API" >> "Requests");

private _v = params[
	["_requestID", -1, [-1]],
	["_dataReq", "", [""]]
];

if !(_v) exitWith {};
private _reqInfos = (parseSimpleArray _dataReq);
private _j = _reqInfos params[
		["_method", "", [""]],
		["_function", "", [""]],
		["_allArguments", "", [""]],
		"_ToArray"
];

diag_log format["[ALF_Core - API Debug] Check request | %1 | %2 | %3", _method, _function, _allArguments];

if !(_j) exitWith {};
private _arrayArguments = (parseSimpleArray _allArguments);
if !(isClass (_config >> _method >> _function)) exitWith {
	// -- Send error -- //
	"ALF_Core" callExtension["ALF_API_SendError", [_requestID, ALF_STATUSCODE_NOTFOUND, "La fonction indiquée n'existe pas",_ToArray]];
};

private _retVal = "0";
private _aConfig = (_config >> _method >> _function);
private _condition = getText(_aConfig >> "condition");

if !(_arrayArguments call compile _condition) exitWith {
	"ALF_Core" callExtension["ALF_API_SendError", [_requestID, ALF_STATUSCODE_FORBIDEN, "Les conditions ne sont pas remplies pour accéder à cette fonction",_ToArray]];
};

private _statement = getText(_aConfig >> "statement");
_retVal = (_arrayArguments call compile _statement);
diag_log format["[ALF_Core - API Debug] Return value | %1", _retVal];

_retVal params[
	["_isExecuted", false, [false]],
	"_value",
	["_isNotValueString", false, [false]],
	["_customReturn", false, [false]]
];

private _finalRetVal = format["{Executed: %1, value: '%2'}", _isExecuted, _value];

if (_isNotValueString) then {
	_finalRetVal = format["{Executed: %1, value: %2}", _isExecuted, _value];
};

if (_ToArray) then {
	_finalRetVal = format["[['Executed',%1], ['value', %2]]", _isExecuted, _value];
};

if (_customReturn) then {
	_finalRetVal = _value;
};

diag_log format["[ALF_Core - API Debug] Finale return value | %1", _finalRetVal];
//- Send Result -- //
"ALF_Core" callExtension["ALF_API_SendResult", [_requestID, parseText(_finalRetVal)]];

*/