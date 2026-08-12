params ["_panel","_caller"];

private _spawnMarker = _panel getVariable ["ALF_RentBoat_SpawnMarker",""];
private _boats       = _panel getVariable ["ALF_RentBoat_Boats",[]];

// verifs robustes sans markerExists
private _ok = true;
if (_spawnMarker isEqualTo "") then {
  ["INFO","Location indisponible (marker vide).","warning"] spawn ALF_fnc_doMsg;
  _ok = false;
};
if (_ok && { !(_spawnMarker in allMapMarkers) }) then {
  ["INFO","Location indisponible (marqueur introuvable).","warning"] spawn ALF_fnc_doMsg;
  _ok = false;
};
if (_ok && { (count _boats) isEqualTo 0 }) then {
  ["INFO","Aucun bateau disponible.","warning"] spawn ALF_fnc_doMsg;
  _ok = false;
};
if (!_ok) exitWith {};

// cleanup ancien sous-menu
{
  _panel removeAction _x;
} forEach (_panel getVariable ["ALF_Rent_tmpActions",[]]);
_panel setVariable ["ALF_Rent_tmpActions",[],false];

// sous-menu temporaire par addAction
private _actIds = [];
{
  private _class = _x select 0;
  private _label = _x select 1;
  private _price = _x select 2;

  private _id = _panel addAction [
    format ["Louer %1 - %2EUR", _label, _price],
    {
      params ["_target","_caller","_actionId","_args"];
      _args params ["_spawnMarker","_class","_label","_price"];

      if (isNil "life_cash") then { life_cash = 0; };
      if (life_cash < _price) exitWith {
        ["INFO", format ["Il te manque %1EUR.", (_price - life_cash)], "warning"] spawn ALF_fnc_doMsg;
      };

      private _ok = [format ["Louer %1 pour %2EUR ?", _label, _price], "Location bateau", "OUI", "NON"] call BIS_fnc_guiMessage;
      if (!_ok) exitWith {};

      life_cash = life_cash - _price;
      ["INFO", format ["Tu as loue : %1.", _label], "success"] spawn ALF_fnc_doMsg;

      [getPlayerUID _caller, _caller, _spawnMarker, _class] remoteExecCall ["ALF_Server_fnc_spawnRentedBoat", 2];

      {
        _target removeAction _x;
      } forEach (_target getVariable ["ALF_Rent_tmpActions",[]]);
      _target setVariable ["ALF_Rent_tmpActions",[],false];
    },
    [_spawnMarker,_class,_label,_price],
    1.5, true, true, "", "alive _target && alive _this"
  ];

  _actIds pushBack _id;
} forEach _boats;

_panel setVariable ["ALF_Rent_tmpActions", _actIds, false];

// auto-clean apres 30s
[_panel, _actIds] spawn {
  params ["_p","_ids"];
  uiSleep 30;
  if ((_p getVariable ["ALF_Rent_tmpActions",[]]) isEqualTo _ids) then {
    { _p removeAction _x; } forEach _ids;
    _p setVariable ["ALF_Rent_tmpActions",[],false];
  };
};
