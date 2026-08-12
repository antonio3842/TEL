/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
if (hasInterface) exitWith {diag_log "[ALF_Core]: ERROR: Running on client"};
if !(isServer) exitWith {diag_log "[ALF_Core]: ERROR: Not on server"};
if !(isDedicated) exitWith {diag_log "[ALF_Core]: ERROR: Not dedicated"};

if (isNil "ALF_PostInit_Functions") then {
	ALF_PostInit_Functions = [];
};

/* -- POST INIT -- */
diag_log "[ALF_Core]: Start POST INIT execution";
{
	[] call (compile (preprocessFileLineNumbers _x));
}forEach ALF_PostInit_Functions;
diag_log "[ALF_Core]: POST INIT executed";
