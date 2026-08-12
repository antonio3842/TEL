#include "\ALF_Client\script_macros.hpp"
/*
File: fn_retirerDab.sqf
Author: ALF Team
*/
if((time - life_action_delay) < 0.3) exitWith {["Distributeur", "Vous appuyez trop vite.", "warning"] spawn ALF_fnc_doMsg;};
life_action_delay = time;
disableSerialization;

private _number = parseNumber(ctrlText 10526);

if(!([str(_number)] call TON_fnc_isnumber)) exitWith {["Distributeur", "Non conforme.", "danger"] spawn ALF_fnc_doMsg;};
if(_number < 1) exitWith {["Distributeur", "Ce nombre est incorret.", "danger"] spawn ALF_fnc_doMsg;};
if(_number > 50000) exitWith {["Distributeur", "Ce nombre est trop grand.", "danger"] spawn ALF_fnc_doMsg;};
if(life_livreta < 0) exitWith {["Credit Mutuel", "Vos comptes sont actuellement bloqués. Merci de renflouer votre livret A.", "danger", false] spawn ALF_fnc_doMsg;};

// Calculer la position du DAB
private _dab = nearestObjects [player, ["Land_ALF_ATM"], 3] # 0;
private _pos = getPos _dab;
private _posKey = format ["%1_%2", round (_pos # 0), round (_pos # 1)];

private _exit = false;
private _livret = life_activecb;

switch (_livret) do {
	case 1 : {
		if (life_livreta < _number) exitWith {["Distributeur", "Vous n'avez pas cet argent sur votre Livret A.", "danger"] spawn ALF_fnc_doMsg; _exit = true;};
	};
	case 2 : {
		if (life_livretb < _number) exitWith {["Distributeur", "Vous n'avez pas cet argent sur votre Livret B.", "danger"] spawn ALF_fnc_doMsg; _exit = true;};
		if (life_livreta < 0) exitWith {["Credit Mutuel", "Vos comptes sont actuellement bloqués. Merci de renflouer votre livret A.", "danger", false] spawn ALF_fnc_doMsg; _exit = true;};
	};
	case 3 : {
		if (life_livretc < _number) exitWith {["Distributeur", "Vous n'avez pas cet argent sur votre Livret C.", "danger"] spawn ALF_fnc_doMsg; _exit = true;};
		if (life_livreta < 0) exitWith {["Credit Mutuel", "Vos comptes sont actuellement bloqués. Merci de renflouer votre livret A.", "danger", false] spawn ALF_fnc_doMsg; _exit = true;};
	};
};
if (_exit) exitWith {};

// Envoyer au HC3 pour verification BDD - argent modifie seulement apres confirmation
[_posKey, _number, clientOwner, _livret] remoteExec ["ALF_Server_fnc_retraitDAB", hc_3];
