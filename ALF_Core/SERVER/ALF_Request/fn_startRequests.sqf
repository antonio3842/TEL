/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
/*
if (!isServer) exitWith {false};
if (hasInterface) exitWith {false};


private _serverStatus = ("ALF_Core" callExtension "ALF_API_GetServerStatus");
if !(_serverStatus isEqualTo "STOPPED") exitWith {
	diag_log "[ALF_Core - API] Starting stopped - DLL Server already started";
	true
};

private _startRet = ("ALF_Core" callExtension "ALF_API_Start");
if !(_startRet isEqualTo "STARTED") exitWith {
	diag_log ["[ALF_Core - API] Starting stopped - DLL Server can't load | %1", _startRet];
	false
};


addMissionEventHandler["ExtensionCallback", {
	params["_name", "_uniqueID", "_data"];

	if (_name isEqualTo "ALF_API_CallBack_Error") exitWith {
		serverNamespace setVariable[format["ALF_API_CallBackVAR_%1",_uniqueID], "ALF-ERROR"];
	};

	if (_name isEqualTo "ALF_API_CallBack_NewRequest") exitWith {
		private _intID = parseNumber(_uniqueID);
		[_intID, _data] spawn ALFCore_fnc_checkRequests;

		diag_log format["[ALF_Core - API Debug] New request | %1 | %2", _intID, _data];
	};

	if !(_name in ["ALF_API_CallBack_GET", "ALF_API_CallBack_POST"]) exitWith {};
	serverNamespace setVariable [format["ALF_API_CallBackVAR_%1",_uniqueID], _data];
}];


//[] spawn ALFCore_fnc_checkRequests;

diag_log "[ALF_Core - API] Server started";
true;
*/