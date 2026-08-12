#include "\ALF_Client\script_macros.hpp"
/*
File: buyLeboncoin.sqf
Author: ALF Nanou
*/
private _id = _this select 0;
private _numid = _this select 1;
private _prix = _this select 2;
private _s = _this select 3;

private _handle = [_prix,false] call ALF_fnc_handleCB;
if (_handle) exitWith {};

[_id,_numid,getPlayerUID player,player,_s,_prix] remoteExec ["ALF_Server_fnc_achatLeboncoin",2];

[name player,getPlayerUID player,"LEBONCOIN",format["a acheté l annonce %1 pour %2€ (Vendeur : %3).",_numid,_prix,_s]] remoteExec ["ALF_Server_fnc_logIt",2];
