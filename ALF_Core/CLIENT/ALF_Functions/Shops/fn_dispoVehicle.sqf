#include "\ALF_Client\script_macros.hpp"
/*
	File: fn_dispoVehicle.sqf
	Author: ALF Team
*/
disableSerialization;
params[
	["_className","",[""]],
	["_dispo",0,[0]]
];
if(_className isEqualTo "") exitWith {};

private _display = findDisplay 2300;
private _btnbye = _display displayCtrl 2309;
private _classNameLife = _className;
private _achat = ["NUMBER", [CONFIG_LIFE_VEHICLES, _classNameLife, "achat"]] call ALFTools_Client_Config_fnc_getConfig;

if (!isNil "life_veh_shop") then {
	private _shopName = "";
	private _batiment = objNull;	

	{
		if (typeName _x == "STRING" && {_x != ""}) then {
			if (_shopName == "" || {_x find "b_" >= 0}) then {
				_shopName = _x;
			};
		};
		if (typeName _x == "OBJECT" && {!isNull _x}) then {
			_batiment = _x;
		};
	} forEach life_veh_shop;
	
	if (_shopName == "" && count life_veh_shop > 0) then {
		_shopName = life_veh_shop # 0;
	};
	if (isNull _batiment && count life_veh_shop >= 4) then {
		_batiment = life_veh_shop # 3;
	}
	else {
		private _nearBuildings = nearestObjects [player, ["Land_MRP_Concessionnaire"], 20];
		if (count _nearBuildings > 0) then {
			_batiment = _nearBuildings # 0;
		};
	};	

	if (_shopName isEqualTo "b_33" && {!isNull _batiment}) then {
		private _bizData = _batiment getVariable ["business", []];		

		if (count _bizData >= 5) then {
			private _secteur = _bizData # 4;			

			if (typeName _secteur == "STRING") then {
				_secteur = parseNumber _secteur;
			};
			
			if (_secteur == 33) then {
				_achat = _achat * 0.5;
			};
		};
	};
};
private _vehicleInfo = [_className] call ALF_fnc_fetchVehInfo;
private _maxspeed = _vehicleInfo select 7;
private _horsepower = _vehicleInfo select 10;
private _passengerseats = _vehicleInfo select 9;
private _fuel = _vehicleInfo select 11;
private _armor = _vehicleInfo select 8;
private _coffre = _vehicleInfo select 12;

/* EDIT PRESTIGE */
private _mmPrestigeP 	= ["ARRAY", ["CarShops", "mmprestigeclasseAP", "vehicles"]] call ALFTools_Client_Config_fnc_getConfig;
private _mmPrestigeA 	= ["ARRAY", ["CarShops", "mmprestigeclasseA", "vehicles"]] call ALFTools_Client_Config_fnc_getConfig;
private _mmPrestigeB 	= ["ARRAY", ["CarShops", "mmprestigeclasseB", "vehicles"]] call ALFTools_Client_Config_fnc_getConfig;
private _mmPrestigeC 	= ["ARRAY", ["CarShops", "mmprestigeclasseC", "vehicles"]] call ALFTools_Client_Config_fnc_getConfig;
private _mmPrestigeAN 	= ["ARRAY", ["CarShops", "mmprestigeAncienne", "vehicles"]] call ALFTools_Client_Config_fnc_getConfig;

private _exit = false;

{
	_x params["_className", "_p2", "_p3"];
	if (_className isEqualTo _classNameLife) exitWith {_exit = true};
	
} forEach (_mmPrestigeP + _mmPrestigeA + _mmPrestigeB + _mmPrestigeC + _mmPrestigeAN);


ctrlShow [2330,true];
(CONTROL(2300,2303)) ctrlSetStructuredText parseText format[
	(localize "STR_Shop_Veh_UI_Ownership")+ " <t color='#8cff9b'>%1€</t><br/>Type de plaque : <t color='#8cff9b'>Française</t><br/>" +
	(localize "STR_Shop_Veh_UI_MaxSpeed")+ " %2 km/h<br/>" +
	(localize "STR_Shop_Veh_UI_HPower")+ " %3<br/>" +
	(localize "STR_Shop_Veh_UI_PSeats")+ " %4<br/>" +
	(localize "STR_Shop_Veh_UI_Fuel")+ " %5<br/>" +
	(localize "STR_Shop_Veh_UI_Armor")+ " %6<br/>Volume du coffre : %7<br/><br/>Disponibilité : %8",
	if (_exit) then {"Non visible"} else {[_achat] call ALF_fnc_numberText},
	_maxspeed,
	_horsepower,
	_passengerseats,
	_fuel,
	_armor,
	_coffre,
	if(_dispo isEqualTo 0) then {"<t color='#FF0000'>Stock épuisé</t>"} else {format["<t color='#8cff9b'>%1 restant(s)</t>",_dispo]}
];

_returnClass = [[CONFIG_LIFE_VEHICLES, _classNameLife]] call ALFTools_Client_Config_fnc_isClass;
if(!_returnClass) then {
	_classNameLife = "Default";
};

if(_dispo > 0) then {_btnbye ctrlEnable true;} else {_btnbye ctrlEnable false;};
