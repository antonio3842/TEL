#include "\ALF_Core\SERVER\script_macros.hpp"
/*
	initCoffre prison
*/
private _q = ["SELECT id, gear, safe, piege FROM prison",2,true] call ALF_Server_fnc_asyncCall;
{
	private _id = _x select 0;
	private _gear = [_x select 1] call ALF_Server_fnc_mresToArray;
	if(_gear isEqualType "") then {_gear = call compile format["%1",_gear];};

	/* -- Update gear meta data -- */
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
	}forEach _gear;

	private _c = call compile format ["alf_coffre_prison_%1",_id];

	if (count _gear > 0) then {
		private _items = _gear select 0;
		private _mags = _gear select 1;
		private _weapons = _gear select 2;
		private _backpacks = _gear select 3;
		for "_i" from 0 to ((count (_items select 0)) - 1) do {
			_c addItemCargoGlobal [((_items select 0) select _i), ((_items select 1) select _i)];
		};
		for "_i" from 0 to ((count (_mags select 0)) - 1) do{
			_c addMagazineCargoGlobal [((_mags select 0) select _i), ((_mags select 1) select _i)];
		};
		for "_i" from 0 to ((count (_weapons select 0)) - 1) do{
			_c addWeaponCargoGlobal [((_weapons select 0) select _i), ((_weapons select 1) select _i)];
		};
		for "_i" from 0 to ((count (_backpacks select 0)) - 1) do{
			_c addBackpackCargoGlobal [((_backpacks select 0) select _i), ((_backpacks select 1) select _i)];
		};
	};

	private _safe = [_x select 2,1] call ALF_Server_fnc_bool;
	if(_safe) then {
		_c animateSource ["safe_source",0,true];
	};

	private _piege = [_x select 3,1] call ALF_Server_fnc_bool;
	if(_piege) then {
		_c animateSource ["piege_source",0,true];
	};
} forEach _q;
