
params [
	["_vehicle",objNull,[objNull]],
	["_unit",objNull,[objNull]],
	["_storetext","",[""]]
];


private _ownerID = _unit getVariable ["ALF_ownerID",-1];
if (isNull _vehicle) exitWith {};

private _vInfo = _vehicle getVariable["dbInfo",[]];
if (count _vInfo isEqualTo 0) exitWith {};

private _plate = _vInfo select 1;
private _uid = _vInfo select 0;
private _insure = _vInfo select 2;

if (_insure > 0) then {
	[format["UPDATE vehicles SET insure='0' WHERE pid='%1' AND plate='%2'",_uid ,_plate],1] call ALF_Server_fnc_asyncCall;
} else {
	private _query = format["DELETE FROM vehicles WHERE pid='%1' AND plate='%2'",_uid ,_plate];
	[_query,1] call ALF_Server_fnc_asyncCall;
};
private _query = format["UPDATE vehicles SET active='0' WHERE pid='%1' AND plate='%2'",_uid ,_plate];
[_query,1] call ALF_Server_fnc_asyncCall;

{
	detach _x;
	deleteVehicle _x;
} forEach (attachedObjects _vehicle);

if (!isNil "_vehicle" AND {!isNull _vehicle}) then {deleteVehicle _vehicle;};

["Receleur",_storetext,"success"] remoteExec ["ALF_fnc_doMsg",_ownerID];


_classname = typeOf _vehicle;
/*[_classname] remoteExecCall ["ALF_Server_fnc_vehicleStockAfterSell",2];*/

_vehicles = missionNamespace getVariable ["MRP_vehicle_to_search",[]];
_vehicles = _vehicles - [_classname];
missionNamespace setVariable ["MRP_vehicle_to_search",_vehicles,true];