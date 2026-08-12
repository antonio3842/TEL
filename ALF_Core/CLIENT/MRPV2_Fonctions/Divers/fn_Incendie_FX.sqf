/*
    File: fn_Incendie_FX.sqf
    Path: \ALF_Core\CLIENT\MRPV2_Fonctions\Divers\
    Tag: MRPV2_fnc_Incendie_FX
    Side: CLIENT

    Desc:
      Crée un feu + fumée à la position donnée, ajoute un marqueur local
      "!! INCENDIE !!" et notifie le serveur (ALF_Server_fnc_doMedCall).

    Usage:
      [_pos] remoteExecCall ["MRPV2_fnc_Incendie_FX", 0];  // 0 = tous les clients

    Params:
      _pos (ARRAY) — position ATL [x,y,z]
*/
params ["_pos"];

// Sécurité basique
if (isNil "_pos" || {count _pos < 2}) exitWith {};

//
// Effets particules
//
private _fire = createVehicle ["#particlesource", _pos, [], 0, "CAN_COLLIDE"];
_fire setParticleClass "MediumDestructionFire";

private _smoke = createVehicle ["#particlesource", _pos, [], 0, "CAN_COLLIDE"];
_smoke setParticleClass "BigDestructionSmoke";

//
// Marqueur local carte
//
private _id = format ["fire_%1", diag_tickTime];
private _mk = createMarkerLocal [_id, _pos];
_mk setMarkerColorLocal "ColorRed";
_mk setMarkerTypeLocal "Mil_dot";
_mk setMarkerTextLocal "!! INCENDIE !!";

// Stock local pour éventuel debug/cleanup manuel
if (isNil "MRPV2_Client_Fires") then { MRPV2_Client_Fires = []; };
MRPV2_Client_Fires pushBack [_fire, _smoke, _mk, _pos, time];

//
// Nettoyage auto après 120s
//
[_fire, _smoke, _mk] spawn {
    params ["_f","_s","_m"];
    uiSleep 120;
    { if (!isNull _x) then { deleteVehicle _x; }; } forEach [_f,_s];
    deleteMarkerLocal _m;
};

//
// Alerte serveur (H=2 → serveur dédié)
//
["INCENDIE","ALERTE INCENDIE !"] remoteExecCall ["ALF_Server_fnc_doMedCall", 2];
