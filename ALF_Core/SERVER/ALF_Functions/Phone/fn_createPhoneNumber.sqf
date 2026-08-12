/*
	File: fn_createPhoneNumber.sqf
	Author: ALF Team

	This file is for Nanou's HeadlessClient.

	Description:

*/
params [
	["_uid","",[""]],
	["_unit",objNull,[objNull]]
];

_prefix = selectRandom ["06","07"];
private _nbf = _prefix + format["%1%2%3%4%5%6%7%8", floor(random 10), floor(random 10), floor(random 10), floor(random 10), floor(random 10), floor(random 10), floor(random 10), floor(random 10)];

private _count = ([format["SELECT COUNT(*) FROM phone WHERE number='%1'",_nbf],2] call ALF_Server_fnc_asyncCall) select 0;

if(_count isEqualTo 0) then {
	private _query = format["UPDATE phone SET number='%1' WHERE playerid='%2'",_nbf,_uid];
	[_query,1] call ALF_Server_fnc_asyncCall;
	
	// Logger l'attribution du nouveau numéro
	[name _unit,_uid,"TELEPHONE",format["A obtenu un nouveau numéro de téléphone : %1.",_nbf]] call ALF_Server_fnc_logIt;
	
	_unit setVariable ["phoneNumber",_nbf];
	[_nbf] remoteExecCall ["ALF_fnc_setPhoneNumber",_unit];
} else {
	[_uid,_unit] spawn ALF_Server_fnc_createPhoneNumber;
};
