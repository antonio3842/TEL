/*
	File: fn_removeForfait.sqf
	Author: ALF Team
	Description:

*/
params[
	["_uid","",[""]],
	["_unit",objNull,[objNull]]
];
if(_uid isEqualTo "" OR {isNull _unit}) exitWith {};

// Récupérer le numéro de téléphone avant suppression
private _queryResult = [format["SELECT number FROM phone WHERE playerid='%1'",_uid],2] call ALF_Server_fnc_asyncCall;
private _phoneNumber = "Inconnu";
if (count(_queryResult) > 0) then {
	_phoneNumber = _queryResult select 0;
	if (isNil "_phoneNumber" OR {_phoneNumber isEqualTo ""}) then { _phoneNumber = "Inconnu"; };
};

// Logger la résiliation
[name _unit,_uid,"TELEPHONE",format["A résilié son abonnement téléphonique (numéro : %1).",_phoneNumber]] call ALF_Server_fnc_logIt;

[format["UPDATE phone SET offre='0' WHERE playerid='%1'",_uid],1] call ALF_Server_fnc_asyncCall;

uiSleep 0.25;

["CALL deleteOldForfait",1] call ALF_Server_fnc_asyncCall;

[] remoteExecCall ["ALF_fnc_menuForfait",_unit];
