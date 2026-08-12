#include "\ALF_Client\script_macros.hpp"
/*
	File: fn_keyGiveDefRemoveVehicle.sqf
	Author: ALF Dev Team
	
	Description:
	Retire un véhicule de la liste life_vehicles après confirmation serveur
*/
params [
	["_vehicleIndex", -1, [0]]
];

if (_vehicleIndex >= 0 && _vehicleIndex < count life_vehicles) then {
	life_vehicles deleteAt _vehicleIndex;
	systemChat format ["[KEYBILL DEBUG] Véhicule retiré de la liste (index: %1)", _vehicleIndex];
} else {
	systemChat format ["[KEYBILL DEBUG] ERREUR: Index invalide pour retirer le véhicule (index: %1, count: %2)", _vehicleIndex, count life_vehicles];
};

