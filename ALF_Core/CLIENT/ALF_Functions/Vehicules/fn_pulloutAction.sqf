#include "\ALF_Client\script_macros.hpp"
/*
    File: fn_pulloutAction.sqf
    Author: Bryan "Tonic" Boardwine (adapté)

    Description:
    Pulls occupants out of a nearby stopped car.
    - Also calls unlockCuffedInVehicle on each target before pulling them out
      so they recover walking/running and controls.
*/
private ["_veh","_crew"];
_veh = _this select 0;
if (isNil "_veh" OR {isNull _veh}) exitWith {};
if (player distance _veh > 8) exitWith {};

_crew = crew _veh;

{
    if !(isNull _x) then {
        // d'abord déverrouiller leur état côté client
        [_x] remoteExecCall ["ALF_fnc_unlockCuffedInVehicle", _x];
        // puis les sortir (conserve votre logique existante si vous avez ALF_fnc_pullOutVeh)
        if (!isNil "ALF_fnc_pullOutVeh") then {
            [_x] remoteExecCall ["ALF_fnc_pullOutVeh", _x];
        } else {
            // fallback générique : éjecter proprement
            [_x] remoteExec [{
                params ["_unit"];
                private _veh = vehicle _unit;
                unassignVehicle _unit;
                moveOut _unit;
            }, _x];
        };
    };
} forEach _crew;
