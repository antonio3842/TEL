#include "\ALF_Client\script_macros.hpp"
/*
	File: fn_ticketPaid.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Verifies that the ticket was paid.
*/
params [
	["_value",5,[0]],
	["_unit",objNull,[objNull]],
	["_cop",objNull,[objNull]]
];
if(isNull _unit OR {_unit != life_ticket_unit}) exitWith {};
if(isNull _cop OR {_cop != player}) exitWith {};

private _cng = missionNamespace getVariable ["CNPM",0];
_cng = _cng + floor(_value/5);
[_cng] remoteExec ["ALF_Server_fnc_updateCNPM",2];
[name _unit,getPlayerUID _unit,"BANK",format["A payer %1€ d amende à %2 (Penit).",_value,name player]] remoteExec ["ALF_Server_fnc_logIt",2];
