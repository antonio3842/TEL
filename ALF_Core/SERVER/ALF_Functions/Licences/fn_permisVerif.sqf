/*
	File: fn_permisVerif.sqf
	Author : NANOU
*/
params[
	["_unit",objNull,[objNull]],
	["_veh",objNull,[objNull]],
	["_pos",[],[[]]]
];
if(isNull _unit OR {isNull _veh} OR {!(count(_pos) isEqualTo 3)}) exitWith {};

_pos = [_pos] call ALF_Server_fnc_mresArray;
private _uid = getPlayerUID _unit;

private _query = format["UPDATE players SET position='%1' WHERE playerid='%2'",_pos,_uid];

for "_i" from 0 to 1 step 0 do {
	if (isNull _veh) exitWith {};
	if (isNull _unit AND !isNull _veh) exitWith {deleteVehicle _veh; [_query,1] call ALF_Server_fnc_asyncCall;};
	uiSleep 5;
};
