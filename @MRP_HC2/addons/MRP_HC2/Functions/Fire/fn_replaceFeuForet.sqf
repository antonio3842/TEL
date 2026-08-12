/*
    File: fn_replaceFeuForet.sqf
    Author: NiiRoZz
    Desc: Remplace un GrosFeuForet par un MoyenFeuForet sur HC2
          Appele depuis le client via remoteExec quand un GrosFeuForet
          descend en dessous de 30 points de vie
    
    Params:
        _pos - Position ATL du feu a remplacer
        _fireValue - Valeur actuelle du feu (points de vie restants)
*/
params [
    ["_pos",[],[[]]],
    ["_fireValue",25,[0]]
];

if (_pos isEqualTo []) exitWith {};

// Creer le nouveau feu moyen sur HC2
private _feu = "ALF_MoyenFeuForet" createVehicle [0,0,0];
_feu setPosATL _pos;
_feu setVariable ["firealf", _fireValue, true];

// Ajouter a la liste des feux actifs (si elle existe)
if (!isNil "ALF_allFeux") then {
    ALF_allFeux pushBack _feu;
};
