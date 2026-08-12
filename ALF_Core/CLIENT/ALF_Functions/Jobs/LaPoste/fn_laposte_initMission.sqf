// ALF_fnc_laposte_initMission = {
if !(alive player) exitWith {};
if !(isNil {player getVariable "ALF_LaPoste_Mission"}) exitWith {["La Poste", "Tu es déja en service", "danger"] spawn ALF_fnc_doMsg;};
if !(license_driver) exitWith {["La Poste", "Tu ne dispose pas du permis de conduire", "danger"] spawn ALF_fnc_doMsg;};
ALF_LaPosteEnCours = false;
ALF_colisPris = false;

private _arrayVille 		= ["ARRAY", ["ALF_LA_POSTE_CONFIG", "liste_villes"]] call ALFTools_Client_Config_fnc_getConfig;
private _arrayCar 			= ["ARRAY", ["ALF_LA_POSTE_CONFIG", "classname"]] call ALFTools_Client_Config_fnc_getConfig;
private _selectRandomVille 	= selectRandom _arrayVille;
private _selectRandomCar 	= selectRandom _arrayCar;

//Return de l'adresse
[_selectRandomVille, player] remoteExec ["ALF_Server_fnc_laposte_returnHouse",2];

waitUntil {!(isNil{player getVariable "ALF_LaPosteHouse"})};

private _house = player getVariable ["ALF_LaPosteHouse", objNull];

//On random la qdt.
private _qdt = ceil(random 10);

//On random l'etg.
private _etg = ceil(random [2,4,9]);
systemChat str _etg;

//On set les var.
player setVariable["ALF_LaPoste_Mission", [_house, getPosATL _house, _qdt, _etg]];
player setVariable["ALF_LaPoste_Colis", 0];

//On Check les spawns.
private _nearestCar1  = []; 
private _nearestCar2  = [];

_nearestCar1 = nearestObjects[(getMarkerPos "vide_laposte1"), ["Car"], 5];
_nearestCar2 = nearestObjects[(getMarkerPos "vide_laposte2"), ["Car"], 5];

if (((count _nearestCar1) > 0) && ((count _nearestCar2) > 0)) exitWith 
{
	["La Poste", "Le point de sortie du véhicule est encombré !!", "danger"] spawn ALF_fnc_doMsg
};

//On créé le veh.
private _vehicle = objNull;
switch (true) do {
	case ((count _nearestCar1) isEqualTo 0): 
	{
		_vehicle = _selectRandomCar createVehicle (getMarkerPos "vide_laposte1");
		_vehicle setdir (markerDir "vide_laposte1");
	};
	case ((count _nearestCar2) isEqualTo 0):
	{
		_vehicle = _selectRandomCar createVehicle (getMarkerPos "vide_laposte2");
		_vehicle setdir (markerDir "vide_laposte2");
	};
};
private _plaque = [] call MRPV2_fnc_Vehicule_Creation_Plaque;

life_vehicles pushBack _vehicle;
_vehicle setVariable["owner", getPlayerUID player];
_vehicle setVariable["vehicle_info_owners",["",getPlayerUID player],true];
_vehicle setVariable["dbInfo",[(getPlayerUID player),_plaque,1,10,0],true];
_vehicle setVariable["Flashed",false];
_vehicle setPlateNumber _plaque;

_plaque = _plaque splitString "";
_vehicle setObjectTextureGlobal [1, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plaque # 0]];
_vehicle setObjectTextureGlobal [2, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plaque # 1]];
_vehicle setObjectTextureGlobal [3, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plaque # 3]];
_vehicle setObjectTextureGlobal [4, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plaque # 4]];
_vehicle setObjectTextureGlobal [5, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plaque # 5]];
_vehicle setObjectTextureGlobal [6, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plaque # 7]];
_vehicle setObjectTextureGlobal [7, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plaque # 8]];

clearMagazineCargo _vehicle;
clearItemCargo _vehicle;
_plaque = _plaque joinstring "";
if (isnil "ALF_LAPOSTE_CARS") then 
{
	ALF_LAPOSTE_CARS = [];
	ALF_LAPOSTE_CARS pushBack [_plaque, player];
	publicVariable "ALF_LAPOSTE_CARS";
}else 
{
	ALF_LAPOSTE_CARS pushBack [_plaque, player];
	publicVariable "ALF_LAPOSTE_CARS";
};

ALF_LaPosteEnCours = true;

["La Poste", "Vous venez de prendre votre service, habillez-vous et allez chercher les colis sur les étagères !!", "warning"] spawn ALF_fnc_doMsg;

player setVariable["ALF_LaPosteHouse", nil, true];
// };