#include "\ALF_Client\script_macros.hpp"
/*
	File: fn_keyGiveDefRemoveHouse.sqf
	Author: ALF Dev Team
	
	Description:
	Retire une maison de la liste life_houses après confirmation serveur
*/
params [
	["_houseIndex", -1, [0]]
];

if (_houseIndex >= 0 && _houseIndex < count life_houses) then {
	life_houses deleteAt _houseIndex;
	systemChat format ["[KEYBILL DEBUG] Maison retirée de la liste (index: %1)", _houseIndex];
} else {
	systemChat format ["[KEYBILL DEBUG] ERREUR: Index invalide pour retirer la maison (index: %1, count: %2)", _houseIndex, count life_houses];
};

