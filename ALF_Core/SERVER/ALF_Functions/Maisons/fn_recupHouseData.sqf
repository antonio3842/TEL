
// /*
// 	File: fn_recupSonnette.sqf
// 	Author: ALF NiiRoZz
// */

/*
private _batiment = param [0,objnull];
private _pos = param [1,[0,0,0]];
private _type = param [2,""];


if (isNull _batiment) then 
{
	_batiment = (nearestTerrainObjects [_pos, [], 15] select {_type in str _x}) # 0;
};
if (isnil {_batiment}) exitwith {};


missionNamespace setVariable ["ALF_House_Data",[(_batiment getVariable ["house_owner",[]]),(_batiment getVariable ["sonnette",0]),(_batiment getVariable ["alarm_gendarmerie",0])],remoteExecutedOwner];
// };
*/

// /*
// 	File: fn_recupSonnette.sqf
// 	Author: ALF NiiRoZz
// */
private _batiment = param [0,objnull];
private _pos = param [1,[0,0,0]];
private _type = param [2,""];


if (isNull _batiment) then
{
	_batiment = (nearestTerrainObjects [_pos, [], 15] select {_type in str _x}) # 0;
};
if (isnil {_batiment}) exitwith {};

private _houseId = _batiment getVariable ["house_id", ""];
private _hasSecurity = 0;
if (_houseId isNotEqualTo "") then {
	private _secResult = [format["SELECT id FROM mobiliers WHERE id_house='%1' AND classname='M_ALF_Security' LIMIT 1", _houseId], 2] call ALF_Server_fnc_asyncCall;
	if (count _secResult > 0) then { _hasSecurity = 1; };
};

missionNamespace setVariable ["ALF_House_Data",[(_batiment getVariable ["house_owner",[]]),(_batiment getVariable ["sonnette",0]),(_batiment getVariable ["alarm_gendarmerie",0]),_hasSecurity],remoteExecutedOwner];
// };