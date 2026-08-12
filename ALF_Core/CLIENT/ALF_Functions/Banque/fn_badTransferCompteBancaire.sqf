#include "\ALF_Client\script_macros.hpp"
/*
File: fn_badTransferCompteBancaire.sqf
Author: ALF Team
Description: Reason

*/
private["_raison"];
_raison = _this # 0;

switch (_raison) do 
{
	case 0 : {["Crédit Mutuel","Le compte bancaire ou l'entreprise n'existe pas.", "danger", false] spawn ALF_fnc_doMsg;	};
	case 1 : {["Crédit Mutuel","Vous ne pouvez pas vous transférer de l'argent à vous même.", "danger", false] spawn ALF_fnc_doMsg;};
	case 2 : {["Crédit Mutuel","Le compte cible n'a pas de Livret B.", "danger", false] spawn ALF_fnc_doMsg;};
	case 3 : {["Crédit Mutuel","Le compte cible n'a pas de Livret C.", "danger", false] spawn ALF_fnc_doMsg;};
	case 4 : {["Crédit Mutuel","Vous envoyez trop d'argent.", "danger", false] spawn ALF_fnc_doMsg;};
	case 5 : {["Crédit Mutuel","Vous envoyez trop d'argent.", "danger", false] spawn ALF_fnc_doMsg;};
};