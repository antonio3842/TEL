// File: server\vehicle\fn_deleteRentedCar.sqf
if !(isServer) exitWith {};

params [
  ["_uid", "", [""]],
  ["_unit", objNull, [objNull]]
];

if (_uid isEqualTo "" || {isNull _unit}) exitWith {};

private _veh = objNull;

if (!isNull objectParent _unit) then {
  _veh = objectParent _unit;
} else {
  private _cands = nearestObjects [_unit, ["Car","Truck"], 15];
  {
    private _tag = _x getVariable ["ALF_rental", []];
    private _own = _x getVariable ["vehicle_info_owners", ["",""]];
    if ((count _tag) > 0 && {_tag select 0 isEqualTo "car"} && {_own select 1 isEqualTo _uid}) exitWith {
      _veh = _x;
    };
  } forEach _cands;
};

if (isNull _veh || {!alive _veh}) exitWith {
  ["INFO","Aucun véhicule de location à supprimer.", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

private _rental = _veh getVariable ["ALF_rental", []];
if ((count _rental) < 1 || {(_rental select 0) != "car"}) exitWith {
  ["INFO","Ce véhicule n’est pas une location ALF (car).", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

private _owners = _veh getVariable ["vehicle_info_owners", ["",""]];
if ((_owners param [1,""]) != _uid) exitWith {
  ["INFO","Tu n’es pas propriétaire de cette location.", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

if ((speed _veh) > 2) exitWith {
  ["INFO","Arrête complètement le véhicule avant de le rendre.", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

if (!isNull driver _veh) exitWith {
  ["INFO","Personne ne doit être au volant pour le rendre.", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

_veh engineOn false;
_veh lock 2;

[_uid, _veh, 0] call ALF_Server_fnc_keyManagement;
_veh setVariable ["ALF_rental_returned", [serverTime, "delete"], true];
_veh setVariable ["vehicle_info_owners", nil, true];

[_veh] spawn {
  params ["_v"];
  uiSleep 0.5;
  if (!isNull _v) then {
    _v allowDamage false;
    deleteVehicleCrew _v;
    deleteVehicle _v;
  };
};

["INFO","Véhicule rendu.", "success"] remoteExec ["ALF_fnc_doMsg", _unit];
