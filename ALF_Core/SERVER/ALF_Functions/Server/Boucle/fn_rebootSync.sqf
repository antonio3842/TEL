/*
    File: fn_rebootSync.sqf
    Author: ALF Team
    Desc: Synchronisation des donnees lors du reboot (appele par HC3)
*/
if (!isServer) exitWith {};

diag_log "[ALF_Server] rebootSync - Synchronisation des donnees...";

[] remoteExec ['SOCK_fnc_syncData', allplayers];
[] spawn ALF_Server_fnc_vehicleAutoSync;

diag_log "[ALF_Server] rebootSync - Synchronisation terminee";
