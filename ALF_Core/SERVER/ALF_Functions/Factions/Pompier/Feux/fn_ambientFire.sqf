/*
    File: fn_ambientFire.sqf
    Author: NiiRoZz
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

["BRAVO","VOUS AVEZ ETEINT L'INCENDIE DE FORET !!"] call ALF_Server_fnc_doMedCall;
[100000] call ALF_Server_fnc_updateCNP;