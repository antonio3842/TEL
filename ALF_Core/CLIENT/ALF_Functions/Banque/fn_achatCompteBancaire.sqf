#include "\ALF_Client\script_macros.hpp"
/*
File: fn_achatCompteBancaire.sqf
Author: ALF Team
Description: Achat du compte bancaire

*/
private["_display","_mode","_uid"];
_mode = _this select 0;
_uid = getPlayerUID player;

switch (_mode) do {
	case 0 : {
		_price = 250;
		_action = [format["Voulez-vous acheter un Livret A pour %1€. La somme sera prélevé en cash.",_price],"Credit Mutuel","OUI","NON"] call BIS_fnc_guiMessage;
		if (!_action) exitWith {};
		if(life_cash < _price) exitWith {["Credit Mutuel", format["Il vous manque %1€ pour acheter un Livret A.",_price - life_cash], "danger", false] spawn ALF_fnc_doMsg;};
		life_cash = life_cash - _price;
		life_laactive = true;
		[_uid,0,player] remoteExecCall ["ALF_Server_fnc_achatCompteBancaire",2];
		[0] call SOCK_fnc_updatePartial;
		["Credit Mutuel", format["Vous avez ouvert un compte de type Livret A pour %1€",_price], "success", false] spawn ALF_fnc_doMsg;
		[name player,getPlayerUID player,"BANK","A acheté un Livret A."] remoteExec ["ALF_Server_fnc_logIt",2];
	};

	case 1 : {
		_price = 2500;
		_action = [format["Voulez-vous acheter un Livret B pour %1€. La somme sera prélevé depuis votre Livret A.",_price],"Credit Mutuel","OUI","NON"] call BIS_fnc_guiMessage;
		if (!_action) exitWith {};
		if (!life_laactive) exitWith {["Credit Mutuel", "Il vous faut un Livret A pour pouvoir acheter un Livret B.", "danger", false] spawn ALF_fnc_doMsg;};
		if(life_livreta < 50000) exitWith {["Credit Mutuel", format["Il vous manque %1€ sur votre Livret A pour acheter un Livret B.",50000 - life_livreta], "danger", false] spawn ALF_fnc_doMsg;};
		life_livreta = life_livreta - _price;
		life_lbactive = true;
		[_uid,1,player] remoteExecCall ["ALF_Server_fnc_achatCompteBancaire",2];
		[6] call SOCK_fnc_updatePartial;
		["Credit Mutuel", format["Vous avez ouvert un compte de type Livret B pour %1€. Le solde à été prélevé depuis votre Livret A.",_price], "success", false] spawn ALF_fnc_doMsg;
		[name player,getPlayerUID player,"BANK","A acheté un Livret B."] remoteExec ["ALF_Server_fnc_logIt",2];
	};
	case 2 : {
		_price = 15000;
		_action = [format["Voulez-vous acheter un Livret C pour %1€. La somme sera prélevé depuis votre Livret B.",_price],"Credit Mutuel","OUI","NON"] call BIS_fnc_guiMessage;
		if (!_action) exitWith {};
		if (!life_lbactive) exitWith {["Credit Mutuel", "Il vous faut un Livret B pour pouvoir acheter un Livret C.", "danger", false] spawn ALF_fnc_doMsg;};
		if(life_livretb < 350000) exitWith {["Credit Mutuel", format["Il vous manque %1€ sur votre Livret B pour acheter un Livret C.",350000 - life_livretb], "danger", false] spawn ALF_fnc_doMsg;};
		life_livretb = life_livretb - _price;
		life_lcactive = true;
		[_uid,2,player] remoteExecCall ["ALF_Server_fnc_achatCompteBancaire",2];
		[7] call SOCK_fnc_updatePartial;
		["Credit Mutuel", format["Vous avez ouvert un compte de type Livret C pour %1€. Le solde à été prélevé depuis votre Livret B.",_price], "success", false] spawn ALF_fnc_doMsg;
		[name player,getPlayerUID player,"BANK","A acheté un Livret C."] remoteExec ["ALF_Server_fnc_logIt",2];
	};
};
