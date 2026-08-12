#include "\ALF_Client\script_macros.hpp"
/*
	File: fn_soignerPompier.sqf
	Author: ALF Nanou
*/
private["_curObj"];
_curObj = _this select 0;
if (isNil "_curObj" OR {isNull _curObj}) exitWith {};

life_action_inUse = true;
private _cP = 0.05;
for "_i" from 0 to 1 step 0 do 
{
	if(animationState player != "AinvPknlMstpSnonWnonDnon_medic_1") then 
	{
		//[player,"AinvPknlMstpSnonWnonDnon_medic_1",true] remoteExecCall ["ALF_fnc_animSync",RCLIENT];
		player switchMove "AinvPknlMstpSnonWnonDnon_medic_1";
		player playMoveNow "AinvPknlMstpSnonWnonDnon_medic_1";
	};

	sleep 0.3;

	_cP = _cP + 0.05;
	if(_cP >= 1) exitWith {};
	if(!alive player) exitWith {};
	if(life_interrupted) exitWith {};
	if(life_istazed) exitWith {};
};

life_action_inUse = false;
if(!alive player) exitWith {};
if(life_interrupted) exitWith {life_interrupted = false;["INFO", "Action annulée.", "danger"] spawn ALF_fnc_doMsg;};
if(life_istazed) exitWith {};
player playActionNow "stop";
player switchMove "";

_curObj setDamage 0;
["ALF_Bandage",false] spawn ALF_fnc_handleItem;

["SOIN", "Vous avez soigné cette personne.", "success"] spawn ALF_fnc_doMsg;
["INFO", "Vous avez été soigné.", "success"] remoteExec ["ALF_fnc_doMsg",_curObj];