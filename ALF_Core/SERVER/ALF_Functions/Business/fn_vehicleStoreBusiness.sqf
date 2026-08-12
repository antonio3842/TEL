// ALF_Server_fnc_vehicleStoreBusiness = {

params [
	["_veh",objNull,[objNull]],
	["_unit",objNull,[objNull]]
];
private _ownerID = _unit getVariable ["ALF_ownerID",-1];

if (isNull _veh OR {isNull _unit}) exitWith {life_garage_store = false; _ownerID publicVariableClient "life_garage_store";};
private _vInfo2 = _veh getVariable["business_veh",[]];
private _siret = _vInfo2 # 0;

private _plaque = getPlateNumber _veh;

private _damage = getAllHitPointsDamage _veh; 
if ((count _damage) isNotEqualTo 0) then { 
_damage = getAllHitPointsDamage _veh # 2;
} else { 
_damage = []; 
}; 

private _fuel = fuel _veh;

private _inventaire = [_veh] call MRPV2_Server_fnc_Vehicule_Inventaire_Sauvegarde;

private _query = format["UPDATE vehicles SET active='0', fuel='%1', damage='%2', gear='%3' WHERE type='%4' AND plate='%5'",_fuel,_damage,_inventaire,_siret,_plaque];

[_query,1] call ALF_Server_fnc_asyncCall;

if(!isNil "_veh" && {!isNull _veh}) then {deleteVehicle _veh;};

["INFO",format ["Le véhicule d'entreprise (%1) est au garage.",_plaque],"success"] remoteExec ["ALF_fnc_doMsg",_ownerID];
// };
