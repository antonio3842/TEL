/*
	This file is for Nanou's HeadlessClient.
*/

//ALF_fnc_WeedVentilation = {

params [
	["_object", objNull, [objNull]]
];
if (isNull _object) exitWith {};

private _active = _object getVariable ["ventilation", false];

if (_active) then {
	_object setVariable ["ventilation", false];
} else {
	_object setVariable ["ventilation", true];
	private _first = false;

	for "_i" from 0 to 1 step 0 do {
		_active = _object getVariable ["ventilation", false];
		if (!_active) exitWith {};

		if (!_first) then {
			_first = true;
			["ALF_Client2\sounds\ventil1.ogg", _object, false, getPosASL _object, 100, 1, 100] remoteExec ["ALF_fnc_playSound3D", 0];
		} else {
			["ALF_Client2\sounds\ventil2.ogg", _object, false, getPosASL _object, 100, 1, 100] remoteExec ["ALF_fnc_playSound3D", 0];
		};

		uiSleep 12;
	};
};
//};

/*
// ALF_fnc_WeedVentilation = {
	
params [
    ["_object", objNull, [objNull]]
];
if (isNull _object) exitWith {};

private _active = _object getVariable ["ventilation", false];

if (_active) then {
    _object setVariable ["ventilation", false, true]; // propagation
} else {
    _object setVariable ["ventilation", true, true];

    private _first = false;
    for "_i" from 0 to 1 step 0 do {
        if (!(_object getVariable ["ventilation", false])) exitWith {};

        // Liste des joueurs proches (dans un rayon de 50m)
        private _clients = allPlayers select { (_x distance _object) < 50 };

        if (!_first) then {
            [_object, "ALF_Client2\sounds\ventil1.ogg"] remoteExec ["ALF_fnc_playSound3D", _clients];
            _first = true;
        } else {
            [_object, "ALF_Client2\sounds\ventil2.ogg"] remoteExec ["ALF_fnc_playSound3D", _clients];
        };

        uiSleep 12;
    };
};

// };
*/