/*
	File: fn_boucleEnPrison.sqf
	Author: ALF Team
*/
params [
	["_temps",-1,[0]]
];

if (_temps > 0) then {
	ALF_TimePrison = _temps;
};

private _time = time;

waitUntil {
	if ((time - _time) >= 1) then {
		ALF_TimePrison = ALF_TimePrison - 1;
		_time = time;
	};
	!(player getVariable ["ALF_EnPrison",false]) || {ALF_TimePrison <= 0} || {(player distance [11052.349,3918.944,0.297/*11005.1,3701.35,0.00239563*/]) >= 500 && {player distance (getMarkerPos "respawn_civilian") > 400}}
};

if (ALF_TimePrison <= 0) exitWith {
	[player] remoteExecCall ["ALF_Server_fnc_sortiePrison",2];
	[2880, player] remoteExecCall ["ALF_Server_fnc_braceletElectronique",2];
	player setVariable ["ALF_EnPrison",false,true];
	ALF_Prison = false;

	private _coffre = call compile format ["alf_coffre_prison_%1",ALF_Prison_Coffre];
	[_coffre,1] remoteExec ["ALF_Server_fnc_customCoffre",2];
	[_coffre,3] remoteExec ["ALF_Server_fnc_customCoffre",2];

	ALF_Prison_Coffre = 0;
	player setPosATL [10937.546,3868.500,0];
	player setDir 259.241;
};

if ((player distance [11052.349,3918.944,0.297/*11005.1,3701.35,0.00239563*/]) >= 500) exitWith {
	player setVariable ["ALF_EnPrison",false,true];
	[player] remoteExecCall ["ALF_Server_fnc_sortiePrison",2];
	["Prison", "Evasion d'un prisonnier.", "danger"] remoteExecCall ["ALF_Server_fnc_doPenitCall",2];
	["Prison", "Evasion d'un prisonnier."] remoteExecCall ["ALF_Server_fnc_doCopCall",2];
	ALF_Prison = false;

	private _coffre = call compile format ["alf_coffre_prison_%1",ALF_Prison_Coffre];
	[_coffre,1] remoteExec ["ALF_Server_fnc_customCoffre",2];
	[_coffre,3] remoteExec ["ALF_Server_fnc_customCoffre",2];

	ALF_Prison_Coffre = 0;
};

if (!(player getVariable ["ALF_EnPrison",false]) && {ALF_Prison}) then {
	ALF_Prison = false;

	private _coffre = call compile format ["alf_coffre_prison_%1",ALF_Prison_Coffre];
	[_coffre,1] remoteExec ["ALF_Server_fnc_customCoffre",2];
	[_coffre,3] remoteExec ["ALF_Server_fnc_customCoffre",2];
	
	ALF_Prison_Coffre = 0;
};
