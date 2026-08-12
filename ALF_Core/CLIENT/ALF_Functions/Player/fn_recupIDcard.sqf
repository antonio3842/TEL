#include "\ALF_Client\script_macros.hpp"
/*
	File: fn_recupIDcard.sqf
	ALF Nanou
*/
if("ALF_identite" in (magazines player)) exitWith {["INFO","Vous avez deja une carte d'identite sur vous.","warning"] spawn ALF_fnc_doMsg;};
if !(player canAdd "ALF_identite") exitWith {["INFO","Vous n'avez pas assez de place sur vous.","warning"] spawn ALF_fnc_doMsg;};

["ALF_identite",true] spawn ALF_fnc_handleItem;
["INFO","Vous venez de recuperer votre carte d'identite.","success"] spawn ALF_fnc_doMsg;
