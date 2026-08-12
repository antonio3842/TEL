/*
    GET YOUR PATH
    Code written by Association law 1901 "GET YOUR PATH" (RNA W252007073)
    Statement from the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403
    @Copyright GET YOUR PATH (https://www.getyourpath.fr)
    YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
    More informations : https://www.bistudio.com/community/game-content-usage-rules
    Contact : kainnon@getyourpath.fr
*/

if !(isServer) exitWith {};
if (hasInterface) exitWith {};

private _v = params[
	["_playerID", "", [""]],
	["_timeToBan", -2, [-2]],
	["_adminName", "", [""]],
	["_reason", "", [""]]
];

if !(_v) exitWith {};

_reason = [_reason] call ALF_Server_fnc_mresString;

private _sqlRequest = format["INSERT INTO ban(pid,reason,adminName,end_date) VALUES('%1',""'%2'"", '%3', ADDTIME(CURRENT_TIMESTAMP, '%4:0'))", _playerID, _reason, _adminName, _timeToBan];

private _timeText = format["%1 Heure(s)", _timeToBan];

if (_timeToBan isEqualTo -1) then {
	_sqlRequest = format["INSERT INTO ban(pid,reason,adminName,isPermanent) VALUES('%1',""'%2'"",'%3', '1')", _playerID, _reason, _adminName];

	_timeText = "Permanent";
};

[_sqlRequest,1] call ALF_Server_fnc_asyncCall;

[_playerID, _adminName, format["Vous avez été bannis du serveur pour la raison suivante : '%1' | Par : '%2' | Durée du bannissement : '%3' | Si vous constatez un problème merci de contacter l'administration !", _reason, _adminName, _timeText]] call ALFTools_Server_fnc_kick;