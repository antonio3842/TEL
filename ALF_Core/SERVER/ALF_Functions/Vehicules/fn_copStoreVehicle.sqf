// ALF_Server_fnc_copStoreVehicle = {

private _joueur = param [0,objnull];
private _veh = param [1,objnull];
if(isNull _veh OR {isNull _joueur}) exitWith {};


private _plaque = getPlateNumber _veh;
private _degat = getAllHitPointsDamage _veh # 2;
private _fuel = fuel _veh;
private _veh_Info_Owners = (_veh getVariable ["vehicle_info_owners",["",""]]) # 0;
private _type_BDD = "vehicles";

[] call
{
	if (_veh_Info_Owners isequalto "Gendarmerie") exitwith {_type_BDD = "vehicles_cop"};
	if (_veh_Info_Owners isequalto "Pompiers") exitwith {_type_BDD = "vehicles_med"};
	if (_veh_Info_Owners isequalto "policemunicipale") then {_type_BDD = "vehicles_penit"};
};

private _inventaire = [_veh] call MRPV2_Server_fnc_Vehicule_Inventaire_Sauvegarde;

if (typeOf _veh isEqualTo "VEH_MRP_Devidoir_1") then {
	_degat = [];
	_inventaire = [];
};

[format["UPDATE %1 SET active='0', fuel='%2', damage='%3', gear='%4' WHERE plate='%5'",_type_BDD,_fuel,_degat,_inventaire,_plaque],1] call ALF_Server_fnc_asyncCall;

if(!isNil {_veh} AND {!isNull _veh}) then {deleteVehicle _veh;};
// };