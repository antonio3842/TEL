/*
	File: fn_vehicleStoreCopSP.sqf
	Author: ALF TEAM
*/
params [
	["_vehicle",objNull,[objNull]],
	["_unit",objNull,[objNull]],
	["_garage",0,[0]]
];

private _ownerID = _unit getVariable ["ALF_ownerID",-1];
if(isNull _vehicle OR {isNull _unit}) exitWith {life_garage_store = false; _ownerID publicVariableClient "life_garage_store";};

private _vInfo = _vehicle getVariable["dbInfo",[]];
if(count _vInfo isEqualTo 0) exitWith {
	["GARAGE","Erreur de stockage (fn_vehicleStore #1).","warning"] remoteExec ["ALF_fnc_doMsg",_ownerID];
	life_garage_store = false;
	_ownerID publicVariableClient "life_garage_store";
};

private _plateRaw = _vInfo select 1;
private _plate = if (_plateRaw isEqualType []) then {[_plateRaw] call ALF_Server_fnc_mresArray} else {_plateRaw};
if !(_plate isEqualType "") then {_plate = format["%1", _plate];};

private _damage = [((getAllHitPointsDamage _vehicle) select 2)] call ALF_Server_fnc_mresArray;

private _query = "";
_query = format["UPDATE vehicles_penit SET active='0', fuel='%2', damage='%3', gear='""[]""', id_garage='%4' WHERE plate='%1'",_plate,(fuel _vehicle), _damage,_garage];
[_query,1] call ALF_Server_fnc_asyncCall;

{
	detach _x;
	deleteVehicle _x;
} forEach (attachedObjects _vehicle);

if (!isNil "_vehicle" && {!isNull _vehicle}) then {
	deleteVehicle _vehicle;
};

life_garage_store = false;
_ownerID publicVariableClient "life_garage_store";
