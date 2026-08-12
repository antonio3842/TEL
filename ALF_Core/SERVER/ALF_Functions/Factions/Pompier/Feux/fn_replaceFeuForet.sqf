/*
	File: fn_replaceFeuForet.sqf
	Desc: Remplace un gros feu de forêt par un moyen feu (appelé depuis client)
*/
params [
	["_pos", [0,0,0], [[]]],
	["_fireValue", 30, [0]]
];

if (_pos isEqualTo [0,0,0]) exitWith {};

private _f2 = "ALF_MoyenFeuForet" createVehicle _pos;
_f2 setVariable ["firealf", _fireValue, true];

// Envoyer les effets visuels aux clients (mode 1 = moyen feu)
[_f2, 1] remoteExecCall ["ALF_fnc_createFeu", 0, _f2];
