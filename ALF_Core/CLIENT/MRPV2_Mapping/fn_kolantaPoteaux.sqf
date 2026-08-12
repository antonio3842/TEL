/*
    File: fn_kolantaPoteaux.sqf
    Description: Crée un poteau Koh-Lanta avec interaction et mini-jeu d'équilibre
*/

MRPV2_fnc_kolantaPoteaux = {    

// Position du poteau (à adapter)
private _pos = [4388.64,3489.53,0];
private _height = 5; // hauteur du poteau

// Création poteau
private _poteau = createVehicle ["Land_Pole_F", _pos, [], 0, "CAN_COLLIDE"];
_poteau setVectorUp [0,0,1]; // vertical
_poteau allowDamage false;

// Interaction pour monter dessus
_poteau addAction ["Monter sur le poteau", {
    params ["_target", "_caller"];

    private _topPos = getPosATL _target;
    _topPos set [2, (_topPos select 2) + 5]; // hauteur sommet poteau
    _caller setPosATL _topPos;
    _caller setDir (getDir _target);
    _caller switchMove "AmovPercMstpSnonWnonDnon"; // animation debout

    ["Equilibre", _caller, _target] spawn {
        params ["_stateName", "_player", "_poteau"];
        private _failCount = 0;

        systemChat "Début de l'équilibre !";

        while {alive _player && (_player distance _poteau < 3)} do {
            private _key = selectRandom ["GAUCHE","DROITE"];
            systemChat format ["Appuie sur %1 pour rester en équilibre !",_key];

            private _success = false;
            private _timeout = time + 3;

            waitUntil {
                sleep 0.1;
                if (_key == "GAUCHE" && inputAction "MoveLeft" > 0) exitWith {_success = true; true};
                if (_key == "DROITE" && inputAction "MoveRight" > 0) exitWith {_success = true; true};
                time > _timeout
            };

            if (!_success) then {
                _failCount = _failCount + 1;
                systemChat format ["Raté ! (%1/3)",_failCount];
            } else {
                _failCount = 0;
                systemChat "Réussi !";
            };

            if (_failCount >= 3) exitWith {};
            sleep (2 + random 2);
        };

        systemChat "Tu tombes du poteau !";
        _player playMove "AovrPercMrunSrasWrflDf";
        _player setVelocity [0,0,-5];
    };
}];
};