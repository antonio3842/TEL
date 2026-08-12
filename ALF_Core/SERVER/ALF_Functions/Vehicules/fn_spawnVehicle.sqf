// File: fn_spawnVehicle.sqf
// Author: ALF TEAM  •  Modifié par NorX Aengell
// alf_server_fnc_spawnVehicle = {

params [
	["_vid",-1,[0]],
	["_pid","",[""]],
	["_sp",[],[[],""]],
	["_unit",objNull,[objNull]],
	["_price",0,[0]],
	["_dir",0,[0]]
];

if((_vid isEqualTo -1) OR {_pid isEqualTo ""}) exitWith {};

// NOTE: L'ordre des colonnes dans ce SELECT fixe les index utilisés plus bas
private _vInfo = [format[
	"SELECT id, classname, type, pid, alive, active, plate, gear, fuel, damage, insure, insurecount, peinture, id_garage FROM vehicles WHERE id='%1' AND pid='%2'",
	_vid,_pid
],2] call ALF_Server_fnc_asyncCall;

if(isNil "_vInfo" OR {_vInfo isEqualType ""} OR {count(_vInfo) isEqualTo 0} OR {(_vInfo # 4) isEqualTo 0} OR {(_vInfo # 5) isEqualTo 1}) exitWith {};

private _id_garage = _vInfo # 13;
private _magasin = "garage";

// Vérifier si le véhicule est dans un garage secteur (13 ou 23)
if (_id_garage isEqualTo 13) then {
	_magasin = "Secteur13_Garage";
} else {
	if (_id_garage isEqualTo 23) then {
		_magasin = "Secteur23_Garage";
	} else {
		// Comportement normal pour les autres garages
		private _garage_Maison_Proche = (nearestObjects [_unit,["Land_ALF_MaisonContemporaine"],30]) # 0;
		if (_magasin in ["garage"] AND {!isnil {_garage_Maison_Proche}}) then {_magasin = "garage_MaisonContemporaine"};

		private _garage_Maison_Proche = (nearestObjects [_unit,["Land_ALF_MaisonMitoyenne1"],30]) # 0;
		if (_magasin in ["garage"] AND {!isnil {_garage_Maison_Proche}}) then {_magasin = "garage_MaisonMitoyenne1"};
	};
};

private _vehicle = [_vInfo # 1,_magasin,_unit] call MRPV2_fnc_Vehicule_Creation;
if (isNull _vehicle) exitWith {
	["Garage","Votre véhicule n'est pas disponible.","success",false] remoteExec ["ALF_fnc_doMsg",_unit];
};

[format["UPDATE vehicles SET active='1' WHERE pid='%1' AND id='%2'",_pid,_vid],1] spawn ALF_Server_fnc_asyncCall;

// --- Inventaire (gear = #7)
private _gear = [_vInfo # 7] call ALF_Server_fnc_mresToArray;
{
	private _activeValue = _x;
	{
		if !(_x isEqualType []) then {continue};
		private _newItemClass = [_x] call ALFTools_Server_MD_T_fnc_checkMetaData;
		if (_newItemClass isEqualTo "")  then {continue};
		if (_newItemClass isEqualTo -1) then {_activeValue#0 set [_forEachIndex, ""]; continue};
		_activeValue#0 set [_forEachIndex, _newItemClass];
	} forEach _x#0;
	_gear set [_forEachIndex, _activeValue];
} forEach _gear;

// --- Dégâts (damage = #9) • CORRIGÉ: recompile si string + fallback
private _damage = [_vInfo # 9] call ALF_Server_fnc_mresToArray;
if (_damage isEqualType "") then { _damage = call compile format["%1", _damage]; };
if (isNil "_damage") then { _damage = []; };

// --- Plaque (plate = #6)
private _plate = [(_vInfo # 6)] call ALF_Server_fnc_mresToArray;
if(_plate isEqualType "") then {_plate = call compile format["%1", _plate];};

// --- Clés
private _keys = [format["SELECT pid FROM keysTime WHERE mode='0' AND idobj='%1'",_vInfo # 0],2,true] call ALF_Server_fnc_asyncCall;
[_vehicle] remoteExecCall ["ALF_fnc_addVehicle2Chain",(playableUnits select {([(getPlayerUID _x),_keys] call TON_fnc_index) > -1}) + [_unit]];
[_pid,_vehicle,1] call ALF_Server_fnc_keyManagement;

// --- Setup véhicule
_vehicle lock 2;
_vehicle setVariable ["vehicle_info_owners",["",_pid],true];
_vehicle setVariable ["dbInfo",[_vInfo # 3,_plate,(_vInfo # 10),(_vInfo # 11),(_vInfo # 13)]];
_vehicle setVariable ["Flashed",false];
_vehicle disableTIEquipment true;
[_vehicle] call ALF_fnc_clearVehicleAmmo;
_vehicle enableDynamicSimulation true;
_vehicle allowDamage TRUE; 
_vehicle setFuel (_vInfo # 8);

// --- Gendarmerie: matos/feux
if((_vInfo # 1) in ["V_ALF_Megane_G_Gendarmerie","V_ALF_Berlingo_Gendarmerie","V_ALF_Subaru_Gendarmerie","V_ALF_GIGN","V_ALF_Titan_Gendarmerie","V_ALF_DV15_Gendarmerie","V_ALF_Vito_Gendarmerie","Berlingo2019G"]) then {
	_vehicle setVariable ["TF_RadioType", "alf_megaphone", true];
	{_vehicle setHit[_x,1];} forEach ["lightg01_h","lightg02_h","lightg03_h","lightg04_h","lightg05_h","lightg06_h","lightg07_h","lightg08_h"];
};

// --- Héli
if(_vehicle isKindOf "Air") then {
	_vehicle setVariable ["TF_RadioType", "alf_radioheli", true];
	private _freq = random[1000, 5000, 9999];
	_vehicle setVariable ["helicofreq", _freq, true];
};

// --- Remise de l'inventaire
if (count _gear > 0) then {
	private _items = _gear # 0;
	private _mags = _gear # 1;
	private _weapons = _gear # 2;
	private _backpacks = _gear # 3;

	for "_i" from 0 to ((count (_items select 0)) - 1) do {
		_vehicle addItemCargoGlobal [((_items select 0) select _i), ((_items select 1) select _i)];
	};
	for "_i" from 0 to ((count (_mags select 0)) - 1) do {
		_vehicle addMagazineCargoGlobal [((_mags select 0) select _i), ((_mags select 1) select _i)];
	};
	for "_i" from 0 to ((count (_weapons select 0)) - 1) do {
		_vehicle addWeaponCargoGlobal [((_weapons select 0) select _i), ((_weapons select 1) select _i)];
	};
	for "_i" from 0 to ((count (_backpacks select 0)) - 1) do {
		_vehicle addBackpackCargoGlobal [((_backpacks select 0) select _i), ((_backpacks select 1) select _i)];
	};
};

// ================== MINI-HOOK ANTI-RÉPARATION (INLINE) ==================
private _enforceDamage = {
  params ["_veh","_arr","_duration","_interval","_epsilon"];
  if (isNull _veh || {count _arr == 0}) exitWith {};

  // applique _arr de façon bornée aux HP du modèle
  private _apply = {
    params ["_v","_a"];
    private _parts   = getAllHitPointsDamage _v;
    private _hpNames = _parts # 0;
    private _max     = (count _hpNames) min (count _a);
    for "_i" from 0 to (_max - 1) do {
      _v setHitPointDamage [format["%1", (_hpNames # _i)], _a # _i];
    };
  };

  // 1) application immédiate
  [_veh, _arr] call _apply;

  // 2) surveillance: si un script remet à 0, on réapplique
  private _end = time + _duration;
  while {alive _veh && {time < _end}} do {
    uiSleep _interval;
    private _cur = getAllHitPointsDamage _veh # 2;
    private _len = (count _cur) min (count _arr);
    private _changed = false;
    for "_i" from 0 to (_len - 1) do {
      if (abs ((_cur # _i) - (_arr # _i)) > _epsilon) exitWith { _changed = true; };
    };
    if (_changed) then { [_veh, _arr] call _apply; };
  };
};

// Lancer le hook: durée=5s, intervalle=0.1s, epsilon=0.001
[_vehicle, _damage, 5, 0.1, 0.001] spawn _enforceDamage;
// ========================================================================

// --- Assurance (insure = #10)
if((_vInfo # 10) > 0) then {
  ["Garage","Votre véhicule est disponible et assuré.","success",false] remoteExec ["ALF_fnc_doMsg",_unit];
  _vehicle animateSource ["assu", 0, true];
} else {
  ["Garage","Votre véhicule est disponible et non assuré, attention vous n'êtes pas en règle.","warning",false] remoteExec ["ALF_fnc_doMsg",_unit];
  _vehicle animateSource ["assu", 1, true];
};

// --- Peinture (peinture = #12)
private _peinture = _vInfo # 12;
if (_peinture isEqualType "") then { _peinture = call compile format["%1", _peinture]; };
if (_peinture isNotEqualTo []) then {
	private _classname = toLower (typeOf _vehicle);
	private _textureIndex = if ("_mrp_" in _classname) then {[11,12]} else {[0,0]};
	_vehicle setObjectTextureGlobal  [_textureIndex # 0,(_peinture # 0)];
	_vehicle setObjectMaterialGlobal [_textureIndex # 1,(_peinture # 1)];
};

// --- Plaques & tracker
_vehicle setPlateNumber (_plate joinString "");
_vehicle animateSource ["tracker", 1, true];

_vehicle setObjectTextureGlobal [1, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plate # 0]];
_vehicle setObjectTextureGlobal [2, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plate # 1]];
_vehicle setObjectTextureGlobal [3, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plate # 3]];
_vehicle setObjectTextureGlobal [4, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plate # 4]];
_vehicle setObjectTextureGlobal [5, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plate # 5]];
_vehicle setObjectTextureGlobal [6, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plate # 7]];
_vehicle setObjectTextureGlobal [7, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plate # 8]];

// };
