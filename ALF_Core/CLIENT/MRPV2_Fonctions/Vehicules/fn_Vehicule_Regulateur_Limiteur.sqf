params ["_veh",["_mode", "toggleReg"]];

private _cruiseData = getCruiseControl _veh;
private _currentSpeed = _cruiseData # 0;
private _isRegulator = _cruiseData # 1;

switch (_mode) do 
{
    case "toggleReg": 
    {
        if (_currentSpeed > 0 and {_isRegulator}) then {
            _veh setCruiseControl [0, true];
            hintSilent "Régulateur désactivé.";
        } else {
            private _spd = speed _veh;
            if (_spd < 1) exitWith { hintSilent "Vitesse trop faible."; };
            _veh setCruiseControl [_spd, true];
            hintSilent format ["Régulateur activé à %1 km/h", round _spd];
        };
    };

    case "toggleLimiter": {
        if (_currentSpeed > 0 and {!_isRegulator}) then {
            _veh setCruiseControl [0, false];
            hintSilent "Limitateur désactivé.";
        } else {
            private _spd = speed _veh;
            if (_spd < 1) exitWith { hintSilent "Vitesse trop faible."; };
            _veh setCruiseControl [_spd, false];
            hintSilent format ["Limitateur activé à %1 km/h", round _spd];
        };
    };
};