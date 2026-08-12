/*
    File: fn_ambientFire.sqf
    Author: NiiRoZz
    Desc: Gestion de l'ambiance des feux de foret sur HC2
*/
while {!(ALF_allAmbianceFeux isEqualTo [])} do {
    {
        if ((nearestObjects [(_x select 0), ["ALF_GrosFeuForet","ALF_MoyenFeuForet"], 10, true]) isEqualTo []) then {
            deleteVehicle (_x select 0);
            deleteVehicle (_x select 1);
        };
    } forEach ALF_allAmbianceFeux;
    ALF_allAmbianceFeux = ALF_allAmbianceFeux - [objNull];
    uiSleep 2;
};

["BRAVO","VOUS AVEZ ETEINT L'INCENDIE DE FORET !!"] remoteExecCall ["ALF_Server_fnc_doMedCall", 2];

[100000] remoteExecCall ["ALF_Server_fnc_updateCNP", 2];
