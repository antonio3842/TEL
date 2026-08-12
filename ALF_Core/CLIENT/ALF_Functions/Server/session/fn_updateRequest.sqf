#include "\ALF_Client\script_macros.hpp"
/*
	File: fn_updateRequest.sqf
	Author: ALF TEAM
*/


private _packet = [getPlayerUID player,life_cash];
private _array = [];

private "_varName";
private _licencesC = ["CLASSES", ["Licenses"]] call ALFTools_Client_Config_fnc_getConfig;
{
	private _varnameConfig = ["STRING", ["Licenses", _x, "variable"]] call ALFTools_Client_Config_fnc_getConfig;
    _varname = format["license_%1", _varnameConfig];

	private _levelConfigValue = missionNamespace getVariable [_varname, false];

	_array pushBack [_varName,_levelConfigValue];
} forEach _licencesC;

profileNamespace setVariable ["MRPV2_Inventaire_Joueur_Profile",getUnitLoadout player];

_packet pushBack _array; //2
_packet pushBack ([player] call ALF_fnc_saveGear); //3
_packet pushBack [life_hunger,life_thirst,life_drunk,(damage player)]; //4
_packet pushBack (life_is_alive); //5
_packet pushBack (getPosATL player); //6
_packet pushBack [alf_deseases,alf_medecine,alf_vaccins]; //7

_packet remoteExecCall ["ALF_Server_fnc_updateRequest",2];
