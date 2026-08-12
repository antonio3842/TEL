#include "\ALF_Client\script_macros.hpp"
/*
File: fn_setRadarM.sqf
Author: ALF Team
*/
private["_radar"];
_radar = _this select 0;
if(_radar animationPhase "clic" > 0) exitWith {["Radar Mobile", "Impossible de paramétrer le Radar Mobile.", "warning", false] spawn ALF_fnc_doMsg;};

_speed = parseNumber(ctrlText 18552);
_amende = parseNumber(ctrlText 18553);

[_radar,_speed,_amende,player] remoteExec ["ALF_Server_fnc_setRadarM",2];

closeDialog 0;
