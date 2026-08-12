// ALF_fnc_unimpound = {
private["_vehicleLife","_vid","_pid","_price","_purchasePrice","_exit"];
_exit = false;

disableSerialization;

if(lbCurSel 2802 isEqualTo -1) exitWith {hint localize "STR_Global_NoSelection"};

private _vehicle = lbData[2802,(lbCurSel 2802)];

_vehicle = (call compile format["%1",_vehicle]) select 0;
_vehicleLife = _vehicle;
_vid = lbValue[2802,(lbCurSel 2802)];
_pid = getPlayerUID player;
_spawntext = localize "STR_Garage_spawn_Success";

if(isNil "_vehicle") exitWith {hint localize "STR_Garage_Selection_Error"};

_returnClass = [["LifeCfgVehicles", _vehicleLife]]call ALFTools_Client_Config_fnc_isClass;
if(!_returnClass) then 
{
	_vehicleLife = "Default";
	diag_log format["%1: LifeCfgVehicles class doesn't exist",_vehicle];
};

_price = ["NUMBER",["LifeCfgVehicles", _vehicleLife,"sortie"]]call ALFTools_Client_Config_fnc_getConfig;
_purchasePrice = ["NUMBER",["LifeCfgVehicles", _vehicleLife,"achat"]]call ALFTools_Client_Config_fnc_getConfig;
if (_purchasePrice > 50000) then {_price = round(_purchasePrice * 0.0001);};

if(_price > life_cash) then 
{
	private _handle = [_price,false] call ALF_fnc_handleCB;
	if(_handle) exitWith {_exit = true;};
} else 
{
	life_cash = life_cash - _price;
};

if (_exit) exitWith {};

if (isnil {life_garage_sp}) then {life_garage_sp = "Nique SaM"}; 

if(life_garage_sp isEqualType []) then 
{
	[_vid,_pid,if (isNil "life_garage_sp") then {"valeur_par_défaut"} else {if (life_garage_sp isEqualType []) then {life_garage_sp select 0} else {life_garage_sp}},player,_price,if (isNil "life_garage_sp") then {"valeur_par_défaut"} else {if (life_garage_sp isEqualType []) then {life_garage_sp select 1} else {""}},_spawntext] remoteExec ["ALF_Server_fnc_spawnVehicle",2];
} else 
{
	if(life_garage_sp in ["med_heli_1","cop_heli_1","cop_heli_2","cop_heli_3"]) then 
	{
		[_vid,_pid,life_garage_sp,player,_price,0,_spawntext] remoteExec ["ALF_Server_fnc_spawnVehicle",2];
	} else 
	{
		[_vid,_pid,(getMarkerPos life_garage_sp),player,_price,markerDir life_garage_sp,_spawntext] remoteExec ["ALF_Server_fnc_spawnVehicle",2];
	};
};

[0] call SOCK_fnc_updatePartial;
closeDialog 0;
// };