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
if !(canSuspend) exitWith {
    _this spawn ALFTools_Server_fnc_toogleMaintenance;
};

private _v = params[
    ["_isForced", false, [false]]
];

if (ALF_isUnderMaintenance) exitWith {
    /* -- Disable maintenance -- */
    ALF_isUnderMaintenance = false
};

/* -- Setup maintenance -- */

if !(_isForced) then {
    // Send global message

    // Timer before kick
    sleep 600; // Wait 10 minutes
};

ALF_isUnderMaintenance = true;

// Kick all players
private _allAdminsPlayers = ["SELECT playerid FROM players WHERE adminlevel > 0",2] call ALF_Server_fnc_asyncCall;

if (isNil "_result") then {
    _result = [];
};

private _formatedArray = [];

{
    private _pID = (_x#0);
    _formatedArray pushBack _pID;
}forEach _allAdminsPlayers;

{
    /* -- Check if admin -- */
    private _pID = getPlayerUID _x;
    if (_pID in _formatedArray) exitWith {};

    /* -- Kick player -- */
    [_pID, "SERVEUR", "Le serveur viens d'être placé en état de maintenance. Tenez vous au courant sur le discord des prochains changements !"] call ALFTools_Server_fnc_kick;
}forEach allPlayers;