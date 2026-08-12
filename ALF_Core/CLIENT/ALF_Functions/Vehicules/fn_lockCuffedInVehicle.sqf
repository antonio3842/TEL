/*
    File: fn_lockCuffedInVehicle.sqf
    Runs on: CLIENT (player is the cuffed target)
    Args:
      0: VEHICLE <OBJECT>
    Ensures:
      - Force the **front passenger** seat (cargo index 0 when available).
      - No seat switching, no self-exit.
      - Camera remains free.
      - Server-side vehicle & vehicle-EH enforcement to cancel exits.
*/

params [
    ["_veh", objNull, [objNull]]
];
if (isNull _veh) exitWith {};

private _u = player;
if (!alive _u) exitWith {};

// mark state
_u setVariable ["ALF_cuffedInVeh", true, false];
_u setVariable ["ALF_cuffedVehRef", _veh, false];

// === Choose target seat: try CARGO index 0 (front passenger on most cars). If it doesn't exist, fall back to our current cargo index. ===
private _targetCargoIdx = 0;
private _cargoCount = getNumber (configFile >> "CfgVehicles" >> typeOf _veh >> "transportSoldier");
if (_cargoCount <= 0) then { _targetCargoIdx = -1; }; // no cargo seats (rare)

// Move unit into target seat (exact proxy), unlocking/locking only that seat server-side to avoid race conditions.
[_veh, _targetCargoIdx] remoteExecCall [{
    params ["_veh","_idx"];
    if (isNull _veh) exitWith {};
    private _cargoCount = getNumber (configFile >> "CfgVehicles" >> typeOf _veh >> "transportSoldier");
    // unlock the intended seat momentarily (if valid)
    if (_idx >= 0 && {_idx < _cargoCount}) then { _veh lockCargo [_idx, false]; };
}, 2];

uiSleep 0;
if (_targetCargoIdx >= 0) then {
    _u moveInCargo [_veh, _targetCargoIdx];
} else {
    // fallback: any cargo
    _u moveInCargo _veh;
};

// store final assigned index
private _roleNow = assignedVehicleRole _u; // ["CARGO", idx]
private _idxFinal = -1;
if ((count _roleNow) > 1 && { (_roleNow select 0) isEqualTo "CARGO" }) then { _idxFinal = _roleNow select 1; };
_u setVariable ["ALF_cuffedSeat", _idxFinal, false];

// === Vehicle-wide locks on SERVER ===
[_veh] remoteExecCall [{
    params ["_veh"];
    if (isNull _veh) exitWith {};
    // lock everything
    _veh lockDriver true;
    { _veh lockTurret [_x, true]; } forEach (allTurrets _veh);
    private _cargoCount = getNumber (configFile >> "CfgVehicles" >> typeOf _veh >> "transportSoldier");
    for "_i" from 0 to (_cargoCount - 1) do { _veh lockCargo [_i, true]; };

    // Add a vehicle GetOut EH that denies exit for the cuffed unit (server-authoritative)
    if (isNil { _veh getVariable "ALF_cuffedVeh_EH_GetOut" }) then {
        private _ehId = _veh addEventHandler ["GetOut", {
            params ["_veh", "_position", "_unit", "_turretPath"];
            // If that unit is flagged as cuffed-in-veh, move it back immediately
            if (_unit getVariable ["ALF_cuffedInVeh", false]) then {
                private _idx = _unit getVariable ["ALF_cuffedSeat", -1];
                if (_idx >= 0) then { _unit moveInCargo [_veh, _idx]; }
                else { _unit moveInCargo _veh; };
            };
        }];
        _veh setVariable ["ALF_cuffedVeh_EH_GetOut", _ehId, true];
    };
}, 2];

// === Client-side enforcement ===

// Seat change -> snap back to passenger seat (idxFinal)
private _ehSeat = _u addEventHandler ["SeatSwitchedMan", {
    params ["_unit", "_newVeh", "_oldVeh"];
    if !(_unit getVariable ["ALF_cuffedInVeh", false]) exitWith {};
    private _veh = _unit getVariable ["ALF_cuffedVehRef", objNull];
    if (isNull _veh || { !(_newVeh isEqualTo _veh) }) exitWith {};
    private _idx = _unit getVariable ["ALF_cuffedSeat", -1];
    [_unit, _veh, _idx] spawn {
        params ["_u","_v","_idx"];
        uiSleep 0;
        if (_idx >= 0) then { _u moveInCargo [_v, _idx]; } else { _u moveInCargo _v; };
    };
}];

// Wrong get-in role -> snap to passenger
private _ehGetIn = _u addEventHandler ["GetInMan", {
    params ["_unit", "_role", "_veh2", "_turretPath"];
    if !(_unit getVariable ["ALF_cuffedInVeh", false]) exitWith {};
    private _veh = _unit getVariable ["ALF_cuffedVehRef", objNull];
    if (isNull _veh || { !(_veh2 isEqualTo _veh) }) exitWith {};
    if !(_role isEqualTo "cargo") then {
        private _idx = _unit getVariable ["ALF_cuffedSeat", -1];
        [_unit, _veh, _idx] spawn {
            params ["_u","_v","_idx"];
            uiSleep 0;
            if (_idx >= 0) then { _u moveInCargo [_v, _idx]; } else { _u moveInCargo _v; };
        };
    };
}];

// If forced out client-side -> attempt instant return
private _ehGetOut = _u addEventHandler ["GetOutMan", {
    params ["_unit", "_role", "_veh2", "_turretPath"];
    if !(_unit getVariable ["ALF_cuffedInVeh", false]) exitWith {};
    private _veh = _unit getVariable ["ALF_cuffedVehRef", objNull];
    if (isNull _veh) exitWith {};
    private _idx = _unit getVariable ["ALF_cuffedSeat", -1];
    [_unit, _veh, _idx] spawn {
        params ["_u","_v","_idx"];
        uiSleep 0;
        if (_idx >= 0) then { _u moveInCargo [_v, _idx]; } else { _u moveInCargo _v; };
    };
}];

// EachFrame failsafe to keep exact seat index
private _ehEach = addMissionEventHandler ["EachFrame", {
    private _u = player;
    if !(_u getVariable ["ALF_cuffedInVeh", false]) exitWith {};
    private _veh = _u getVariable ["ALF_cuffedVehRef", objNull];
    if (isNull _veh) exitWith {};
    if (!(_u in _veh)) exitWith {
        private _idx = _u getVariable ["ALF_cuffedSeat", -1];
        if (_idx >= 0) then { _u moveInCargo [_veh, _idx]; } else { _u moveInCargo _veh; };
    };
    private _idxAllowed = _u getVariable ["ALF_cuffedSeat", -1];
    private _role = assignedVehicleRole _u;
    if ((count _role) == 0) exitWith {};
    if !((_role select 0) isEqualTo "CARGO") exitWith {
        if (_idxAllowed >= 0) then { _u moveInCargo [_veh, _idxAllowed]; } else { _u moveInCargo _veh; };
    };
    if (_idxAllowed >= 0 && {(_role select 1) != _idxAllowed}) then {
        _u moveInCargo [_veh, _idxAllowed];
    };
}];

_u setVariable ["ALF_eh_ids", [_ehSeat, _ehGetIn, _ehGetOut, _ehEach], false];
