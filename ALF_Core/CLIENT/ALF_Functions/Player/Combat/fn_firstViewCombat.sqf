/*
	File: fn_firstViewCombat.sqf
	Author: Nanou
*/
params [
	["_unit",objNull,[objNull]],
	["_vehicle",objNull,[objNull]],
	["_distance",-1,[-1]],
	["_weapon","",[""]],
	["_muzzle","",[""]],
	["_mode","",[""]],
	["_ammo","",[""]],
	["_gunner",objNull,[objNull]]
];

//if (ALF_AdminLevel >= 2) exitWith {};
if ((player distance getMarkerPos "hunting_zone") < 500) exitWith {};
if (_weapon in ["ByScream_LDV500","ByScream_Extincteur","ByScream_LDT","ALF_Hache","ALF_Pioche","MPR_Pelle","ALF_Batte","ALF_Faux","MRP_X26","ALF_Couteau","ALF_FireNozzle","ALF_Katana","ALF_CanneAPeche","hgun_Pistol_Signal_F","Math_crossbow_black","KA_knife","KA_dagger"]) exitWith {};

life_combatTime = time;
if !(life_firstCombatActive) then {
	[] spawn {
		life_firstCombatActive = true;
		for "_i" from 0 to 1 step 0 do {
			if (((time - life_combatTime) > 60)) exitWith {life_firstCombatActive = false;};
			if (toLower (cameraView) isEqualTo "external") then {
				player switchCamera "Internal";
			};
			sleep 0.5; // PERF FIX: Ajout sleep pour éviter spin-lock CPU
		};
	};
};
