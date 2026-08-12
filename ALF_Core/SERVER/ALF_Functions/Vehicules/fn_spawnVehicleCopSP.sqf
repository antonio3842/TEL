
params [
	["_vid",-1,[0]],
	["_type",-1,[-1]],
	["_sp",[],[[],""]],
	["_unit",objNull,[objNull]],
	["_dir",0,[0]]
];
if(_vid isEqualTo -1) exitWith {};

private _vinfo = [];

if (_type isEqualTo -1) then {
    _vInfo = [format["SELECT id, classname, type, alive, active, plate, gear, fuel, damage, peinture, id_garage FROM vehicles_cop WHERE id='%1'",_vid],2] call ALF_Server_fnc_asyncCall;

} else if (_type isEqualTo 0) then {
    _vInfo = [format["SELECT id, classname, type, alive, active, plate, gear, fuel, damage, peinture, id_garage FROM vehicles_med WHERE id='%1'",_vid],2] call ALF_Server_fnc_asyncCall;

} else {
    _vInfo = [format["SELECT id, classname, type, alive, active, plate, gear, fuel, damage, peinture, id_garage FROM vehicles_penit WHERE id='%1'",_vid],2] call ALF_Server_fnc_asyncCall;
};

if(isNil "_vInfo" OR {_vInfo isEqualType ""} OR {count(_vInfo) isEqualTo 0} OR {(_vInfo select 3) isEqualTo 0} OR {(_vInfo select 4) isEqualTo 1}) exitWith {};

