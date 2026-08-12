/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
params [
	["_target", -1, [-1]], // 0 = Everyone, 1 = Server, 2 = Client
	["_sGroup", "", [""]],
	["_sClass", "", [""]],
	["_sFunction", "", [""]],
	["_execPostInit", false, [false]]
];

if (hasInterface) exitWith {diag_log "[ALF_Core]: ERROR: Running on client"};
if !(isServer) exitWith {diag_log "[ALF_Core]: ERROR: Not on server"};
if !(isDedicated) exitWith {diag_log "[ALF_Core]: ERROR: Not dedicated"};

private _debugMode = getMissionConfigValue["ALF_DebugMode", 0];
ALF_PostInit_Functions = [];

if ((_debugMode isEqualTo 0) && ALF_Function_firstLoaded) exitWith {
	[parseText "<t color='#ff6800' size='1.5' font='PuristaBold'>→ COMPILATION ←</t><br/><t size='1.2' color='#ab0000' font='PuristaBold'>Impossible d'éffectuer cela"] remoteExec["hint",0];
};

private _targetN = switch(_target) do {
	case 1: {"Serveur"};
	case 2: {"Client"};
	default {"Serveur & Client"};
};

private _sGN = _sGroup;
private _sCN = _sClass;
private _sFN = _sFunction;

if (_sGroup == "") then {_sGN = "Non défini";};
if (_sClass == "") then {_sCN = "Non définie";};
if (_sFunction == "") then {_sFN = "Non définie";};

if ((_debugMode isEqualTo 1) && ALF_Function_firstLoaded) then {
	[parseText format["<t color='#ff6800' size='1.5' font='PuristaBold'>→ COMPILATION ←</t><br/><t font='PuristaBold'>Cible :</t> %4<br/><t font='PuristaBold'>Groupe :</t> %1<br/><t font='PuristaBold'>Classe :</t> %2<br/><t font='PuristaBold'>Function :</t> %3<br/><t size='1.2' color='#ebe000'>En cours ...", _sGN, _sCN, _sFN, _targetN]] remoteExec["hint",0];
};

/* -- SERVER Functions -- */
if ((_target isEqualTo -1) || (_target isEqualTo 0) || (_target isEqualTo 1)) then {

	diag_log "[ALF_Core]: Start compile SERVER functions";
	
	_functionClass = (configFile >> "ALF_SERVER_CfgFunctions");
	{
		private _tag = getText (_x >> "tag");
		if ((_sGroup != "") && ((configName _x) isNotEqualTo _sGroup)) then {continue};
		private _groupName = configName _x;
		{
			if ((_sClass != "") && ((configName _x) isNotEqualTo _sClass)) then {continue};
			private _filePath = getText(_x >> "file");
			private _cTag = getText(_x >> "cTag");
			private _newTag = _tag;
			if (_cTag != "") then {
				_newTag = format["%1_%2",_tag,_cTag];
			};
			private _className = format["%1_%2",_groupName, (configName _x)];

			{
				if ((_sFunction != "") && ((configName _x) isNotEqualTo _sFunction)) then {continue};

				private _functionName = configName _x;
				private _fileName = format["fn_%1.sqf", _functionName];
				private _FfilePath = format["%1\%2", _filePath,_fileName];
				private _finalFunctionName = format["%1_fnc_%2",_newTag, _functionName];
				private _tempFileName = ("ALF_Core" callExtension ["ALF_compileFileContent", [_FfilePath, _functionName, _className]])#0;

				if (_tempFileName find "ERROR" isEqualTo 0) then {
					continue;
					diag_log format["==> [ALF_Core] SERVER Function : %1 ERROR", _finalFunctionName];
				};

				private _fileProcessPath = format["\ALF_Core\ALF_Temp\%1",_tempFileName];
				private _procecedContent = (preprocessFileLineNumbers _fileProcessPath);

				if (_debugMode isEqualTo 1) then {
					missionNamespace setVariable[_finalFunctionName,(compile _procecedContent)];
				} else {
					missionNamespace setVariable[_finalFunctionName,(compileFinal _procecedContent)];
				};

				if (getNumber(_x >> "postInit") isEqualTo 1) then {
					ALF_PostInit_Functions pushBack _fileProcessPath;
				};

				diag_log format["==> [ALF_Core] SERVER Function : %1 Initialized", _finalFunctionName];
			}foreach ("true" configClasses _x);
		}forEach ("isClass _x" configClasses _x);
	}forEach ("isClass _x" configClasses _functionClass);

	diag_log "[ALF_Core]: SERVER functions compiled";

};

/* -- CLIENT Functions -- */
if ((_target isEqualTo -1) || (_target isEqualTo 0) || (_target isEqualTo 2)) then {

	diag_log "[ALF_Core]: Start compile CLIENT functions";

	private _functionClass = (configFile >> "ALF_CLIENT_CfgFunctions");
	{
		private _tag = getText (_x >> "tag");
		if ((_sGroup != "") && ((configName _x) isNotEqualTo _sGroup)) then {continue};
		private _groupName = configName _x;
		{
			if ((_sClass != "") && ((configName _x) isNotEqualTo _sClass)) then {continue};

			private _filePath = getText(_x >> "file");
			private _cTag = getText(_x >> "cTag");
			private _newCTag = _tag;
			if (_cTag != "") then {
				_newCTag = format["%1_%2",_tag,_cTag];
			};
			private _className = format["%1_%2",_groupName, (configName _x)];

			{
				if ((_sFunction != "") && ((configName _x) isNotEqualTo _sFunction)) then {continue};
				private _functionName = configName _x;
				private _fileName = format["fn_%1.sqf", _functionName];
				private _FfilePath = format["%1\%2", _filePath,_fileName];
				private _tempFileName = ("ALF_Core" callExtension ["ALF_compileFileContent", [_FfilePath, _functionName, _className]])#0;

				if (_tempFileName find "ERROR" isEqualTo 0) then {
					diag_log format["==> [ALF_Core] CLIENT Function : %1 ERROR", _functionName];
					diag_log format["==> [ALF_Core] CLIENT Function : %1 ERROR", _FfilePath];
					diag_log format["==> [ALF_Core] CLIENT Function : %1 ERROR", _className];
					diag_log format["==> [ALF_Core] CLIENT Function : %1 ERROR", _tempFileName];
					continue;
				};
				
				private _procecedContent = (preprocessFileLineNumbers format["\ALF_Core\ALF_Temp\%1",_tempFileName]);

				[_newCTag, _functionName, _procecedContent] call ALFTools_Server_fnc_compileClient;
			}foreach ("true" configClasses _x);
		}forEach ("isClass _x" configClasses _x);
	}forEach ("isClass _x" configClasses _functionClass);

	diag_log "[ALF_Core]: CLIENT functions compiled";

};

if (_debugMode isEqualTo 1 && ALF_Function_firstLoaded && _execPostInit) then {
	{
		[] call (compile (preprocessFileLineNumbers _x));
	}forEach ALF_PostInit_Functions;
	diag_log "[ALF_Core]: POST INIT executed";

	[parseText format["<t color='#ff6800' size='1.5' font='PuristaBold'>→ COMPILATION ←</t><br/><t font='PuristaBold'>Cible :</t> %4<br/><t font='PuristaBold'>Groupe :</t> %1<br/><t font='PuristaBold'>Classe :</t> %2<br/><t font='PuristaBold'>Function :</t> %3<br/><t size='1.2' color='#7cff00' font='PuristaBold'>Terminée", _sGN, _sCN, _sFN, _targetN]] remoteExec["hint",0];
};
