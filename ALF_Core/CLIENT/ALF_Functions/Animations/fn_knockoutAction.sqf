#include "\ALF_Client\script_macros.hpp"
/*
    File: fn_knockoutAction.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Knocks out the target.
*/
private "_target";
_target = param [0,objNull,[objNull]];

//Error checks
if(isNull _target) exitWith {};
if(!isPlayer _target) exitWith {};
if(player distance _target > 4) exitWith {};
life_knockout = true;
[player,"AwopPercMstpSgthWrflDnon_End2"] remoteExecCall ["ALF_fnc_animSync",RCLIENT];
sleep 0.08;
[_target] remoteExec ["ALF_fnc_knockedOut",_target];
[] remoteExecCall ["ALF_fnc_CombatEffect",_target];
[name player,getPlayerUID player,"KNOCKOUT",format["A assomé %1 | POS : %2.",name _target, getPos player]] remoteExec ["ALF_Server_fnc_logIt",2];
sleep 3;
life_knockout = false;
