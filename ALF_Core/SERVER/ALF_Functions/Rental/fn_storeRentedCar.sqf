// File: server\vehicle\fn_storeRentedCar.sqf
if !(isServer) exitWith {};

params [
  ["_uid", "", [""]],
  ["_unit", objNull, [objNull]],
  ["_markerOrKey", "", [""]],
  ["_veh", objNull, [objNull]]
];

if (_uid isEqualTo "" || {isNull _unit} || {_markerOrKey isEqualTo ""} || {isNull _veh}) exitWith {
  ["INFO","Paramètres invalides pour la restitution.", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

private _map = missionNamespace getVariable ["ALF_RentCar_SpawnByNPC", createHashMap];
private _markerName = _map getOrDefault [_markerOrKey, ""];
if (_markerName isEqualTo "") then { _markerName = _markerOrKey; };

if (_markerName isEqualTo "" || { !(_markerName in allMapMarkers) }) exitWith {
  ["INFO", format["Point de retour invalide ('%1').", _markerOrKey], "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

private _parkPos = getMarkerPos _markerName;
if (surfaceIsWater _parkPos) exitWith {
  ["INFO","Le point de retour est mal configuré (sur l’eau).", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

if (isNull _veh || {!alive _veh}) exitWith {
  ["INFO","Véhicule introuvable ou détruit.", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

if ((_veh distance2D _parkPos) > 50) exitWith {
  ["INFO","Approche-toi de la zone de parking pour ranger le véhicule.", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

if ((speed _veh) > 2) exitWith {
  ["INFO","Arrête complètement le véhicule avant de le ranger.", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

if (!isNull driver _veh) exitWith {
  ["INFO","Personne ne doit être au volant pour ranger le véhicule.", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

private _rental = _veh getVariable ["ALF_rental", []];
if ((count _rental) < 1 || {(_rental select 0) != "car"}) exitWith {
  ["INFO","Ce véhicule n’est pas une location ALF (car).", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

private _owners = _veh getVariable ["vehicle_info_owners", ["",""]];
if ((_owners param [1,""]) != _uid) exitWith {
  ["INFO","Tu n’es pas propriétaire de cette location.", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

_veh engineOn false;
_veh lock 2;

[_uid, _veh, 0] call ALF_Server_fnc_keyManagement;
_veh setVariable ["ALF_rental_returned", [serverTime, _markerName], true];
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

["INFO","Véhicule restitué, merci !", "success"] remoteExec ["ALF_fnc_doMsg", _unit];
