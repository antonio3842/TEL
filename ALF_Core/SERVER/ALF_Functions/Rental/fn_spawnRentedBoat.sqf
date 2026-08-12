/*
  File: fn_spawnRentedBoat.sqf
  Author: ALF Core Assistant

  Appel (remoteExec): [uid, unit, markerOrKey, classname] remoteExecCall ["ALF_Server_fnc_spawnRentedBoat", 2];

  _markerOrKey peut être :
  - directement le NOM DU MARQUEUR (cas panneau)
  - OU une clé "nom PNJ" si tu utilises encore un mapping missionNamespace
*/

if !(isServer) exitWith {};

params [
  ["_uid", "", [""]],
  ["_unit", objNull, [objNull]],
  ["_markerOrKey", "", [""]],
  ["_classname", "", [""]]
];

if (_uid isEqualTo "" || {isNull _unit} || {_markerOrKey isEqualTo ""} || {_classname isEqualTo ""}) exitWith {};

private _map = missionNamespace getVariable ["ALF_RentBoat_SpawnByNPC", createHashMap];

// 1) essaie comme clé PNJ
private _markerName = _map getOrDefault [_markerOrKey, ""];
// 2) sinon, traite-le comme NOM DE MARQUEUR direct (cas panneau)
if (_markerName isEqualTo "") then { _markerName = _markerOrKey; };

// vérif existence du marqueur (sans markerExists)
if (_markerName isEqualTo "" || { !(_markerName in allMapMarkers) }) exitWith {
  ["INFO", format["Aucun spawn valide ('%1').", _markerOrKey], "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

private _pos = getMarkerPos _markerName;

// sécurité : si la position n’est pas sur l’eau, cherche autour
if !(surfaceIsWater _pos) then {
  private _near = [_pos, 5, 50, 1, 2, 20, 0] call BIS_fnc_findSafePos;
  if (surfaceIsWater _near) then { _pos = _near; };
};

// Création bateau
private _veh = _classname createVehicle [0,0,1000];
_veh allowDamage false;
_veh setPosASL (AGLToASL _pos);
_veh setVectorUp (surfaceNormal _pos);
_veh setDir (markerDir _markerName);
_veh allowDamage true;
_veh lock 2;

// Attribution des clés (patterns ALF)
[_veh] remoteExecCall ["ALF_fnc_addVehicle2Chain", _unit];
[_uid, _veh, 1] call ALF_Server_fnc_keyManagement;
_veh setVariable ["vehicle_info_owners", ["", _uid], true];

// Tag rental (utile pour cleanup)
_veh setVariable ["ALF_rental", ["boat", _markerName, serverTime], true];

["INFO", "Ton bateau t'attend au ponton.", "success"] remoteExec ["ALF_fnc_doMsg", _unit];
