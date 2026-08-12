// ALF_fnc_vehicleShopBuyCopSP = {
params [["_type","",[""]]];

if((time - life_action_delay) < 0.5) exitWith {["INFO", "Vous appuyez trop vite.", "warning"] spawn ALF_fnc_doMsg;};
life_action_delay = time;

private _exit = false;
private _className = lbData[2302,(lbCurSel 2302)];
private _classNameLife = _className;
private _licenses = ["STRING", ["LifeCfgVehicles", _classNameLife, "licenses"]] call ALFTools_Client_Config_fnc_getConfig;
private _purchasePrice = ["NUMBER", ["LifeCfgVehicles", _classNameLife, "achat"]] call ALFTools_Client_Config_fnc_getConfig;

if !(_licenses isEqualTo "") then 
{
	private _varnameConfig = ["STRING", ["Licenses", _licenses, "variable"]] call ALFTools_Client_Config_fnc_getConfig;
	private _licenceConfigVal = missionNamespace getVariable [format["license_%1",_varnameConfig], false];
	if !(_licenceConfigVal) then {_exit = true;};
};
if(_exit) exitWith {["INFO", "Vous n'avez pas le permis requis.", "warning"] spawn ALF_fnc_doMsg; closeDialog 0;};
if(_purchasePrice < 0) exitWith {closeDialog 0;};

private _vehicle = [_className,life_veh_shop # 0,player] call MRPV2_fnc_Vehicule_Creation;

if (isnull _vehicle) exitWith {["INFO", "Un véhicule gène le point de sortie.", "warning"] spawn ALF_fnc_doMsg; closeDialog 0;};

[_uid,_vehicle,_unit] call ALF_Server_fnc_vehicleCreate;

// private _type_veh = switch (true) do 
// {
// 	case (_vehicle isKindOf "Car"): {"Car"};
// 	case (_vehicle isKindOf "Air"): {"Air"};
// 	case (_vehicle isKindOf "Ship"): {"Ship"};
// };

[] call 
{
	if(_type isEqualTo "GN") exitWith 
	{
		private _value = missionNamespace getVariable ["CNG",0];
		if(_value < _purchasePrice) exitWith {["INFO","Il n'y a pas assez dans les caisses.","warning"] spawn ALF_fnc_doMsg; _exit = true;};

		_value = _value - _purchasePrice;
		missionNamespace setVariable ["CNG",_value,true];
		[getPlayerUID player,name player,_purchasePrice] remoteExec ["ALF_Server_fnc_retirerCNG",2];
	};
	if(_type isEqualTo "SP") then 
	{
		private _value = missionNamespace getVariable ["CNP",0];
		if(_value < _purchasePrice) exitWith {["INFO","Il n'y a pas assez dans les caisses.","warning"] spawn ALF_fnc_doMsg; _exit = true;};

		_value = _value - _purchasePrice;
		missionNamespace setVariable ["CNP",_value,true];
		[getPlayerUID player,name player,_purchasePrice] remoteExec ["ALF_Server_fnc_retirerCNP",2];
	};
};
if(_exit) exitWith {};

closeDialog 0;

["INFO", format["Détail de votre commande : %1 pour %2€.",getText(configFile >> "CfgVehicles" >> _className >> "displayName"),[_purchasePrice] call ALF_fnc_numberText], "success"] spawn ALF_fnc_doMsg;

[_type,_className,_type_veh,player,_vehicle] remoteExecCall ["ALF_Server_fnc_insertVehicleCopSP",2];

true;
// };