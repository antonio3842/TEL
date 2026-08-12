/*
    File: fn_rebootWeather.sqf
    Author: ALF Team
    Desc: Gestion meteo tempete (appele par HC3)
    Params: _phase - 0: debut tempete, 1: pluie legere, 2: cyclone, 3: reset brume, 4: fermer magasins
*/
if (!isServer) exitWith {};

params [["_phase", 0]];

switch (_phase) do {
    // Phase 0: Debut tempete - overcast
    case 0: {
        (5*60) setOvercast 1;
        diag_log "[ALF_Server] rebootWeather - Phase 0: Overcast active";
    };

    // Phase 1: Pluie legere
    case 1: {
        (5*60) setRain 0.5;
        diag_log "[ALF_Server] rebootWeather - Phase 1: Rain 0.5";
    };

    // Phase 2: Cyclone - conditions extremes + server lock
    case 2: {
        "MRPV2_Serv" serverCommand "#lock";
        setWind [30,30,true];
        (1*60) setRain 1;
        (1*60) setGusts 1;
        (1*60) setLightnings 1;
        (1*60) setFog 0.3;
        diag_log "[ALF_Server] rebootWeather - Phase 2: Cyclone conditions + server lock";
    };

    // Phase 3: Reset brume si trop presente
    case 3: {
        if (fog > 0.1) then {60 setFog 0};
    };

    // Phase 4: Fermer les grilles des magasins
    case 4: {
        private _magasins = nearestObjects [[8000,8000,0], ["Land_ALF_Store"], 20000];
        {_x animateSource ["Grille_source", 0];} forEach _magasins;
        diag_log format ["[ALF_Server] rebootWeather - Phase 4: %1 magasins fermes", count _magasins];
    };
};
