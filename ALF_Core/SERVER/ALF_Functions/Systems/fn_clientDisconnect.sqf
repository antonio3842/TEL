/*
	File: fn_clientDisconnect.sqf
	Author: Bryan "Tonic" Boardwine

	unit: Object - unit formerly occupied by player
	id: Number - same as _id in onPlayerDisconnected
	uid: String - same as _uid in onPlayerDisconnected
	name: String - same as _name in onPlayerDisconnected
*/

params[
	["_unit",objNull,[objNull]],
	["_id",0,[0]],
	["_uid","",[""]],
	["_name","",[""]]
];

//ERROR SPOTED?!
if (isNull _unit) exitWith {};

// Si le joueur na pas pus s'initialiser correctement et est invisible, on ne sauvegarde pas son état buggé. A voir si c pas chiant pr les admins
if (isObjectHidden _unit) exitWith {};

//Save player info
private _pos = getPosatl _unit;
// Sauvegarde côté serveur - utilise _unit (pas player qui est objNull côté serveur)
private _equipement = [_unit] call ALF_Server_fnc_saveGear;
diag_log _equipement;

[_uid,_pos,_equipement] call ALF_Server_fnc_savePlayerDisconnect;

private _cleanup = nearestObjects[_unit,["WeaponHolderSimulated"],5];
{deleteVehicle _x;} forEach _cleanup;
deleteVehicle _unit;

private _array2 = missionNamespace getVariable ["ALF_AllBracelets",[]];
_array2 = _array2 - [objNull];

if !((count _array2) isEqualTo (count (missionNamespace getVariable ["ALF_AllBracelets",[]]))) then 
{
	missionNamespace setVariable ["ALF_AllBracelets",_array2,true];
};

// [_uid] call ALF_Server_fnc_houseCleanup;
[] call ALF_Server_fnc_disconnectService;