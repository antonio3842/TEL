#include "\ALF_Client\script_macros.hpp"
/*
File: fn_cbParametre.sqf
Author: ALF Team
Description: Parametrer sa carte bleu

*/
private["_uid","_mode"];
_mode = _this select 0;
_uid = getPlayerUID player;

switch (_mode) do {
	case 0 : {
		_action = ["Voulez-vous lier votre carte bancaire au Livret A.","Credit Mutuel","OUI","NON"] call BIS_fnc_guiMessage;
		if (!_action) exitWith {};
		if (life_activecb isEqualTo 1) exitWith {["Credit Mutuel", "Ta carte bancaire est dejà liee à ce compte.", "danger", false] spawn ALF_fnc_doMsg;};
		life_activecb = 1;
		[_uid,1] remoteExecCall ["ALF_Server_fnc_cbParametre",2];
		[0] spawn ALF_fnc_updateCompteBancaire;
	};
	case 1 : {
		_action = ["Voulez-vous lier votre carte bancaire au Livret B.","Credit Mutuel","OUI","NON"] call BIS_fnc_guiMessage;
		if (!_action) exitWith {};
		if (life_activecb isEqualTo 2) exitWith {["Credit Mutuel", "Ta carte bancaire est dejà liee à ce compte.", "danger", false] spawn ALF_fnc_doMsg;};
		life_activecb = 2;
		[_uid,2] remoteExecCall ["ALF_Server_fnc_cbParametre",2];
		[1] spawn ALF_fnc_updateCompteBancaire;
	};
	case 2 : {
		_action = ["Voulez-vous lier votre carte bancaire au Livret C.","Credit Mutuel","OUI","NON"] call BIS_fnc_guiMessage;
		if (!_action) exitWith {};
		if (life_activecb isEqualTo 3) exitWith {["Credit Mutuel", "Ta carte bancaire est dejà liee à ce compte.", "danger", false] spawn ALF_fnc_doMsg;};
		life_activecb = 3;
		[_uid,3] remoteExecCall ["ALF_Server_fnc_cbParametre",2];
		[2] spawn ALF_fnc_updateCompteBancaire;
	};
};
