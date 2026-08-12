/*
	File: fn_vehicleUpdate.sqf
	Author : ALF TEAM
*/
params [
	["_vehicle",objNull,[objNull]],
	["_mode",1,[0]]
];
if(isNull _vehicle) exitWith {}; //NULL

private _dbInfo = _vehicle getVariable["dbInfo",[]];
if (_dbInfo isEqualTo []) exitWith {};

private _uid = _dbInfo select 0;
private _plateRaw = _dbInfo select 1;
private _plate = if (_plateRaw isEqualType []) then {[_plateRaw] call ALF_Server_fnc_mresArray} else {_plateRaw};
if !(_plate isEqualType "") then {_plate = format["%1", _plate];};

switch (_mode) do {
	case 1: {
		private _vehItems = getItemCargo _vehicle;
		private _vehMags = getMagazineCargo _vehicle;
		private _vehWeapons = getWeaponCargo _vehicle;
		private _vehBackpacks = getBackpackCargo _vehicle;

		private "_cargo";
		if((count (_vehItems select 0) isEqualTo 0) && {(count (_vehMags select 0) isEqualTo 0)} && {(count (_vehWeapons select 0) isEqualTo 0)} && {(count (_vehBackpacks select 0) isEqualTo 0)}) then {
			_cargo = [];
		} else {
			_cargo = [_vehItems,_vehMags,_vehWeapons,_vehBackpacks]
		};

		{
			private _activeArr = _x;
			{
				// className = _x
				private _arrayRet = [_x, false] call ALFTools_Server_MD_T_fnc_packData;
				if (_arrayRet isEqualTo "") then {continue};
				_activeArr#0 set[_forEachIndex,_arrayRet];
			}forEach _x#0;
		
			_cargo set[_forEachIndex,_activeArr];
		}forEach _cargo;

		private _newCargo = [_cargo] call ALF_Server_fnc_mresArray;

		//_cargo = [_cargo] call ALF_Server_fnc_mresArray;
		[format["UPDATE vehicles SET gear='%3' WHERE pid='%1' AND plate='%2'",_uid,_plate,_newCargo],1] call ALF_Server_fnc_asyncCall;
	};
};
