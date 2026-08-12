// ALF_fnc_menuVehicles = {
private _veh = _this # 0;
life_vInact_curTarget = _veh;
private _isVehicle = if (_veh isKindOf "Car" OR {_veh isKindOf "Ship"} OR {_veh isKindOf "Air"}) then {true} else {false};
if !(_isVehicle) exitWith {};

private _load = false;
if !(dialog) then 
{
	createDialog "vmenu_dialog";
	_load = true;
};
disableSerialization;

_display = findDisplay 30200;
_a1 = _display displayCtrl 30421;
_a2 = _display displayCtrl 30422;
_a3 = _display displayCtrl 30423;
_a4 = _display displayCtrl 30424;
_a5 = _display displayCtrl 30425;

for "_i" from 30401 to 30407 do
{
	(_display displayCtrl _i) ctrlShow false;
};

if (ALF_AdminLevel > 2) then 
{
	_a3 buttonSetAction "[life_vInact_curTarget,0] remoteExec ['setDamage',0];closeDialog 0;";
	_a4 buttonSetAction "[life_vInact_curTarget] spawn ALF_fnc_pulloutAction;";
	_a5 buttonSetAction "life_vehicles pushBack life_vInact_curTarget;";
} else 
{
	_a3 ctrlShow false;
	_a4 ctrlShow false;
	_a5 ctrlShow false;
};

if (ALF_AdminLevel > 1) then 
{
	_a1 buttonSetAction "[player,life_vInact_curTarget] spawn ALF_fnc_copStoreVehicle; closeDialog 0;";
	_a2 buttonSetAction 
	"
		private _info_owners = life_vInact_curTarget getVariable ['vehicle_info_owners',['Aucun','']];

		if (!isnil {_info_owners # 1} AND {_info_owners # 1 isequalto ''}) exitwith 
		{ 
			hint format['Propriétaire : %1',_info_owners # 0]; [] spawn {sleep 10; hint '';};
		};
		if (_info_owners # 0 isNotequalto '' AND {_info_owners # 1 isNotequalto ''}) exitwith 
		{
			hint format['Propriétaire/UID : %1,%2',_info_owners # 0,_info_owners # 1]; [] spawn {sleep 10; hint '';};
		};		
		if (_info_owners # 0 isequalto '' AND {_info_owners # 1 isNotequalto ''}) exitwith 
		{
			hint format['Propriétaire/UID : Inconnu/%1',_info_owners # 1]; [] spawn {sleep 10; hint '';};
		};	
	";
} else 
{
	_a1 ctrlShow false;
	_a2 ctrlShow false;
	_a3 ctrlShow false;
	_a4 ctrlShow false;
	_a5 ctrlShow false;
};

if (!life_gendarme_service AND !life_pompier_service) then {[_veh] spawn ALF_fnc_showCivBtn;};
if (life_gendarme_service) then {[_veh] spawn ALF_fnc_showCopBtn;};
if (life_pompier_service) then {[_veh] spawn ALF_fnc_showMedBtn;};

private _type = ["STRING", ["LifeCfgVehicles", (typeOf _veh), "type"]] call ALFTools_Client_Config_fnc_getConfig;

[] call 
{
	if (_type isEqualTo "TRUCK") exitWith 
	{
		[_veh] spawn ALF_fnc_showTruckStats;
		[_veh] spawn ALF_fnc_showTruckBtn;
	}; 
	if (_type isEqualTo "MOTO") exitWith 
	{
		[_veh] spawn ALF_fnc_showMotoStats;
		[_veh] spawn ALF_fnc_showMotoBtn;
	}; 
	if (_type isEqualTo "BOAT") exitWith 
	{
		[_veh] spawn ALF_fnc_showBoatStats;
		[_veh] spawn ALF_fnc_showBoatBtn;
	}; 
	if (_type isEqualTo "HELI") exitWith 
	{
		[_veh] spawn ALF_fnc_showHeliStats;
		[_veh] spawn ALF_fnc_showHeliBtn;
	};
	if (_type isEqualTo "CAR") then 
	{
		[_veh] spawn ALF_fnc_showCarStats;
		[_veh] spawn ALF_fnc_showCarBtn;
	};
};

if(_load) then 
{
	for "_i" from 0 to 1 step 0 do 
	{
		if (isNull (findDisplay 30200)) exitWith {};
		if (player distance _veh > 30) exitWith {closeDialog 0;};
		if (isNull _veh) exitWith {closeDialog 0;};
		uiSleep 1;
	};
};
// };