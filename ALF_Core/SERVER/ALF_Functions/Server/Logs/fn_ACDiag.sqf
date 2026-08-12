/*
    MRP – AntiCheat LOG only RPT
    Ce fichier NE FAIT QUE diag_log dans le RPT serveur.
*/
params ["_playerName","_playerUID","_msg"];

diag_log format ["[ANTICHEAT] %1 (%2) : %3", _playerName, _playerUID, _msg];
