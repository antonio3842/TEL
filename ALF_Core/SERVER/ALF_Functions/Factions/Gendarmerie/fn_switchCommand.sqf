/*
	File: fn_switchCommand.sqf
	Author : ALF Adam
*/
params [
	["_mode",false,[false]],
	["_unit",objNull,[objNull]]
];

if (isNull _unit) exitWith {};

if (_mode) then {
	
	private _nbrCo 		= count alf_GN_Command;
	private _nbrcoCo 	= 0; 

	{
		if ((alive _x) && (_x getVariable ["CopService",false])) then 
		{
			_nbrcoCo = _nbrcoCo + 1;
		}else 
		{
			alf_GN_Command deleteAt (alf_GN_Command find _x);
		};
		
	} forEach alf_GN_Command;

	private _checkCo = if (_nbrcoCo >= 2) then {false}else{true};

	if !(_checkCo) exitWith {["COG", "Le nombre de commandement est déjà au maximum (2 max) !!", "danger"] remoteExec ["ALF_fnc_doMsg",_unit];};
	
	["COG",format["%1 prend le commandement.",name _unit]] call ALF_Server_fnc_doCopCall;
	alf_GN_Command pushBack _unit;
	
	[] remoteExecCall ["ALF_fnc_returnCommand",_unit];
} else {
	["COG",format["%1 quitte le commandement.",name _unit]] call ALF_Server_fnc_doCopCall;
	alf_GN_Command deleteAt (alf_GN_Command find _unit);
};