// File: core\rental\fn_openCarRental.sqf
params ["_npc","_unit"];

private _marker = _npc getVariable ["ALF_RentCar_SpawnMarker",""];
private _cars   = _npc getVariable ["ALF_RentCar_Cars", []];

if (_marker isEqualTo "" || {count _cars == 0}) exitWith {
  ["INFO","Location voiture: configuration invalide.", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

private _tempIds = [];
{
  private _class = _x select 0;
  private _label = _x select 1;

  private _id = _npc addAction [
    format["Louer: %1", _label],
    {
      params ["_npc","_caller","_actionId","_args"];
      private _marker = _args select 0;
      private _class  = _args select 1;
      private _allIds = _args select 2;

      { _npc removeAction _x } forEach _allIds;
      _npc setVariable ["ALF_RentCar_TempActions", nil];

      [getPlayerUID _caller, _caller, _marker, _class] remoteExecCall ["ALF_Server_fnc_spawnRentedCar", 2];
    },
    [_marker, _class, _tempIds],
    1.5, true, true, "", "true", 3
  ];

  _tempIds pushBack _id;
} forEach _cars;

private _cancelId = _npc addAction [
  "Annuler",
  {
    params ["_npc","","_actionId"];
    _npc removeAction _actionId;
    private _ids = _npc getVariable ["ALF_RentCar_TempActions", []];
    { _npc removeAction _x } forEach _ids;
    _npc setVariable ["ALF_RentCar_TempActions", nil];
  },
  nil,1.5,true,true,"","true",3
];
_tempIds pushBack _cancelId;

_npc setVariable ["ALF_RentCar_TempActions", _tempIds];

[_npc] spawn {
  params ["_npc"];
  uiSleep 30;
  private _ids = _npc getVariable ["ALF_RentCar_TempActions", []];
  { _npc removeAction _x } forEach _ids;
  _npc setVariable ["ALF_RentCar_TempActions", nil];
};
