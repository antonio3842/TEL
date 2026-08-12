// ALF_fnc_storeVehicleCopSP = {
private _joueur = param [0,objnull];
private _type_Veh = param [1,""];
private _type_Garage = param [2,""];

private["_nearVehicles","_vehicle"];
if(vehicle player != player) then 
{
	_vehicle = vehicle player;
} else 
{
	_nearVehicles = nearestObjects [(getPos (_this select 0)), ["Car","Air","Ship"], 30];
	if(count _nearVehicles > 0) then 
	{
		{
			if(!isNil "_vehicle") exitWith {};
			if (((_x getVariable ["vehicle_info_owners",["",""]]) # 0) in ["Gendarmerie", "Pompiers","policemunicipale"]) then {_vehicle = _x;};
		} forEach _nearVehicles;
	};
};

if(isNil "_vehicle") exitWith {hint localize "STR_Garage_NoNPC"};
if(isNull _vehicle) exitWith {hint "Erreur : storeVehicleCopSP #1";};
if(!alive _vehicle) exitWith {hint localize "STR_Garage_SQLError_Destroyed"};

if (_vehType != "") then 
{
    if !(_vehicle isKindOf _vehType) exitWith {["Garage", "Ce garage ne permet pas de ranger ce type de véhicule.", "danger", false] spawn ALF_fnc_doMsg;};
};

if (isEngineOn _vehicle) exitWith 
{
    ["Garage", "Il est impossible de rentrer un véhicule qui a son moteur allumé.", "danger", false] spawn ALF_fnc_doMsg;
};

if (((_vehicle getVariable ["vehicle_info_owners",["",""]]) # 0) isEqualTo "Gendarmerie") then 
{
	[_vehicle,_type_Veh,(_this select 1),_garageId] remoteExec ["ALF_Server_fnc_vehicleStoreCopSP",2];
} else 
{
	[_vehicle,_type_Veh,(_this select 1),_garageId] remoteExec ["ALF_Server_fnc_vehicleStoreCopSP",2];
};

life_garage_store = true;
// };

// [player,"CAR","GN"] call ALF_fnc_storeVehicleCopSP;