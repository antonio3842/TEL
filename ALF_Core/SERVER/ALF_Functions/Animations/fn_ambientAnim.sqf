/*
    File: fn_ambientAnim.sqf
    Author: NiiRoZz

    Description:
    Some information in local client for his position
*/
params [["_pnj",objNull,[objNull]]];
if (isNull _pnj) exitWith {};

private _dir = getDir _pnj;
_pnj setVariable ["BIS_enableRandomization", false];
_pnj setVariable ["BIS_fnc_animalBehaviour_disable", true];

[_pnj,"ALL"] remoteExecCall ["disableAI",_pnj];
_pnj allowDamage false;
_pnj removeAllEventHandlers "HandleDamage";

private _objet_Ancre = "Land_File1_F" createVehicle [0,0,0];
_objet_Ancre setPosATL (getPosATL _pnj);
_objet_Ancre setdir (getdir _pnj);
[_objet_Ancre] remoteExecCall ["hideObjectGlobal",2];

sleep 0.5;

_pnj attachTo [_objet_Ancre, [0,0,0]];
[_objet_Ancre,true] remoteExecCall ["enableDynamicSimulation",2];