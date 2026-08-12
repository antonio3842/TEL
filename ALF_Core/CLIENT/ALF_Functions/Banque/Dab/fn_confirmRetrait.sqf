/*
	File: fn_confirmRetrait.sqf
	Author: ALF Dev Team
	Description: Callback appele par HC3 apres validation du retrait DAB
*/

params [
	["_montant", 0, [0]],
	["_livret", 1, [0]]
];

if (_montant <= 0) exitWith {};

switch (_livret) do {
	case 1: {
		life_livreta = life_livreta - _montant;
		life_cash = life_cash + _montant;
		["Distributeur", format["Vous avez retire %1€ de votre Livret A.", _montant], "success"] spawn ALF_fnc_doMsg;
		[name player, getPlayerUID player, "BANK", format["A retire %1€ de son Livret A. Livret A = %2€ | Cash = %3€", _montant, life_livreta, life_cash]] remoteExec ["ALF_Server_fnc_logIt", 2];
		[6] call SOCK_fnc_updatePartial;
		[0] call SOCK_fnc_updatePartial;
	};
	case 2: {
		life_livretb = life_livretb - _montant;
		life_cash = life_cash + _montant;
		["Distributeur", format["Vous avez retire %1€ de votre Livret B.", _montant], "success"] spawn ALF_fnc_doMsg;
		[name player, getPlayerUID player, "BANK", format["A retire %1€ de son Livret B. Livret B = %2€ | Cash = %3€", _montant, life_livretb, life_cash]] remoteExec ["ALF_Server_fnc_logIt", 2];
		[7] call SOCK_fnc_updatePartial;
		[0] call SOCK_fnc_updatePartial;
	};
	case 3: {
		life_livretc = life_livretc - _montant;
		life_cash = life_cash + _montant;
		["Distributeur", format["Vous avez retire %1€ de votre Livret C.", _montant], "success"] spawn ALF_fnc_doMsg;
		[name player, getPlayerUID player, "BANK", format["A retire %1€ de son Livret C. Livret C = %2€ | Cash = %3€", _montant, life_livretc, life_cash]] remoteExec ["ALF_Server_fnc_logIt", 2];
		[8] call SOCK_fnc_updatePartial;
		[0] call SOCK_fnc_updatePartial;
	};
};

[] call ALF_fnc_updateDab;
