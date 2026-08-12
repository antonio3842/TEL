#include "\ALF_Client\script_macros.hpp"
/*
	File: fn_searchVehAction.sqf
	Author:

	Description:

*/
private["_vehicle","_data"];
_vehicle = cursorObject;
if((_vehicle isKindOf "Car") OR {!(_vehicle isKindOf "Air") OR {!(_vehicle isKindOf "Ship")}}) then 
{
	_owners = (_vehicle getVariable ["vehicle_info_owners",["",""]]) # 1;
	if(_owners isEqualTo "") exitWith {hint localize "STR_NOTF_VehCheat"; deleteVehicle _vehicle;};

	life_action_inUse = true;
	hint localize "STR_NOTF_Searching";

	sleep 3;
	life_action_inUse = false;

	if(player distance _vehicle > 10 OR {!alive player OR {!alive _vehicle}}) exitWith {hint localize "STR_NOTF_SearchVehFail";};
	_owners = [_owners] call life_fnc_vehicleOwners;

	if(_owners isEqualTo "any<br/>") then {_owners = "Pas de propriétaire, à la fourrière !<br/>";};
	hint parseText format[localize "STR_NOTF_SearchVeh",_owners];
};