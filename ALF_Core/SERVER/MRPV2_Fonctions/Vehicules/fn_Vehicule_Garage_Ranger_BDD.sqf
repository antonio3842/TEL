// MRPV2_Server_fnc_Vehicule_Garage_Ranger_BDD = {

private _vehicule = param [0,objNull];
private _type_Garage = param [1,""];
private _joueur = param [2,objnull];
private _secteur = param [3,0,[0]];

private _id_Joueur = _joueur getVariable ["ALF_ownerID",-1];
if(isNull _vehicule OR {isNull _joueur}) exitWith 
{
	life_garage_store = false; 
	_id_Joueur publicVariableClient "life_garage_store";
};

if (_vehicule getVariable ["MRP_TaxiServiceVehicle", false]) exitWith {
	["GARAGE", "Ce véhicule de service se range uniquement au point taxi.", "warning"] remoteExec ["ALF_fnc_doMsg", _id_Joueur];
	life_garage_store = false;
	_id_Joueur publicVariableClient "life_garage_store";
};

if (_vehicule getVariable ["MRP_BusJobServiceVehicle", false]) exitWith {
	["GARAGE", "Ce bus de service se range uniquement au depot bus.", "warning"] remoteExec ["ALF_fnc_doMsg", _id_Joueur];
	life_garage_store = false;
	_id_Joueur publicVariableClient "life_garage_store";
};

if (_vehicule getVariable ["MRP_DistribServiceVehicle", false]) exitWith {
	["GARAGE", "Ce véhicule de service se range uniquement au point distributeur.", "warning"] remoteExec ["ALF_fnc_doMsg", _id_Joueur];
	life_garage_store = false;
	_id_Joueur publicVariableClient "life_garage_store";
};

private _vInfo = _vehicule getVariable["dbInfo",[]];
if (_vInfo isequalto []) exitWith 
{
	["GARAGE","Erreur de stockage du véhicule.","warning"] remoteExec ["ALF_fnc_doMsg",_id_Joueur];
	life_garage_store = false;
	_id_Joueur publicVariableClient "life_garage_store";
};

private _plaque = getplatenumber _vehicule;

private _degat = [];
private _inventaire = [];

if (typeOf _vehicule isNotEqualTo "VEH_MRP_Devidoir_1") then {
	_degat = (getAllHitPointsDamage _vehicule) # 2;
	if (isNil "_degat") then {_degat = [];};
	_inventaire = [_vehicule] call MRPV2_Server_fnc_Vehicule_Inventaire_Sauvegarde;
};

[] call
{
	if (_type_Garage isEqualTo "Civil") exitWith {_type_Garage = "vehicles";};
	if (_type_Garage isEqualTo "Gendarmerie") exitWith {_type_Garage = "vehicles_cop";};
	if (_type_Garage isEqualTo "Pompiers") exitWith {_type_Garage = "vehicles_med";};
	if (_type_Garage isEqualTo "policemunicipale") exitWith {_type_Garage = "vehicles_penit";};
};

private _textureIndex = if ("_mrp_" in toLower (typeOf _vehicule)) then {11} else {0};
private _textures = getObjectTextures _vehicule;
private _materials = getObjectMaterials _vehicule;

private _texture = _textures param [_textureIndex, (_textures param [0, ""])];
private _material = _materials param [_textureIndex, (_materials param [0, ""])];

if !(_texture isEqualType "") then {_texture = "";};
if !(_material isEqualType "") then {_material = "";};

if (_texture != "") then {_texture = (_texture splitString "\") joinString "\\";};
if (_material != "") then {_material = (_material splitString "\") joinString "\\";};
private _peinture = [_texture, _material];

private _typeVeh = "Car";
if (_vehicule isKindOf "Air") then {
	_typeVeh = "Air";
} else {
	if (_vehicule isKindOf "Ship") then { _typeVeh = "Ship"; };
};

private _id_garage = if (_secteur in [13,23,33,34]) then {_secteur} else {0};
private _requete = format["UPDATE %1 SET active='0', fuel='%2', damage='%3', gear='%4', position='%5', peinture='%6', id_garage='%8', type='%9' WHERE plate='%7'",_type_Garage,(fuel _vehicule),_degat,_inventaire,[getposatl _vehicule,0],_peinture,_plaque,_id_garage,_typeVeh];
[_requete,1] call ALF_Server_fnc_asyncCall;

if (typeOf _vehicule isEqualTo "VEH_MRP_Devidoir_1") then {
	{ detach _x; deleteVehicle _x; } forEach attachedObjects _vehicule;
} else {
	deleteVehicle (attachedObjects _vehicule);
};
deleteVehicle _vehicule;

["INFO",format ["Le véhicule (%1) à été rangé avec succès.",_plaque],"success"] remoteExec ["ALF_fnc_doMsg",_joueur];

life_garage_store = false;
_id_Joueur publicVariableClient "life_garage_store";
// };
