/*
    GET YOUR PATH
    Code written by Association law 1901 "GET YOUR PATH" (RNA W252007073)
    Statement from the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403
    @Copyright GET YOUR PATH (https://www.getyourpath.fr)
    YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
    More informations : https://www.bistudio.com/community/game-content-usage-rules
    Contact : kainnon@getyourpath.fr
*/

if !(isServer) exitWith {false};
if (hasInterface) exitWith {false};

private _v = params[
	["_pID", "", [""]],
	["_adminLevel", -1, [-1]]
];

if !(_v) exitWith {false};

private _sqlResult = [format["SELECT playerid FROM players WHERE adminlevel >= %2 AND playerid = '%1'",_pID,_adminLevel],2] call ALF_Server_fnc_asyncCall;

!(_sqlResult isEqualTo [])