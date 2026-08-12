private _type = _this select 0;
if (_type isEqualTo "") exitWith {};

private _config = ["CLASS", ["ALF_DESEASES", _type]] call ALFTools_Client_Config_fnc_getConfig;

_returnClass = [["ALF_DESEASES", _type]] call ALFTools_Client_Config_fnc_isClass;
if (!_returnClass) exitWith {};
if (missionNamespace getVariable [format["deases_%1_active",_type],false]) exitWith {};

private _index = -1;
{
	if (_type in _x) exitWith {_index = _forEachIndex};
} forEach alf_vaccins;
if (_index != -1) exitWith {};

_index = -1;
{
	if (_type in _x) exitWith {_index = _forEachIndex};
} forEach alf_deseases;

private _medecine = [];
if (_index isEqualTo -1) then {
	_medecine pushBack[format["ALF_Medoc_%1",_type],1];
	alf_deseases pushBack [_type,_medecine];
} else {
	_medecine = (alf_deseases select _index) select 1;
};

missionNamespace setVariable [format["deases_%1_active",_type],true];
private _maxFatigue = ["NUMBER", ["reduce_fatigue"], _config] call ALFTools_Client_Config_fnc_getConfig;
private _event_sounds = ["ARRAY", ["event_sounds"], _config] call ALFTools_Client_Config_fnc_getConfig;
private _contagion_chance = ["NUMBER", ["event_contagion_chance"], _config] call ALFTools_Client_Config_fnc_getConfig;
private _event_next = 0;

while {count(_medecine) > 0} do {
	if (time > _event_next) then {
		if (count(_event_sounds) > 0 && !(alf_admin_invi)) then {
			[player,(_event_sounds call BIS_fnc_selectRandom)] remoteExecCall ["ALF_fnc_say3D",0];
		};
		if (_contagion_chance > 0) then {
			private _protectionConfig = ["ARRAY", ["protect_contamination_air"], _config] call ALFTools_Client_Config_fnc_getConfig;
			if (!((headgear player) in _protectionConfig)) then {
				{
					if ((alive _x) && (_x != player) && !(_x getVariable ["ReviveMedic",false])) then {
						if (!((headgear _x) in _protectionConfig)) then {
							if (random(100) <= _contagion_chance) then {
								[_type] remoteExec ["ALF_fnc_handleDesease",_x];
							};
						};
					};
				} forEach ((getPos player) nearEntities ["Man",5]);
			};
		};
		_event_next = time + (round(random(3) + 4) * 60);
	};
	if (_maxFatigue isEqualTo 1) then {
		uiSleep 10;
	} else {
		if ((getFatigue player) < _maxFatigue) then {
			player setFatigue _maxFatigue;
		};
		uiSleep 1;
	};
};

_index = -1;
{
	if (_type in _x) exitWith {_index = _forEachIndex};
} forEach alf_deseases;

alf_deseases deleteAt _index;
missionNamespace setVariable [format["deases_%1_active",_type],false];
