/*
    GET YOUR PATH
    Code written by Association law 1901 "GET YOUR PATH" (RNA W252007073)
    Statement from the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403
    @Copyright GET YOUR PATH (https://www.getyourpath.fr)
    YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
    More informations : https://www.bistudio.com/community/game-content-usage-rules
    Contact : kainnon@getyourpath.fr
*/

if !(isServer) exitWith {[false]};
if (hasInterface) exitWith {[false]};

private _v = params[
	["_pID", "", [""]]
];

if !(_v) exitWith {
	[false]
};
// private _sqlRequest = format["SELECT * FROM ban WHERE pid='%1' AND (end_date > NOW() OR isPermanent='1') AND unbanID IS NULL LIMIT 1", _pID];
private _sqlRequest = format["SELECT * FROM ban WHERE pid='%1' AND (end_date > NOW() OR isPermanent='1')", _pID];
private _sqlResult = [_sqlRequest,2] call ALF_Server_fnc_asyncCall;

diag_log format["ALF - TEST CHECK BAN : %1", _sqlResult];

if (isNil "_sqlResult") exitWith {
	private _ret = (_this call ALFTools_Server_fnc_checkBan);
	_ret
};

if (_sqlResult isEqualTo []) exitWith {
	[false]
};

_sqlResult params["_id", "_pIDV", "_reason", "_adminName", "_date", "_endDate", "_isPerm", "_unbanID"];

if !(_pIDV isEqualTo _pID) exitWith {
	[false]
};

private _endDateString = "JAMAIS";
if (_isPerm isEqualTo 0) then {
	_endDateString = (_endDate call ALFTools_Server_fnc_convertDate);
};

private _banDateString = (_date call ALFTools_Server_fnc_convertDate);

[true, _reason, _adminName, _banDateString, _endDateString]