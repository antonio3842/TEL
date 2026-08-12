// ALF_Server_fnc_insertVehicle = {
private["_query","_sql"];
_uid = _this # 0;
_type = _this # 1;
_className = _this # 2;
_plate = _this # 3;
_peinture = param [4,[],[[],""]];
_id_garage_param = param [5,0,[0]];

//Stop bad data being passed.
if(_uid isEqualTo "" OR {_type isEqualTo ""} OR {_className isEqualTo ""}) exitWith {};
// _plate = [_plate] call ALF_Server_fnc_mresArray;

// Accepter directement id_garage (13 ou 23) ou secteur (qui sera converti)
// Si la valeur est 13 ou 23, l'utiliser directement comme id_garage
// Sinon, mettre à 0 (compatibilité avec ancien code)
private _id_garage = if (_id_garage_param in [13,23]) then {_id_garage_param} else {0};
private _peintureStr = "[]";
if (_peinture isNotEqualTo []) then {
	if (_peinture isEqualType "") then {
		_peintureStr = _peinture;
	} else {
		if (_peinture isEqualType []) then {
			_peintureStr = [_peinture] call ALF_Server_fnc_mresArray;
		};
	};
};

_query = format["INSERT INTO vehicles (classname, type, pid, alive, active, plate, gear, position, damage, peinture, id_garage) VALUES ('%1', '%2', '%3', '1', '1', '%4','[]','[]','[]', '%5', '%6')",_className,_type,_uid,_plate,_peintureStr,_id_garage];

[_query,1] call ALF_Server_fnc_asyncCall;

diag_log format ["QUERY: %1", _query];
// };