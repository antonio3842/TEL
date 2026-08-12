/*
	File: fn_taxi_notifyIncomingCall.sqf
	Notification chauffeur : demande taxi via téléphone.
*/
params [["_client", objNull, [objNull]]];

if !(player getVariable ["MRP_Taxi_EnService", false]) exitWith {};

private _nom = if (isNull _client) then { "Un client" } else { name _client };
["TAXI", format ["Demande de course par téléphone : %1.", _nom], "info"] spawn ALF_fnc_doMsg;
