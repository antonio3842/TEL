/*
	File: fn_removeFromHCFire.sqf
	Desc: Retire un bâtiment de la liste ALF_HC_Fire (appelé depuis client)
*/
params [["_building", objNull, [objNull]]];

if (isNull _building) exitWith {};

if (_building in ALF_HC_Fire) then {
	ALF_HC_Fire deleteAt (ALF_HC_Fire find _building);
	publicVariable "ALF_HC_Fire";
};
