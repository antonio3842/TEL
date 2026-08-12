#include "\ALF_Client\script_macros.hpp"
/*
	File: fn_giveMoney.sqf
	Author: ALF Team
	Description:

*/
private["_unit","_amount"];
_amount = ctrlText 123453;

if((time - life_action_delay) < 10) exitWith {hint "Vous appuyez trop vite.";};
life_action_delay = time;

_unit = cursorObject;
if(isNil "_unit") exitWith {["INFO","Impossible de donner de l'argent.", "danger", false] spawn ALF_fnc_doMsg;};
if(isNull _unit) exitWith {["INFO","Impossible de donner de l'argent.", "danger", false] spawn ALF_fnc_doMsg;};
if(_unit isEqualTo player) exitWith {["INFO","Impossible de donner de l'argent.", "danger", false] spawn ALF_fnc_doMsg;};
if!(_unit isKindOf "Man") exitWith {["INFO","Il n'y a personne en face de vous.", "danger", false] spawn ALF_fnc_doMsg;};
if(!isPlayer _unit) exitWith {["INFO","Il n'y a personne en face de vous.", "danger", false] spawn ALF_fnc_doMsg;};
if(!alive _unit) exitWith {["INFO","Cette personne est morte.", "danger", false] spawn ALF_fnc_doMsg;};
if(!(player getVariable ["ALF_EnPrison",false]) && {_unit getVariable ["ALF_EnPrison",false]}) exitWith {["INFO","Cette personne est en prison.", "danger", false] spawn ALF_fnc_doMsg;};
if(!([_amount] call TON_fnc_isnumber)) exitWith {["INFO","Non conforme.", "danger", false] spawn ALF_fnc_doMsg;};

//A series of checks *ugh*
if(!life_use_atm) exitWith {["INFO","Vous ne pouvez pas donner d'argent pour l'instant.", "danger", false] spawn ALF_fnc_doMsg;};
if(parseNumber(_amount) <= 0) exitWith {["INFO","Non conforme.", "danger", false] spawn ALF_fnc_doMsg;};
if(parseNumber(_amount) > life_cash) exitWith {["INFO","Vous n'avez pas assez sur vous.", "danger", false] spawn ALF_fnc_doMsg;};

life_cash = life_cash - (parseNumber(_amount));
[0] call SOCK_fnc_updatePartial;

["INFO", format["Vous venez de donner %1€",[(parseNumber (_amount))] call ALF_fnc_numberText], "success", false] spawn ALF_fnc_doMsg;

private _giverName = name player;
private _giverUID = getPlayerUID player;
private _targetName = name _unit;
private _targetUID = getPlayerUID _unit;
private _amountNum = parseNumber(_amount);

[_giverName, getPlayerUID player, "GIVE", format["%1 a donné %2€ à %3. Cash restant pour %1 : %4€", _giverName, _amountNum, _targetName, life_cash]] remoteExec ["ALF_Server_fnc_logIt", 2];
[_amount,player] remoteExecCall ["ALF_fnc_receiveMoney",_unit];
[] call ALF_fnc_menuY;



