/*
	File: fn_deathScreen.sqf
	Author: ALF TEAM
*/
[(playableUnits select {_x getVariable ["MedService",false]})] remoteExec ["ALF_fnc_deathScreen",(remoteExecutedOwner)];
