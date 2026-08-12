/*
    File: fn_addTempMarker.sqf
    Path: CLIENT\MRPV2_Fonctions\cambriolage\fn_addTempMarker.sqf
    Description: Crée un marqueur LOCAL temporaire sur position donnée.
    Params:
      0: _pos (array) - [x,y,z]
      1: _text (string) - texte du marqueur (défaut "Cambriolage")
      2: _ttl (number) - durée en secondes (défaut 600)
      3: _type (string) - type du marqueur (défaut "mil_warning")
      4: _color (string) - couleur du marqueur (défaut "ColorRed")
*/

params [
    ["_pos", [0,0,0], [[]]],
    ["_text", "Cambriolage", [""]],
    ["_ttl", 600, [0]],
    ["_type", "mil_warning", [""]],
    ["_color", "ColorRed", [""]]
];

// Génère un nom unique
private _mName = format ["ALF_Rob_%1_%2", floor random 10000, diag_tickTime];

// Création marqueur local
private _marker = createMarkerLocal [_mName, _pos];
_marker setMarkerTypeLocal _type;
_marker setMarkerColorLocal _color;
_marker setMarkerTextLocal _text;
_marker setMarkerAlphaLocal 1;

// Suppression auto
[_mName, _ttl] spawn {
    params ["_markerName","_ttl"];
    sleep _ttl;
    if (!isNil {_markerName}) then {
        deleteMarkerLocal _markerName;
    };
};
