/*
	File: fn_distrib_terminerService.sqf
	Client — fin de service : véhicule rangé obligatoire (sauf épave).
*/
if (!alive player) exitWith {};

if (!MRP_Distrib_EnService) exitWith {
	["Distributeur", "Vous n'êtes pas en service.", "warning"] spawn ALF_fnc_doMsg;
};

private _veh = player getVariable ["MRP_Distrib_Vehicle", objNull];
private _parked = MRP_Distrib_Parked;

if (_parked) exitWith {
	[player] remoteExecCall ["ALF_Server_fnc_distribFinishServiceParked", 2];
};

if (!isNull _veh) then {
	if (alive _veh) exitWith {
		["Distributeur", "Veuillez ranger votre véhicule avant de terminer votre service.", "warning"] spawn ALF_fnc_doMsg;
	};
	[_veh, player] remoteExecCall ["ALF_Server_fnc_distribEndServiceVehicle", 2];
} else {
	[player] remoteExecCall ["ALF_Server_fnc_distribFinishServiceParked", 2];
};
