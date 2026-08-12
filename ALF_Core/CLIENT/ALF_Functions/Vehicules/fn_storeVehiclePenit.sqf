_args = [_this,3,[],[[-1,0,"CAR"]]] call BIS_fnc_param;
_garageId = _args select 0;
_vehType = _args select 1;

private["_nearVehicles","_vehicle"];
if(vehicle player != player) then {
	_vehicle = vehicle player;
} else {
	_nearVehicles = nearestObjects [(getPos (_this select 0)), ["Car","Air","Ship"], 30];
	if(count _nearVehicles > 0) then {
		{
			if(!isNil "_vehicle") exitWith {};
			if (((_x getVariable ["vehicle_info_owners",["",""]]) # 0) in ["policemunicipale"]) then {
				_vehicle = _x;
			};
		} forEach _nearVehicles;
	};
};

if(isNil "_vehicle") exitWith {hint localize "STR_Garage_NoNPC"};
if(isNull _vehicle) exitWith {hint "Erreur : storeVehiclePenit #1";};
if(!alive _vehicle) exitWith {hint localize "STR_Garage_SQLError_Destroyed"};

if (_vehType != "") then {
    if (!(_vehicle isKindOf _vehType)) exitWith {["Garage", "Ce garage ne permet pas de ranger ce type de véhicule.", "danger", false] spawn ALF_fnc_doMsg;};
};

if (isEngineOn _vehicle) exitWith {
    ["Garage", "Il est impossible de rentrer un véhicule qui a le moteur allumé.", "danger", false] spawn ALF_fnc_doMsg;
};

[_vehicle,(_this select 1),_garageId] remoteExec ["ALF_Server_fnc_vehicleStorePenit",2];


life_garage_store = true;