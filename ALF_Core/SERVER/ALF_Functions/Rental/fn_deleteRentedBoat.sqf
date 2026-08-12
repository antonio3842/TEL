/*
  File: fn_deleteRentedBoat.sqf
  Supprime un bateau loué par le joueur.
  Appel : [uid, player] remoteExecCall ["ALF_Server_fnc_deleteRentedBoat", 2];
*/

if !(isServer) exitWith {};

params [
  ["_uid", "", [""]],
  ["_unit", objNull, [objNull]]
];
if (_uid isEqualTo "" || {isNull _unit}) exitWith {};

private _veh = objNull;

// chercher véhicule loué par ce joueur
{
  if (!isNull _x) then {
    private _rental = _x getVariable ["ALF_rental", []];
    if !(_rental isEqualTo []) then {
      private _owners = _x getVariable ["vehicle_info_owners", []];
      if (_owners isEqualType [] && {(_owners select 1) isEqualTo _uid}) exitWith {
        _veh = _x;
      };
    };
  };
} forEach vehicles;

if (isNull _veh) exitWith {
  ["INFO","Tu n'as aucun bateau de location à rendre.","warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

// supprimer les clés
[_uid, _veh, 0] call ALF_Server_fnc_keyManagement;

// suppression bateau
deleteVehicle _veh;

["INFO","Bateau rendu, merci !","success"] remoteExec ["ALF_fnc_doMsg", _unit];
