// /*
// 	File: fn_vehicleStoreCopSP.sqf
// 	Author: ALF TEAM
// */
// alf_server_fnc_vehicleStoreCopSP = {
params [
	["_vehicle",objNull,[objNull]],
	["_type",-1,[-1]],
	["_unit",objNull,[objNull]],
	["_garage",0,[0]]
];

private _ownerID = _unit getVariable ["ALF_ownerID",-1];
if(isNull _vehicle OR {isNull _unit}) exitWith {life_garage_store = false; _ownerID publicVariableClient "life_garage_store";};

private _vInfo = _vehicle getVariable["dbInfo",[]];
if(count _vInfo isEqualTo 0) exitWith 
{
	["GARAGE","Erreur de stockage (fn_vehicleStore #1).","warning"] remoteExec ["ALF_fnc_doMsg",_ownerID];
	life_garage_store = false;
	_ownerID publicVariableClient "life_garage_store";
};

private _plateRaw = _vInfo select 1;
private _plate = if (_plateRaw isEqualType []) then {[_plateRaw] call ALF_Server_fnc_mresArray} else {_plateRaw};
if !(_plate isEqualType "") then {_plate = format["%1", _plate];};

private _mode = -1;
if (((_vehicle getVariable ["vehicle_info_owners",["",""]]) # 1) isEqualTo "Pompiers") then {_mode = -2;};

if !(_type isEqualTo _mode) exitWith 
{
	["ERREUR","Vous ne pouvez pas rentrer votre véhicule de service ici.","danger"] remoteExec ["ALF_fnc_doMsg",_ownerID];
	life_garage_store = false;
	_ownerID publicVariableClient "life_garage_store";
};

private _damage = [((getAllHitPointsDamage _vehicle) select 2)] call ALF_Server_fnc_mresArray;
private _inventaire = [_veh] call MRPV2_Server_fnc_Vehicule_Inventaire_Sauvegarde;

private _query = "";

switch (_type) do {
    case -1: { // POLICE (cop)
        _query = format [
            "UPDATE vehicles_cop SET active='0', fuel='%1', damage='%2', gear='%3', id_garage='%4', pos_save='%5' WHERE plate='%6'",
            (fuel _vehicle), _damage, _inventaire, _garage, getPosATL _vehicle, _plate
        ];
    };

    case 0: { // MÉDECINS
        _query = format [
            "UPDATE vehicles_med SET active='0', fuel='%1', damage='%2', gear='%3', id_garage='%4', pos_save='%5' WHERE plate='%6'",
            (fuel _vehicle), _damage, _inventaire, _garage, getPosATL _vehicle, _plate
        ];
    };

    case 1: { // PÉNITENTIAIRE
        _query = format [
            "UPDATE vehicles_penit SET active='0', fuel='%1', damage='%2', gear='%3', id_garage='%4', pos_save='%5' WHERE plate='%6'",
            (fuel _vehicle), _damage, _inventaire, _garage, getPosATL _vehicle, _plate
        ];
    };
};

[_query,1] call ALF_Server_fnc_asyncCall;


{
	detach _x;
	deleteVehicle _x;
} forEach (attachedObjects _vehicle);

if (!isNil "_vehicle" && {!isNull _vehicle}) then {deleteVehicle _vehicle;};

life_garage_store = false;
_ownerID publicVariableClient "life_garage_store";
// };
