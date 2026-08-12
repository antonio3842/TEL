/*
	File: fn_vehicleJobStore.sqf
	Author: ALF TEAM
*/
params [
	["_vehicle",objNull,[objNull]],
	["_unit",objNull,[objNull]]
];

if(isNull _unit OR {isNull _vehicle}) exitWith {life_garage_store = false; _ownerID publicVariableClient "life_garage_store";};

private _ownerID = _unit getVariable ["ALF_ownerID",-1];

private _vInfo = _vehicle getVariable["dbInfo",[]];
if !(count _vInfo isEqualTo 2) exitWith {
	["GARAGE","Vous ne pouvez pas ranger ce véhicule ici.","warning"] remoteExec ["ALF_fnc_doMsg",_ownerID];
	life_garage_store = false;
	_ownerID publicVariableClient "life_garage_store";
};

private _plateRaw = _vInfo select 1;
private _plate = if (_plateRaw isEqualType []) then {[_plateRaw] call ALF_Server_fnc_mresArray} else {_plateRaw};
if !(_plate isEqualType "") then {_plate = format["%1", _plate];};

private _query = format["UPDATE vehicles SET active='0' WHERE pid='%1' AND plate='%2'", _vInfo select 0, _plate];
[_query,1] call ALF_Server_fnc_asyncCall;

{
	detach _x;
	deleteVehicle _x;
} forEach (attachedObjects _vehicle);

if (!isNil "_vehicle" && {!isNull _vehicle}) then {deleteVehicle _vehicle;};

life_garage_store = false;
_ownerID publicVariableClient "life_garage_store";
["INFO","Votre véhicule de service a été rangé dans le garage.","success"] remoteExec ["ALF_fnc_doMsg",_ownerID];
