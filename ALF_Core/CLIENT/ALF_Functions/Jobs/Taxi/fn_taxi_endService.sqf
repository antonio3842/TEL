/*
	File: fn_taxi_endService.sqf
	Client — fin de service : obligatoire d'avoir rangé le taxi, sauf épave.
*/
if (!alive player) exitWith {};

if !(player getVariable ["MRP_Taxi_EnService", false]) exitWith {
	["TAXI", "Vous n'êtes pas en service taxi.", "warning"] spawn ALF_fnc_doMsg;
};

private _veh = player getVariable ["MRP_Taxi_Vehicle", objNull];
private _parked = player getVariable ["MRP_Taxi_Parked", false];

if (_parked) exitWith {
	[player] remoteExecCall ["ALF_Server_fnc_taxiFinishServiceParked", 2];
};

if (!isNull _veh) then {
	if (alive _veh) exitWith {
		["TAXI", "Veuillez ranger votre véhicule de taxi avant de terminer votre service.", "warning"] spawn ALF_fnc_doMsg;
	};
	[_veh, player] remoteExecCall ["ALF_Server_fnc_taxiEndServiceVehicle", 2];
} else {
	[player] remoteExecCall ["ALF_Server_fnc_taxiFinishServiceParked", 2];
};
