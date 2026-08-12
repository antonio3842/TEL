#include "\ALF_Client\script_macros.hpp"
/*
	File: fn_receiveMoney.sqf
	Author: ALF Team
	Description:

*/
private["_val","_unit"];
_val = _this select 0;
_unit = _this select 1;

if(_val isEqualTo "") exitWith {};
if(!([_val] call TON_fnc_isnumber)) exitWith {};

if ((time - life_receive_delay) < 10) exitWith {
    ["INFO", "Vous recevez de l'argent trop rapidement. Patientez un instant.", "warning", false] spawn ALF_fnc_doMsg;
};
life_action_delay = time;

["INFO", format["On vient de vous donner %1€",[(parseNumber (_val))] call ALF_fnc_numberText], "success", false] spawn ALF_fnc_doMsg;
life_cash = life_cash + parseNumber(_val);

private _receiverName = name player;
private _giverName = name _unit;
private _amountNum = parseNumber(_val);

[_receiverName, getPlayerUID player, "GIVE", format["%1 a reçu %2€ de %3. Cash actuel pour %1 : %4€", _receiverName, _amountNum, _giverName, life_cash]] remoteExec ["ALF_Server_fnc_logIt", 2];

//[name player,getPlayerUID player,"GIVE",format["A reçu %1€ de %2. Cash = %3€",parseNumber(_val),name _unit,life_cash]] remoteExec ["ALF_Server_fnc_logIt",2];
[0] call SOCK_fnc_updatePartial;
