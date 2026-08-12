// File: server\vehicle\fn_spawnRentedCar.sqf
if !(isServer) exitWith {};

params [
  ["_uid", "", [""]],
  ["_unit", objNull, [objNull]],
  ["_markerOrKey", "", [""]],
  ["_classname", "", [""]]
];

if (_uid isEqualTo "" || {isNull _unit} || {_markerOrKey isEqualTo ""} || {_classname isEqualTo ""}) exitWith {};

private _map = missionNamespace getVariable ["ALF_RentCar_SpawnByNPC", createHashMap];
private _markerName = _map getOrDefault [_markerOrKey, ""];
if (_markerName isEqualTo "") then { _markerName = _markerOrKey; };

if (_markerName isEqualTo "" || { !(_markerName in allMapMarkers) }) exitWith {
  ["INFO", format["Aucun spawn valide ('%1').", _markerOrKey], "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

private _pos = getMarkerPos _markerName;

if (surfaceIsWater _pos) then {
  private _near = [_pos, 5, 50, 5, 0, 0.2, 0] call BIS_fnc_findSafePos;
  if (!surfaceIsWater _near) then { _pos = _near; };
};

private _veh = _classname createVehicle [0,0,1000];
_veh allowDamage false;
_veh setPosATL _pos;
_veh setVectorUp (surfaceNormal _pos);
_veh setDir (markerDir _markerName);
_veh lock 2;

{
  if (_x != _veh && {(_x distance _veh) < 3}) exitWith {
    _veh setPosATL (_veh modelToWorld [0,3,0]);
  };
} forEach (nearestObjects [_veh, ["Car","Truck"], 5]);

_veh allowDamage true;

[_veh] remoteExecCall ["ALF_fnc_addVehicle2Chain", _unit];
[_uid, _veh, 1] call ALF_Server_fnc_keyManagement;
_veh setVariable ["vehicle_info_owners", ["", _uid], true];
_veh setVariable ["ALF_rental", ["car", _markerName, serverTime], true];

["INFO", "Ton véhicule t'attend au parking.", "success"] remoteExec ["ALF_fnc_doMsg", _unit];
