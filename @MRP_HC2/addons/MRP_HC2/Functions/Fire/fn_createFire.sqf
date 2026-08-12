/*
    File: fn_createFire.sqf
    Author: NiiRoZz
    Desc: Cree un feu de batiment sur HC2
*/
params [
    ["_p",[],[[]], 3]
];

// Verifier que la position est valide
if (_p isEqualTo []) exitWith {
    diag_log "[MRP_HC2] fn_createFire: Position invalide";
};

private _e = "test_EmptyObjectForFireBig" createVehicle [0,0,0];
_e setPosATL _p;
_e setVariable ["firealf",150,true];

// Envoyer les effets visuels (feu, fumée, étincelles, lumière) à tous les clients
[_e, 0] remoteExecCall ["ALF_fnc_createFeu", 0, _e];

diag_log format ["[MRP_HC2] fn_createFire: Feu cree a %1, firealf=%2", _p, _e getVariable ["firealf",0]];
