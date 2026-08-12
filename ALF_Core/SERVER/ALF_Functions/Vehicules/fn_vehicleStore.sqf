// ALF_Server_fnc_vehicleStore = {
params [
	["_vehicle",objNull,[objNull]],
	["_unit",objNull,[objNull]],
	["_storetext","",[""]]
];


private _ownerID = _unit getVariable ["ALF_ownerID",-1];
if (isNull _vehicle OR {isNull _unit}) exitWith {life_garage_store = false; _ownerID publicVariableClient "life_garage_store";};

private _vInfo = _vehicle getVariable["dbInfo",[]];
if (count _vInfo isEqualTo 0) exitWith 
{
	["GARAGE","Erreur de stockage (fn_vehicleStore #1).","warning"] remoteExec ["ALF_fnc_doMsg",_ownerID];
	life_garage_store = false;
	_ownerID publicVariableClient "life_garage_store";
};

private _oldgarage = _vInfo select 4;
private _plateRaw = _vInfo select 1;
private _plate = if (_plateRaw isEqualType []) then {[_plateRaw] call ALF_Server_fnc_mresArray} else {_plateRaw};
if !(_plate isEqualType "") then {_plate = format["%1", _plate];};
private _uid = _vInfo select 0;

// if (_oldgarage in [-1,-2] AND (_oldgarage isNotEqualTo _garage)) exitWith 
if (_oldgarage in [-1,-2]) exitWith 
{
	["GARAGE","Vous ne pouvez pas ranger votre véhicule de service ici.","warning"] remoteExec ["ALF_fnc_doMsg",_ownerID];
	life_garage_store = false;
	_ownerID publicVariableClient "life_garage_store";
};

if (_uid isNotEqualTo (getPlayerUID _unit)) exitWith 
{
	["ERREUR","Vous n'êtes pas le propriétaire du véhicule.","danger"] remoteExec ["ALF_fnc_doMsg",_ownerID];
	life_garage_store = false;
	_ownerID publicVariableClient "life_garage_store";
};

private _damage = [((getAllHitPointsDamage _vehicle) select 2)] call ALF_Server_fnc_mresArray;
private _query = format["UPDATE vehicles SET active='0', fuel='%3', damage='%4', pos_save='%5' WHERE pid='%1' AND plate='%2'",_uid ,_plate,(fuel _vehicle),_damage,getposatl _vehicle];
[_query,1] call ALF_Server_fnc_asyncCall;

{
	detach _x;
	deleteVehicle _x;
} forEach (attachedObjects _vehicle);

if (!isNil "_vehicle" AND {!isNull _vehicle}) then {deleteVehicle _vehicle;};

life_garage_store = false;
_ownerID publicVariableClient "life_garage_store";
["INFO",_storetext,"success"] remoteExec ["ALF_fnc_doMsg",_ownerID];
// };
