// MRPV2_fnc_Vehicule_Garage_Importer = {
// [toupper 'dans MRPV2_fnc_Vehicule_Garage_Importer'] remoteExec ['systemchat',0];
// disableSerialization;
private _type_Garage = param [0,""];
private _plaque = param [1,""];
private _classe_Veh = param [2,""];
if ((lbCurSel 2802) isEqualTo -1) exitWith {hint localize "STR_Global_NoSelection";};
// ['_type_Garage ' + str(_type_Garage)] remoteExec ['systemchat',0];
// ['_plaque ' + str(_plaque)] remoteExec ['systemchat',0];
// private _classe_Veh = lbData[2802,(lbCurSel 2802)];
// _classe_Veh = (call compile format["%1",_classe_Veh]) select 0;

// private _id_Veh = lbValue[2802,(lbCurSel 2802)];
// ['_classe_Veh ' + str(_classe_Veh)] remoteExec ['systemchat',0];
// ['_id_Veh ' + str(_id_Veh)] remoteExec ['systemchat',0];
// if (isNil "_classe_Veh") exitWith {hint localize "STR_Garage_Selection_Error"};

_returnClass = [["LifeCfgVehicles", _classe_Veh]] call ALFTools_Client_Config_fnc_isClass;
if !(_returnClass) then 
{
	_classe_Veh = "Default"; 
	diag_log format["%1: LifeCfgVehicles class doesn't exist",_vehicule];
};

private _prix_Achat = ["NUMBER", ["LifeCfgVehicles",_classe_Veh,"achat"]] call ALFTools_Client_Config_fnc_getConfig;
private _prix_Import = _prix_Achat * 0.01;
// ['_prix_Achat' + str(_prix_Achat)] remoteExec ['systemchat',0];
// ['_prix_Import' + str(_prix_Import)] remoteExec ['systemchat',0];
private _action = "";

if ("Civil" in _type_Garage) then 
{
	_action = [format["Êtes-vous sûr de vouloir importer ce véhicule pour <t color='#74DF00'>%1 € ?</t>",_prix_Import],"Validation","Importer","Annuler"] call BIS_fnc_guiMessage;
} else
{
	_action = ["Êtes-vous sûr de vouloir importer ce véhicule ?</t>","Validation","Importer","Annuler"] call BIS_fnc_guiMessage;
};

private _exit = false;
if (_action) then
{
	if(_type_Garage isEqualTo "GN") exitWith {_type_Garage = "vehicles_cop";};
	if(_type_Garage isEqualTo "SP") exitWith {_type_Garage = "vehicles_med";};
	if(_type_Garage isEqualTo "PM") exitWith {_type_Garage = "vehicles_penit";};
	if(_type_Garage isEqualTo "Civil") then 
	{
		if(_prix_Import > life_cash) then 
		{
			private _handle = [_prix_Import,false] call ALF_fnc_handleCB;
			if(_handle) then 
			{
				_exit = true;
				["INFO","Vous n'avez pas assez d'argent sur vous ou sur votre compte pour importer le véhicule.","warning"] spawn ALF_fnc_doMsg;
			};			
		} else 	
		{
			life_cash = life_cash - _prix_Import;
		};

		_type_Garage = "vehicles";
	};	   
};
if (!_action OR {_exit}) exitWith {};
// ['_type_Garage adada ' + str(_type_Garage)] remoteExec ['systemchat',0];
[player,_type_Garage,_plaque] remoteExec ["MRPV2_Server_fnc_Vehicule_Garage_Importer_BDD",2];
closeDialog 0;
// };