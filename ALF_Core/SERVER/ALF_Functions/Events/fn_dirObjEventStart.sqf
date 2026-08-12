#include "\ALF_Core\SERVER\script_macros.hpp"
/*
Init de la fonction spawn d'un objet pour la DIR
*/

if (!isServer) exitWith {false};
params [["_mode", false]];


// --- State (server-only via missionNamespace, non diffusé)
private _now           = time;
private _nextForce     = missionNamespace getVariable ["MRP_dirObj_nextForceAllowed", 0];
private _loopHandle    = missionNamespace getVariable ["MRP_dirObj_loopHandle",  scriptNull];
private _loopStarting  = missionNamespace getVariable ["MRP_dirObj_loopStarting", false];


// --- Si la boucle tourne déjà, ne rien faire (idempotent + silencieux)
if (!isNull _loopHandle && {!scriptDone _loopHandle}) exitWith { true };

// --- Anti-race si start spammé à la même frame
if (_loopStarting) exitWith { true };
missionNamespace setVariable ["MRP_dirObj_loopStarting", true];


// --- Crée la boucle planifiée
private _h = [] spawn {
_delay = 300;
    diag_log format ["[DIR][Spawn Objet] début du script (Premier spawn si DIR co dans %1s).", _delay];
	
    // Boucle horaire
    while {true} do {
		uiSleep _delay;
		_i = 0;
		{
			if (_x getVariable ["b_18",false]) then {
				_i = 1;
			};
		} forEach playableUnits; //Check de la présence de la DIR pour faire spawn un objet, sinon restart de la boucle
		if (_i == 1) then {
			[] call ALF_Server_fnc_dirObjSpawn;
		};
		_random = random 1800; //30minmin
		_random = _random - 900; //entre plus 1 ou moins 1min
		_delay = 2700 + _random; //Gestion d'un temps random entre 2 et 4min
		//diag_log format ["[MRP][DIR] DEBUG Next boucle %1s.", _delay];
    };
};

// --- Enregistre le handle (local serveur, non diffusé)
missionNamespace setVariable ["MRP_dirObj_loopHandle", _h];
missionNamespace setVariable ["MRP_dirObj_loopStarting", false];

true