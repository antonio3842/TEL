#include "\ALF_Client\script_macros.hpp"
/*
File: fn_transferExtCompteBancaire.sqf
Author: ALF Team
Description: Transferer de compte a compte externe

*/
private["_mode"];
_mode = _this select 0;

if((time - life_action_delay) < 1) exitWith {hint "Vous appuyez trop vite.";};
life_action_delay = time;

disableSerialization;
_display = findDisplay 22500;
_number = parseNumber(ctrlText 22513);
_numacc = ctrlText 22514;
// Nettoyer le numéro de compte/SIRET (supprimer les espaces)
_numacc = _numacc splitString " " joinString "";

if(!([str(_number)] call TON_fnc_isnumber)) exitWith {["Crédit Mutuel", "Non conforme.", "danger", false] spawn ALF_fnc_doMsg;};

// Vérifier si c'est un SIRET (commence par "732") ou un numéro de compte
_isSiret = false;
if (count _numacc == 9 && (_numacc select [0,3]) == "732") then {
	// C'est un SIRET, vérifier que c'est bien un nombre
	if !([_numacc] call TON_fnc_isnumber) exitWith {["Crédit Mutuel", "SIRET incorrect.", "danger", false] spawn ALF_fnc_doMsg;};
	_isSiret = true;
} else {
	// C'est un numéro de compte bancaire
	if !([_numacc] call TON_fnc_isnumber) exitWith {["Crédit Mutuel", "Numero de compte incorrect.", "danger", false] spawn ALF_fnc_doMsg;};
};

if(_number < 0) exitWith {["Crédit Mutuel", "Ce nombre est négatif.", "danger", false] spawn ALF_fnc_doMsg;};
if(_number > 999999) exitWith {["Crédit Mutuel", "Ce nombre est trop grand.", "danger", false] spawn ALF_fnc_doMsg;};

	switch (_mode) do {

	case 0 : {
		if (life_livreta < _number) exitWith {["Crédit Mutuel", "Vous n'avez pas assez de fond sur votre Livret A.", "danger", false] spawn ALF_fnc_doMsg;};
		[_numacc,0,player,_number,getPlayerUID player,_isSiret] remoteExecCall ["ALF_Server_fnc_transferExtCompteBancaire",2];
	};

	case 1 : {
		if (life_livretb < _number) exitWith {["Crédit Mutuel", "Vous n'avez pas assez de fond sur votre Livret B.", "danger", false] spawn ALF_fnc_doMsg;};
		[_numacc,1,player,_number,getPlayerUID player,_isSiret] remoteExecCall ["ALF_Server_fnc_transferExtCompteBancaire",2];
	};

	case 2 : {
		if (life_livretc < _number) exitWith {["Crédit Mutuel", "Vous n'avez pas assez de fond sur votre Livret C.", "danger", false] spawn ALF_fnc_doMsg;};
		[_numacc,2,player,_number,getPlayerUID player,_isSiret] remoteExecCall ["ALF_Server_fnc_transferExtCompteBancaire",2];	
	};

};
