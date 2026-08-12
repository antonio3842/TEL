/*
	Projet : ALF
	Codeur : Mikael Libertis 
	File   : fn_laposte_returnHouse
*/ 

private _posVille 			= param[0, [], [[]]];
private _player				= param[1, objNull, [objNull]];
private _arrayHouse 		= nearestObjects [_posVille, ["House"], 500];
private _arrayHouseFinal	= [];
private _inConfig           = false;

{
	_inConfig = [typeOf _x] call ALF_Server_fnc_laposte_checkIsBuyHouse;
	if !(isNil "_inConfig") then {if (_inConfig) then {_arrayHouseFinal pushBack _x}};
	
} forEach _arrayHouse;

private _selectHouse = selectRandom _arrayHouseFinal;

_player setVariable["ALF_LaPosteHouse", _selectHouse, true];
