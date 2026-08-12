/*
	File: fn_distrib_rangerVehicle.sqf
	Client — demande rangement véhicule distributeur au PNJ.
*/
if (!alive player) exitWith {};

if (!MRP_Distrib_EnService) exitWith {
	["Distributeur", "Vous n'êtes pas en service distributeur.", "warning"] spawn ALF_fnc_doMsg;
};

if (MRP_Distrib_Parked) exitWith {
	["Distributeur", "Véhicule déjà rangé. Terminez votre service.", "info"] spawn ALF_fnc_doMsg;
};

private _pnj = missionNamespace getVariable ["life_pInact_curObject", objNull];
if (isNull _pnj) then {
	_pnj = cursorObject;
};

[player, _pnj] remoteExecCall ["ALF_Server_fnc_distribRangerVehicle", 2];
