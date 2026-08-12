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

/* -- Security Number -- */
ALF_SecretNumber = 15000 + round(random 100000);
private _res = ("ALF_Core" callExtension ["ALF_setSecretKey", [15000]]);
diag_log format["[ALF Core] SECRET KEY : %1", _res];

/* -- Setup functions -- */
ALF_PostInit_Functions = [];
ALF_Function_firstLoaded = false;
_res = ("ALF_Core" callExtension "ALF_ClearTemp");
diag_log format["[ALF Core] CLEAR TEMP : %1", _res];
"ALF_Core" callExtension ["ALF_setCorePath", ["C:\sunny"]];
[] call ALF_Core_Init_fnc_loadFunctions;
ALF_Function_firstLoaded =  true;
