#include "\ALF_Client\script_macros.hpp"
/*
    File: fn_putInCar.sqf
    Author: Bryan "Tonic" Boardwine (adapté)

    Description:
    Place the targeted unit into the nearest appropriate vehicle, then lock their
    controls/seats if they are cuffed, so they cannot drive, switch seats, or exit
    by themselves (camera still free).
*/

params [
    ["_unit", objNull, [objNull]],
    ["_vehOrClass", "", ["", objNull]]
];
if (isNull _unit) exitWith {};

// find nearest vehicle either by classname or object passed in
private _nearestVehicle = objNull;
switch (true) do {
    case (_vehOrClass isEqualType objNull): { _nearestVehicle = _vehOrClass; };
    case (_vehOrClass isEqualType ""): {
        if (_vehOrClass isEqualTo "") then {
            // find any nearby vehicle within 8m
            private _near = nearestObjects [player, ["Car","Tank","Ship","Air"], 8];
            if (count _near > 0) then { _nearestVehicle = _near select 0; };
        } else {
            private _near = nearestObjects [player, [_vehOrClass], 25];
            if (count _near > 0) then { _nearestVehicle = _near select 0; };
        };
    };
};
if (isNull _nearestVehicle) exitWith {
    ["INFO", "Aucun véhicule proche.", "danger"] spawn ALF_fnc_doMsg;
};

// detach and move target into vehicle (run on target's client)
detach _unit;
[_nearestVehicle] remoteExecCall ["ALF_fnc_moveIn", _unit];

// immediately lock seats/controls on target's client (prevents exit/seat switch/drive)
[_nearestVehicle] remoteExecCall ["ALF_fnc_lockCuffedInVehicle", _unit];
