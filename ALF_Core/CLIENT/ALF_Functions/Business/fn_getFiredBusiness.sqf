#include "\ALF_Client\script_macros.hpp"
/*
File: getFiredBusiness.sqf
Author: ALF Nanou
*/
private["_secteur"];
_secteur = _this select 0;

["INFO","Vous avez été viré par votre employeur.","success"] spawn ALF_fnc_doMsg;
