#include "\ALF_Client\script_macros.hpp"
/*
File: fn_badTransferHsbc.sqf
Author: ALF Team
Description: Reason

*/
private["_raison"];
_raison = _this select 0;

switch (_raison) do 
{
	case 0 : 
	{
		["HSBC","Ce compte en Suisse n'existe pas.", "danger", false] spawn ALF_fnc_doMsg;
	};
	case 1 : 
	{
		["HSBC","Vous ne pouvez pas vous transférer de l'argent à vous-même.", "danger", false] spawn ALF_fnc_doMsg;
	};
};
