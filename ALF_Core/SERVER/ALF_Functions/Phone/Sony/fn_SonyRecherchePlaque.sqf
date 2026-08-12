/*
	File: fn_SonyRecherchePlaque.sqf
	Author: ALF Team

	This file is for Nanou's HeadlessClient.

	Description:
*/
private["_plaque","_unit","_plaquefinal","_query","_queryResult","_classname","_pid","_insure","_query2","_queryResult2","_nameplayer","_plaquetexte"];
_plaque = _this select 0;
_unit = _this select 1;

if(_plaque isEqualTo "" OR isNull _unit) exitWith {};

_query = format["SELECT classname, pid , insure FROM vehicles WHERE plate='%1'",toupper _plaque];
_queryResult = [_query,2] call ALF_Server_fnc_asyncCall;

private _exit = false;

if((count _queryresult) isEqualTo 0) exitWith 
{	
	private _info = [];

	if ((count ALF_LAPOSTE_CARS) > 0) then 
	{
		{
			_x params["_plaquePoste", "_playerPoste"];
			if (_plaquePoste isEqualTo _plaque) exitWith {_info = [_plaquePoste, _playerPoste]}
		
		} forEach ALF_LAPOSTE_CARS;
	};

	if ((count _info) isEqualTo 0) exitWith {["Gendarmerie","Aucun véhicule n'est attribué à cette plaque.","warning",false] remoteExec ["ALF_fnc_doMsg",_unit]; _exit = true};

	_classname 		= "La Poste"; 
	_pid	   		= getPlayerUID (_info select 1);
	_plaqueposte 	= _info select 0;
	_nameplayer 	= name (_info select 1); 
	_insure	    	= 1;	

	[_plaque,_classname,_nameplayer,_insure] remoteExec ["ALF_fnc_SonyResultPlaque",_unit];
};

if (_exit) exitWith {["Gendarmerie","Aucun véhicule n'est attribué à cette plaque.","warning",false] remoteExec ["ALF_fnc_doMsg",_unit];};

_classname = _queryResult select 0;
_pid = _queryResult select 1;
_insure = _queryResult select 2;

_query2 = format["SELECT name FROM players WHERE playerid='%1'",_pid];
_queryResult2 = [_query2,2] call ALF_Server_fnc_asyncCall;
if((count _queryresult) isEqualTo 0) exitWith {};

_nameplayer = _queryResult2 select 0;

[_plaque,_classname,_nameplayer,_insure] remoteExec ["ALF_fnc_SonyResultPlaque",_unit];