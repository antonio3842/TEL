/*
    GET YOUR PATH
    Code written by Association law 1901 "GET YOUR PATH" (RNA W252007073)
    Statement from the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403
    @Copyright GET YOUR PATH (https://www.getyourpath.fr)
    YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
    More informations : https://www.bistudio.com/community/game-content-usage-rules
    Contact : kainnon@getyourpath.fr
*/

if !(isServer) exitWith {[false, "Function must be called from server"]};
if (hasInterface) exitWith {[false, "Function must be called from server"]};

private _v = params [
	["_adminUID", "", [""]],
	["_pID", "", [""]],
	["_reason", "", [""]],
	["_timeToBan", -2, [-2]]
];

/* -- Check if already ban -- */
private _retCheck = [_pID] call ALFTools_Server_fnc_checkBan;
_retCheck params[
    ["_isBan", false, [false]],
    ["_reason", "", [""]],
    ["_adminName", "", [""]],
    ["_startTime","", [""]],
    ["_timeBan", "", [""]]
];

if (_isBan && _timeBan isEqualTo "JAMAIS") exitWith {
    [false,"Cette personne est déjà bannie de façon permanente"]
};

/* -- Ban player -- */
[_pID, _timeToBan, _adminUID, _reason] call ALFTools_Server_fnc_ban;
[true, "BANNED"]