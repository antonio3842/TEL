_class_vehicles_luxe = (getArray(configFile >> "ALF_ConfigClient_Core" >> "CarShops" >> "luxe" >> "vehicles")) apply {_x select 0};
_class_vehicles_peugeot = (getArray(configFile >> "ALF_ConfigClient_Core" >> "CarShops" >> "peugeot" >> "vehicles")) apply {_x select 0};
_class_vehicles_renault = (getArray(configFile >> "ALF_ConfigClient_Core" >> "CarShops" >> "renault" >> "vehicles")) apply {_x select 0};
_class_vehicles_audi = (getArray(configFile >> "ALF_ConfigClient_Core" >> "CarShops" >> "audi" >> "vehicles")) apply {_x select 0};
_class_vehicles_sports = (getArray(configFile >> "ALF_ConfigClient_Core" >> "CarShops" >> "sports" >> "vehicles")) apply {_x select 0};
_class_vehicles_citadines = (getArray(configFile >> "ALF_ConfigClient_Core" >> "CarShops" >> "citadines" >> "vehicles")) apply {_x select 0};
_class_vehicles_suv = (getArray(configFile >> "ALF_ConfigClient_Core" >> "CarShops" >> "suv" >> "vehicles")) apply {_x select 0};
_class_vehicles_camion = (getArray(configFile >> "ALF_ConfigClient_Core" >> "CarShops" >> "camion" >> "vehicles")) apply {_x select 0};

_all_classes = _class_vehicles_luxe + _class_vehicles_peugeot + _class_vehicles_renault + _class_vehicles_audi + _class_vehicles_sports + _class_vehicles_citadines + _class_vehicles_suv + _class_vehicles_camion;

_getAllVehicles = (nearestObjects [[worldSize/2, worldSize/2], _all_classes, (sqrt 2) / 2 * worldSize]) apply {typeOf _x};
_getAllVehicles = _getAllVehicles arrayIntersect _getAllVehicles;
_nb = count _getAllVehicles;
if (_nb == 0) exitWith {};
if (_nb > 4) then {_nb = 4;};


_MRP_vehicle_to_search = [];
for "_i" from 1 to _nb do {
    _vehicle = (selectRandom _getAllVehicles);
    _MRP_vehicle_to_search pushback _vehicle;
    _getAllVehicles = _getAllVehicles - [_vehicle];
};
missionNamespace setVariable ["MRP_vehicle_to_search",_MRP_vehicle_to_search, true];