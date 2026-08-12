#include "\ALF_Client\script_macros.hpp"
/*
	File: fn_medicLoadout.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Loads the medic out with the default gear.
*/
private["_handle"];
// _handle = [] spawn ALF_fnc_stripDownPlayer;
// waitUntil {scriptDone _handle};

player setUnitLoadout (configFile >> "EmptyLoadout");

player addUniform "U_Rangemaster";
player addItem "FirstAidKit";
player addItem "FirstAidKit";
player addItem "ItemMap";
player assignItem "ItemMap";
player addItem "ItemCompass";
player assignItem "ItemCompass";
player addItem "ItemWatch";
player assignItem "ItemWatch";

// NORX : on comment a priori cest censer sortir un truc mais est utiliser nul part, tout le script est pas utiliser a priori
// [] call ALF_fnc_saveGear;