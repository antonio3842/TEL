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

private _v = params[
	["_maintenanceStatus", false, [false]],
	["_isForced", false, [false]]
];

if (_maintenanceStatus && ALF_isUnderMaintenance) exitWith {
	[false, 'Already set']
};

if (!_maintenanceStatus && !ALF_isUnderMaintenance) exitWith {
	[false, 'Already set']
};

[_isForced] spawn ALFTools_Server_fnc_toogleMaintenance;
[true, 'SET']