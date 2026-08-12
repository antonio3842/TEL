/*
    File: fn_sanctuaireTurtles.sqf
    Author: ALF Team
    Desc: Sanctuaire des tortues marines
    hc_1 - Boucle systeme
*/

/*
  ===== CONFIG COMMUNE =====
*/
private _step    = 30;
private _debug   = false;

private _zones = [
  ["Zone nord ", [8975.99, 5435.95, 0], 150, 30, 1.5, 0.5, 30],
  ["Zone sud", [1505.21, 1117.56, 0], 150, 30, 1.5, 0.5, 30]
];

missionNamespace setVariable ["alf_turtle_debug", _debug, true];

/*
  ===== HELPERS =====
*/
missionNamespace setVariable ["ALF_fnc_randXYInCircle", {
  params ["_c","_r"];
  private _a = random 360;
  private _d = _r * sqrt (random 1);
  [_c#0 + _d * cos _a, _c#1 + _d * sin _a]
}];

missionNamespace setVariable ["ALF_fnc_posASLFromXY", {
  params ["_x","_y"];
  if (surfaceIsWater [_x,_y]) then { [_x,_y, -(5 + random 25)] } else { ATLToASL [_x,_y,0] }
}];

/*
  ===== IA "rebond 180" =====
*/
missionNamespace setVariable ["ALF_fnc_startBounceAI_server", {
  params ["_t","_c","_r","_margin","_tick"];
  [_t,_c,_r,_margin,_tick] spawn {
    params ["_t","_c","_r","_margin","_tick"];
    while {alive _t} do {
      private _p = getPosASL _t;
      private _p2D = [_p#0,_p#1,0];
      private _c2D = [_c#0,_c#1,0];
      private _dC  = _p2D distance2D _c2D;

      if (_dC >= (_r - _margin)) then {
        _t setDir ((getDir _t) + 180);
        private _spd = 0.8 + random 0.6;
        _t setVelocity [(sin (getDir _t)) * _spd, (cos (getDir _t)) * _spd, 0];
      };

      if (_dC > _r) then {
        private _dirToCenter = [_p2D,_c2D] call BIS_fnc_dirTo;
        _t setPosASL [
          _c#0 + (_r - 1) * cos _dirToCenter,
          _c#1 + (_r - 1) * sin _dirToCenter,
          _p#2
        ];
        _t setDir _dirToCenter;
      };

      uiSleep _tick;
    };
  };
}, true];

/*
  ===== SPAWN 1 TORTUE =====
*/
ALF_fnc_spawnOneTurtle_server = {
  params [["_center",[0,0,0]],["_radius",150],["_margin",1.5],["_tick",0.5]];

  private _xy     = [_center,_radius] call (missionNamespace getVariable "ALF_fnc_randXYInCircle");
  private _posASL = [_xy#0,_xy#1] call (missionNamespace getVariable "ALF_fnc_posASLFromXY");

  private _t = createAgent ["Turtle_F", ASLToATL _posASL, [], 0, "NONE"];
  _t setPosASL _posASL;
  _t setDir (random 360);
  private _initSpd = 0.6 + random 0.6;
  _t setVelocity [(sin (getDir _t)) * _initSpd, (cos (getDir _t)) * _initSpd, 0];

  _t setVariable ["alf_zone_params", [_center,_radius,_margin,_tick], true];

  [_t,_center,_radius,_margin,_tick] call (missionNamespace getVariable "ALF_fnc_startBounceAI_server");
  _t
};
publicVariable "ALF_fnc_spawnOneTurtle_server";

/*
  ===== RESPAWN =====
*/
ALF_fnc_respawnTurtle_server = {
  params [["_corpse", objNull, [objNull]]];
  if (isNull _corpse) exitWith {};
  if (alive _corpse && {lifeState _corpse != "DEAD"}) exitWith {};
  if (!isNil {_corpse getVariable "alf_respawned"}) exitWith {};

  _corpse setVariable ["alf_respawned", true, true];

  private _zp = _corpse getVariable ["alf_zone_params", []];

  deleteVehicle _corpse;

  if !(_zp isEqualTo []) then {
    _zp call ALF_fnc_spawnOneTurtle_server;
  };
};
publicVariable "ALF_fnc_respawnTurtle_server";

/*
  ===== COMPTE TORTUES =====
*/
ALF_fnc_countTurtlesInZone = {
  params ["_c","_r"];
  private _animals = _c nearEntities ["Animal", _r];
  private _turtles = _animals select { typeOf _x isEqualTo "Turtle_F" };
  { alive _x && { lifeState _x != "DEAD" } } count _turtles
};

/*
  ===== BOUEES + DEMARRAGE MULTI-ZONES =====
*/
{
  _x params ["_name","_center","_radius","_count","_margin","_tick","_period"];

  // Bouees pour cette zone
  for "_angle" from 0 to (360 - _step) step _step do {
    private _xpos = _center#0 + _radius * cos _angle;
    private _ypos = _center#1 + _radius * sin _angle;
    private _b = createVehicle ["Land_BuoyBig_F", [_xpos,_ypos,0], [], 0, "NONE"];
    _b setPosATL [_xpos,_ypos,0];
  };

  // Spawn initial
  for "_i" from 1 to _count do {
    [_center,_radius,_margin,_tick] call ALF_fnc_spawnOneTurtle_server;
  };

  // Boucle de maintien pour cette zone
  [_name, _center, _radius, _count, _margin, _tick, _period] spawn {
    params ["_name","_center","_radius","_count","_margin","_tick","_period"];
    while {true} do {
      private _cur     = [_center,_radius] call ALF_fnc_countTurtlesInZone;
      private _missing = _count - _cur;

      if (missionNamespace getVariable ["alf_turtle_debug", false]) then {
        private _msg = format ["[%1] Tortues %2 / %3   Manquantes: %4", _name, _cur, _count, _missing];
        missionNamespace setVariable ["alf_turtle_debug_msg", _msg, true];
        diag_log _msg;
      };

      if (_missing > 0) then {
        for "_i" from 1 to _missing do {
          [_center,_radius,_margin,_tick] call ALF_fnc_spawnOneTurtle_server;
          uiSleep 0.25;
        };
      };

      uiSleep _period;
    };
  };
} forEach _zones;

/*
  ===== ALERTES POLICIERS =====
*/
private _zonesRef = +_zones;
private _cooldown = 60;

[_zonesRef, _cooldown] spawn {
  params ["_zones","_cooldown"];

  private _lastAlertAt = createHashMap;
  private _insidePrev  = createHashMap;

  waitUntil { time > 0 };

  while {true} do {
    uiSleep 2;

    {
      if (isPlayer _x && alive _x) then {
        private _pos = getPosWorld _x;
        private _id  = netId _x;

        {
          _x params ["_name","_center","_radius"];

          private _key       = format ["%1|%2", _id, _name];
          private _isInside  = (_pos distance2D _center) < _radius;
          private _wasInside = _insidePrev getOrDefault [_key, false];

          if (_isInside && {!_wasInside}) then {
            private _last = _lastAlertAt getOrDefault [_key, -_cooldown];
            if (time - _last >= _cooldown) then {
              ["Crime", format ["Une personne vient d'entrer dans le sanctuaire marin (%1).", _name]]
                remoteExecCall ["ALF_Server_fnc_doCopCall", 2];

              _lastAlertAt set [_key, time];
            };
          };

          _insidePrev set [_key, _isInside];
        } forEach _zones;
      };
    } forEach (entities "CAManBase" select {isPlayer _x && alive _x});
  };
};

diag_log "[SANCTUAIRE-HC1] Sanctuaire des tortues initialise";
