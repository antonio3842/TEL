#include "\ALF_Client\script_macros.hpp"
/*
File: fn_afterTransferCompteBancaire.sqf
Author: ALF Team
Description: Suite du script

*/
private["_numacc","_uidcible","_mode","_number","_isSiret","_businessName"];
_numacc = _this select 0;
_mode = _this select 1;
_number = _this select 2;
_isSiret = _this param [3, false, [false]];
_businessName = _this param [4, "", [""]];

switch (_mode) do {
	case 0 : {
		life_livreta = life_livreta - _number;
		if (_isSiret && _businessName != "") then {
			["Credit Mutuel", format["Vous avez transfere %1€ de votre Livret A vers l'entreprise %2 (SIRET: %3).",_number,_businessName,_numacc], "success", false] spawn ALF_fnc_doMsg;
			[name player,getPlayerUID player,"BANK",format["A tranfere %1€ du Livret A vers l'entreprise %2 (SIRET: %3). Livret A = %4€",_number,_businessName,_numacc,life_livreta]] remoteExec ["ALF_Server_fnc_logIt",2];
		} else {
			["Credit Mutuel", format["Vous avez transfere %1€ de votre Livret A sur le compte numero %2.",_number,_numacc], "success", false] spawn ALF_fnc_doMsg;
			[name player,getPlayerUID player,"BANK",format["A tranfere %1€ du Livret A vers le compte numero %2. Livret A = %3€",_number,_numacc,life_livreta]] remoteExec ["ALF_Server_fnc_logIt",2];
		};
		[0] spawn ALF_fnc_updateCompteBancaire;
		[6] call SOCK_fnc_updatePartial;
	};

	case 1 : {
		life_livretb = life_livretb - _number;
		if (_isSiret && _businessName != "") then {
			["Credit Mutuel", format["Vous avez transfere %1€ de votre Livret B vers l'entreprise %2 (SIRET: %3).",_number,_businessName,_numacc], "success", false] spawn ALF_fnc_doMsg;
			[name player,getPlayerUID player,"BANK",format["A tranfere %1€ du Livret B vers l'entreprise %2 (SIRET: %3). Livret B = %4€",_number,_businessName,_numacc,life_livretb]] remoteExec ["ALF_Server_fnc_logIt",2];
		} else {
			["Credit Mutuel", format["Vous avez transfere %1€ de votre Livret B sur le compte numero %2.",_number,_numacc], "success", false] spawn ALF_fnc_doMsg;
			[name player,getPlayerUID player,"BANK",format["A tranfere %1€ du Livret B vers le compte numero %2. Livret B = %3€",_number,_numacc,life_livretb]] remoteExec ["ALF_Server_fnc_logIt",2];
		};
		[1] spawn ALF_fnc_updateCompteBancaire;
		[7] call SOCK_fnc_updatePartial;
	};

	case 2 : {
		life_livretc = life_livretc - _number;
		if (_isSiret && _businessName != "") then {
			["Credit Mutuel", format["Vous avez transfere %1€ de votre Livret C vers l'entreprise %2 (SIRET: %3).",_number,_businessName,_numacc], "success", false] spawn ALF_fnc_doMsg;
			[name player,getPlayerUID player,"BANK",format["A tranfere %1€ du Livret C vers l'entreprise %2 (SIRET: %3). Livret C = %4€",_number,_businessName,_numacc,life_livretc]] remoteExec ["ALF_Server_fnc_logIt",2];
		} else {
			["Credit Mutuel", format["Vous avez transfere %1€ de votre Livret C sur le compte numero %2.",_number,_numacc], "success", false] spawn ALF_fnc_doMsg;
			[name player,getPlayerUID player,"BANK",format["A tranfere %1€ du Livret C vers le compte numero %2. Livret C = %3€",_number,_numacc,life_livretc]] remoteExec ["ALF_Server_fnc_logIt",2];
		};
		[2] spawn ALF_fnc_updateCompteBancaire;
		[8] call SOCK_fnc_updatePartial;
	};
};


