#include "\ALF_Core\SERVER\script_macros.hpp"
/*
Init de la fonction de casse d'objet pour BIE
*/

if (!isServer) exitWith {false};

private _h = [] spawn {
_delay = 300;

private _centreMap = [worldSize / 2, worldSize / 2, 0]; 
 
private _objetCarte = []; 
private _lampeCarte = []; 
private _objetHS = objNull;
private _transo = [ALF_BIE_SECTEUR_1,ALF_BIE_SECTEUR_2,ALF_BIE_SECTEUR_3,ALF_BIE_SECTEUR_4];
{ 
    _objetCarte append (allMissionObjects _x); 
} forEach ["Land_ALF_Pompe", "Land_Alf_Crem", "Land_Alf_Entreprise"]; 
 
{ 
    if ((typeOf _x) in ["Land_LampStreet_F", "Land_LampDecor_F"]) then { 
        _lampeCarte pushBack _x; 
    }; 
} forEach (nearestTerrainObjects [_centreMap, [], worldSize]); 

diag_log format ["[ENEDIS] début du script dans %1s.", _delay];
	
    // Boucle horaire
    while {true} do {
		sleep _delay;
		_ran = random 100;
		if (_ran >= 70) then {
			_objetHS = selectRandom _objetCarte;
		} else {
			if (_ran >= 10) then {
				_objetHS = selectRandom _lampeCarte;
			} else {
				_objetHS = selectRandom _transo;
			};
		};
		private _nbEnService = {_x getVariable ["MRP_Bie_EnService", false]} count playableUnits;		

		if ((playableUnits findIf {(_x getVariable ["MRP_Bie_EnService", false])}) != -1) then {
			[_objetHS] spawn ALF_Server_fnc_enedisSpawn;
		};

		switch (true) do {
			case (_nbEnService == 0): {
				_delay = 360;
			};
			case (_nbEnService == 1): {
				_delay = 360;
			};
			case (_nbEnService == 2): {
				_delay = 300;
			};
			case (_nbEnService == 3): {
				_delay = 270;
			};
			case (_nbEnService == 4): {
				_delay = 240;
			};
			case (_nbEnService == 5): {
				_delay = 180;
			};
			case (_nbEnService == 6): {
				_delay = 120;
			};
			default { // 7 ou plus
				_delay = 100;
			};
		};
    };
};



