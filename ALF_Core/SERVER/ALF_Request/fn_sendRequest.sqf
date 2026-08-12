/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
/*
if !(isServer) exitWith {};
if (hasInterface) exitWith {};

private _v = params[
	["_ip", "", [""]],
	["_port", "", [""]],
	["_method", "", [""]],
	["_function", "", [""]],
	"_arguments"
];

if !(_v) exitWith {};

// -- Generate UniqueID --//
private _finalID = format["%1_ID_%2", _function, (random 10000)];
serverNamespace setVariable[format["ALF_API_CallBackVAR_%1", _finalID], nil];

// -- Convert Args -- //
private _finalString = [_arguments] call ALFCore_fnc_convertArgsRequest;
private _stringFnct = "";

_stringFnct = switch (_method) do {
	case "GET": {"ALF_API_GETRequest"};
	case "POST": {"ALF_API_POSTRequest"};
	default {""};
};

[_stringFnct,[_ip, _port, _function, _finalString, _finalID]] spawn {
	private _ret =  "ALF_Core" callExtension _this;
};

private _varName = format["ALF_API_CallBackVAR_%1", _finalID];

for "_i" from 0 to 1 step 0 do {
	if !((serverNamespace getVariable[_varName, ""]) isEqualTo "") exitWith {};
};
private _data = (serverNamespace getVariable[_varName, ""]);
_data;
*/