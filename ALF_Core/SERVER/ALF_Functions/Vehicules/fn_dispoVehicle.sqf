/*
	File: fn_dispoVehicle.sqf
	Author: ALF Team
*/
params[
	["_classname","",[""]],
	["_unit",objNull,[objNull]],
	["_shopName","",[""]],
	["_isB33Enterprise",false,[false]]
];

if(_classname isEqualTo "" OR {isNull _unit}) exitWith {};

private _dispo = 0;
if (_isB33Enterprise) then {
	_dispo = 999;
} else {
	private _result = [format["SELECT dispo FROM shop WHERE classname='%1'",_classname],2] call ALF_Server_fnc_asyncCall;
	
	if (!(_result isEqualTo [])) then {
		_dispo = _result # 0;
		if (typeName _dispo == "STRING") then {
			_dispo = parseNumber _dispo;
		};
	} else {
		_dispo = 0;
	};
};

[_classname,_dispo] remoteExec ["ALF_fnc_dispoVehicle",_unit];