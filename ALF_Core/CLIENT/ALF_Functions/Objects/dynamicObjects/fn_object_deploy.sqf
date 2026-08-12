_item = [_this,0,"",[""]] call BIS_fnc_param;

if (_item isEqualTo "") exitWith {};
if !(isNull alf_object) exitWith {};

private _config = [];
private _allObjects = ["CLASSES", ["ALF_OBJECTS"]] call ALFTools_Client_Config_fnc_getConfig;
{
	private _itemName = ["STRING", ["item"], _y] call ALFTools_Client_Config_fnc_getConfig;
	if (_itemName isEqualTo _item) exitWith {_config = [_x, _y];};
}forEach _allObjects;
if (isNil "_config") exitWith {};

private _object = (_config#0) createVehicle [0,0,0];
private _attachTo = ["ARRAY", ["attachTo"], _config#1] call ALFTools_Client_Config_fnc_getConfig;
_object attachTo [player,_attachTo];
_object allowdamage false;
[_object] call ALF_fnc_clearVehicleAmmo;
[_object,true] remoteExecCall ["enableDynamicSimulation",2];
_object setVectorUp (surfaceNormal position _object);
alf_object = _object;

private _action1 = player addAction ["Placer",{detach alf_object;{_x disableCollisionWith alf_object;} forEach (nearestObjects [getPos alf_object,["Car","Air","Ship"],5]);},"",9999,true,true,"",'!(isNull alf_object)'];
waitUntil {((isNull _object) || (isNull (attachedTo _object)))};

alf_object = objNull;
_object setPosATL [(getPosATL _object select 0),(getPosATL _object select 1),(getPosATL player) select 2];
player removeAction _action1;

if (isNull _object) exitWith {};

if (_item in (magazines player)) then {
	player removeMagazine _item;
} else {
	deleteVehicle _object;
};
