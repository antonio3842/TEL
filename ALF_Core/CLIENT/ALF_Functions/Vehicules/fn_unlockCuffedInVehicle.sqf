/*
    File: fn_unlockCuffedInVehicle.sqf
    Runs on: CLIENT (player is the previously cuffed target)
*/
params [["_u", player, [objNull]]];
if (isNull _u) exitWith {};

private _veh = _u getVariable ["ALF_cuffedVehRef", objNull];

// remove client EHs + EachFrame
private _ehs = _u getVariable ["ALF_eh_ids", []];
if ((count _ehs) > 0) then {
    private _seat = _ehs param [0, -1];
    private _gin  = _ehs param [1, -1];
    private _gout = _ehs param [2, -1];
    private _each = _ehs param [3, -1];
    if (_seat >= 0) then { _u removeEventHandler ["SeatSwitchedMan", _seat]; };
    if (_gin  >= 0) then { _u removeEventHandler ["GetInMan", _gin]; };
    if (_gout >= 0) then { _u removeEventHandler ["GetOutMan", _gout]; };
    if (_each >= 0) then { removeMissionEventHandler ["EachFrame", _each]; };
};
_u setVariable ["ALF_eh_ids", nil, false];

// server: unlock, and remove vehicle GetOut EH
if (!isNull _veh) then {
    [_veh] remoteExecCall [{
        params ["_veh"];
        private _cargoCount = getNumber (configFile >> "CfgVehicles" >> typeOf _veh >> "transportSoldier");
        for "_i" from 0 to (_cargoCount - 1) do { _veh lockCargo [_i, false]; };
        _veh lockDriver false;
        { _veh lockTurret [_x, false]; } forEach (allTurrets _veh);
        // remove our GetOut EH if present
        private _ehId = _veh getVariable ["ALF_cuffedVeh_EH_GetOut", -1];
        if (_ehId isEqualType 0 && {_ehId >= 0}) then {
            _veh removeEventHandler ["GetOut", _ehId];
        };
        _veh setVariable ["ALF_cuffedVeh_EH_GetOut", nil, true];
    }, 2];
};

// clear & restore
_u setVariable ["ALF_cuffedInVeh", false, false];
_u setVariable ["ALF_cuffedVehRef", objNull, false];
_u setVariable ["ALF_cuffedSeat", nil, false];
_u forceWalk false;
_u setAnimSpeedCoef 1;
