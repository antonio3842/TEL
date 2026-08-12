// ALF_Server_fnc_fetchPlayerHouses = {

params [
	["_uid","",[""]]
];
if(_uid isEqualTo "") exitWith {};
// ['_uid' + str(_uid)] remoteExec ['systemchat',0]; // PERF FIX: Debug désactivé
private _houses = [format["SELECT pid, pos, id FROM houses WHERE pid='%1'",_uid],2,true] call ALF_Server_fnc_asyncCall;
private _rtn = [];

{
	private _pos = call compile format["%1", _x # 1];
	private _house = nearestObject [_pos, "House"];
	private _fixpos = getPosATL _house;
	private _id_house = _x # 2;

	_house allowDamage false;
	_rtn pushBack (str(_fixpos));

	if !(isNull _house) then
	{
		private _count = ([format ["SELECT COUNT(*) FROM mobiliers WHERE pid='%1' AND id_house='%2'", _uid, _id_house],2] call ALF_Server_fnc_asyncCall) # 0;
		if (_count isEqualTo 0) exitWith {};

		for [{_x=0},{_x<=_count},{_x=_x+10}] do
		{
			private _queryResult = [format["SELECT pos, classname, gear, dir, id, code FROM mobiliers WHERE pid='%2' AND id_house='%3' LIMIT %1,10", _x, _uid, _id_house],2,true] call ALF_Server_fnc_asyncCall;
			if (_queryResult isEqualTo []) exitWith {};

			{
				private _p = call compile format["%1", _x # 0];

				private _index = ALF_Mobiliers_Objects find (_x # 1);
				if (_index > -1) then
				{
					private _data = ALF_Mobiliers_Objects_Data # _index;
					private "_obj";

					if ((_x # 1) in ["Land_ALF_Plante_W_2","Land_ALF_Coco"]) then
					{
						_obj = (_x # 1) createVehicle [0,0,0];
						_obj allowDammage false;
						[_obj,true] remoteExecCall ["enableDynamicSimulation",2];
					} else
					{
						_obj = createSimpleObject [_data, _p];
					};

					_obj setPosWorld _p;
					_obj setDir (call compile format["%1",_x # 3]);
					_obj setVariable ["mobilier_data",[_uid,(_x # 4),(_x # 1),_house,(_x # 5),true]];
					_obj setVariable ["house", _house, true];
					_obj setVariable ["owner", _uid, true];
					_obj setVariable ["safe", (_x # 5), true];

					private _gear = [_x # 2] call ALF_Server_fnc_mresToArray;
					if(_gear isEqualType "") then {_gear = call compile format["%1", _gear];};

					{
						if !(_x isEqualType []) then {continue};

						private _newItemClass = [_x] call ALFTools_Server_MD_T_fnc_checkMetaData;
						if (_newItemClass isEqualTo "") then {continue};
						if (_newItemClass isEqualTo -1) then
						{
							_gear set[_forEachIndex, ""];
							continue;
						};

						_gear set[_forEachIndex, _newItemClass];
					} forEach _gear;

					_obj setVariable ["gear",_gear,true];

					private _var = _house getVariable ["mobiliers",[]];
					_var pushBack _obj;
					_house setVariable ["mobiliers",_var];
				};
			} forEach _queryResult;
		};
	};
} forEach _houses;

missionNamespace setVariable [format["houses_%1",_uid],_rtn];
// };