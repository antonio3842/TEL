#include "\ALF_Client\script_macros.hpp"
/*
    File: fn_recupPermis.sqf
    ALF Nanou
*/
if !(license_driver) exitWith {["INFO","La prefecture ne trouve pas votre dossier.","warning"] spawn ALF_fnc_doMsg;};
if("ALF_Permis" in (magazines player)) exitWith {["INFO","Vous avez deja votre permis sur vous.","warning"] spawn ALF_fnc_doMsg;};
if !(player canAdd "ALF_Permis") exitWith {["INFO","Vous n'avez pas assez de place sur vous.","warning"] spawn ALF_fnc_doMsg;};

["ALF_Permis",true] spawn ALF_fnc_handleItem;
["INFO","Vous venez de recuperer votre permis.","success"] spawn ALF_fnc_doMsg;
