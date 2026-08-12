// /*
// 	Author : ALF - Adam
// */
// alf_fnc_playMachineSlot = {
private _machine = param [0,objnull];
private _mise = param [1,10];

if (isNull _machine OR {isNil "_machine"}) exitWith {["CASINO", "Machine hors-service", "danger"] spawn ALF_fnc_doMSG;};

if !(_machine getVariable ["isOn",false]) exitWith {["CASINO", "Cette machine est éteinte.", "danger"] spawn ALF_fnc_doMSG;};

if !(_machine getvariable ["machine_Dispo",TRUE]) exitwith {["CASINO", "La machine est en cours d'utilisation", "danger"] spawn ALF_fnc_doMSG;};

if (life_cash < _mise) exitWith {["CASINO", format ["Vous n'avez pas l'argent suffisant pour miser %1€.",_mise], "danger"] spawn ALF_fnc_doMSG;};
life_cash = life_cash - _mise;

["CASINO", format ["Vous venez de jouer pour %1 €, il vous reste %2 € en liquide",_mise,life_cash tofixed 0], "info"] spawn ALF_fnc_doMSG;

_machine setvariable ["machine_Dispo",FALSE,true];
[_machine,_mise,player] remoteExec ["ALF_Server_fnc_playSlotMachine",2];
[20, _mise] remoteExec ["ALF_Server_fnc_addCapitalBySecteur", 2];
// };