private _vehicle = [_vInfo # 1,"heli_Service",_unit] call MRPV2_fnc_Vehicule_Creation;
if (isNull _vehicle) exitWith {["Garage","Votre véhicule n'est pas disponible.","success",false] remoteExec ["ALF_fnc_doMsg",_unit];};

if (_type isEqualTo -1) then {
    [format["UPDATE vehicles_cop SET active='1', pid='%2' WHERE id='%1'", _vid, getPlayerUID _unit], 1] spawn ALF_Server_fnc_asyncCall;
} else if (_type isEqualTo 0) then {
    [format["UPDATE vehicles_med SET active='1', pid='%2' WHERE id='%1'", _vid, getPlayerUID _unit], 1] spawn ALF_Server_fnc_asyncCall;
} else {
    [format["UPDATE vehicles_penit SET active='1', pid='%2' WHERE id='%1'", _vid, getPlayerUID _unit], 1] spawn ALF_Server_fnc_asyncCall;
};

private _gear = [_vInfo select 6] call ALF_Server_fnc_mresToArray;

{
	private _activeValue = _x;
	{
		if !(_x isEqualType []) then {continue};
		private _newItemClass = [_x] call ALFTools_Server_MD_T_fnc_checkMetaData;
		if (_newItemClass isEqualTo "") then {continue};
		if (_newItemClass isEqualTo -1) then {_activeValue#0 set [_forEachIndex, ""]; continue};
		_activeValue#0 set [_forEachIndex, _newItemClass];
	} forEach _x#0;
	_gear set [_forEachIndex, _activeValue];
} forEach _gear;

private _damage = [_vInfo select 8] call ALF_Server_fnc_mresToArray;
private _plate = [_vInfo select 5] call ALF_Server_fnc_mresToArray;
if(_plate isEqualType "") then {_plate = call compile format["%1", _plate];};

[_vehicle] remoteExecCall ["ALF_fnc_addVehicle2Chain",_unit];
[getPlayerUID _unit,_vehicle,1] call ALF_Server_fnc_keyManagement;

_vehicle lock 2;
if (_type isEqualTo -1) then {
    _vehicle setVariable ["vehicle_info_owners", ["Gendarmerie",""], true];
    _vehicules = missionNamespace getVariable ["VehiculeGN", []];
    _vehicules pushBack _vehicle;
    missionNamespace setVariable ["VehiculeGN", _vehicules, true];

} else if (_type isEqualTo 0) then {
    _vehicle setVariable ["vehicle_info_owners", ["Pompiers",""], true];
    _vehicules = missionNamespace getVariable ["VehiculeSP", []];
    _vehicules pushBack _vehicle;
    missionNamespace setVariable ["VehiculeSP", _vehicules, true];

} else {
    _vehicle setVariable ["vehicle_info_owners", ["policemunicipale",""], true];
    _vehicules = missionNamespace getVariable ["VehiculePM", []];
    _vehicules pushBack _vehicle;
    missionNamespace setVariable ["VehiculePM", _vehicules, true];
};

_vehicle setVariable ["dbInfo",[_type,_plate,1,0,(_vInfo select 10)]];
_vehicle setVariable ["Flashed",false];
_vehicle disableTIEquipment true;
[_vehicle] call ALF_fnc_clearVehicleAmmo;

_vehicle setFuel (_vInfo select 7);

if ((_vInfo select 1) in ["V_ALF_Megane_G_Gendarmerie","V_ALF_Berlingo_Gendarmerie","V_ALF_Subaru_Gendarmerie","V_ALF_GIGN","V_ALF_Titan_Gendarmerie","V_ALF_DV15_Gendarmerie","V_ALF_Vito_Gendarmerie"]) then 
{
	_vehicle setVariable ["TF_RadioType", "alf_megaphone", true];
	{_vehicle setHit[_x,1];} forEach ["lightg01_h","lightg02_h","lightg03_h","lightg04_h","lightg05_h","lightg06_h","lightg07_h","lightg08_h"];
};

if (_vehicle isKindOf "Air") then 
{
	_vehicle setVariable ["TF_RadioType", "alf_radioheli", true];
	private _freq = random[1000, 5000, 9999];
	_vehicle setVariable ["helicofreq", _freq, true];
};

if (count _gear > 0) then 
{
	private _items = _gear select 0;
	private _mags = _gear select 1;
	private _weapons = _gear select 2;
	private _backpacks = _gear select 3;
	
	for "_i" from 0 to ((count (_items select 0)) - 1) do 
	{
		_vehicle addItemCargoGlobal [((_items select 0) select _i), ((_items select 1) select _i)];
	};
	for "_i" from 0 to ((count (_mags select 0)) - 1) do 
	{
		_vehicle addMagazineCargoGlobal [((_mags select 0) select _i), ((_mags select 1) select _i)];
	};
	for "_i" from 0 to ((count (_weapons select 0)) - 1) do 
	{
		_vehicle addWeaponCargoGlobal [((_weapons select 0) select _i), ((_weapons select 1) select _i)];
	};
	for "_i" from 0 to ((count (_backpacks select 0)) - 1) do 
	{
		_vehicle addBackpackCargoGlobal [((_backpacks select 0) select _i), ((_backpacks select 1) select _i)];
	};
};

if (count _damage > 0) then 
{
	private _parts = getAllHitPointsDamage _vehicle;

	{
		_vehicle setHitPointDamage [format["%1",((_parts select 0) select _forEachIndex)],_x];
	} forEach _damage;
};

["Garage","Votre véhicule est disponible et assuré.","success",false] remoteExec ["ALF_fnc_doMsg",_unit];

_vehicle animateSource ["assu", 0, true];

private _peinture = [_vInfo select 9] call ALF_Server_fnc_mresToArray;
if(_peinture isEqualType "") then {_peinture = call compile format["%1", _peinture];};

if !(_peinture isEqualTo []) then 
{
	private _textureIndex = if (count _peinture > 2) then { _peinture select 2 } else { 0 }; // Utilisation de l'index correct
	_vehicle setObjectTextureGlobal [0,(_peinture select 0)];
	_vehicle setObjectMaterialGlobal [0,(_peinture select 1)];
};

_vehicle animateSource ["tracker", 1, true];

_vehicle setObjectTextureGlobal [1, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plate select 0]];
_vehicle setObjectTextureGlobal [2, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plate select 1]];
_vehicle setObjectTextureGlobal [3, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plate select 3]];
_vehicle setObjectTextureGlobal [4, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plate select 4]];
_vehicle setObjectTextureGlobal [5, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plate select 5]];
_vehicle setObjectTextureGlobal [6, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plate select 7]];
_vehicle setObjectTextureGlobal [7, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plate select 8]];
