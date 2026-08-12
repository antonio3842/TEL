// MRPV2_fnc_Vehicule_Garage_Sortir = {
private _classname = param [0,""];
private _type_Veh = param [1,""];
private _type_Garage = param [2,""];
private _plaque = param [3,""];

private _quitter = FALSE;


private _prix_Sortie = ["NUMBER",["LifeCfgVehicles", _classname,"sortie"]]call ALFTools_Client_Config_fnc_getConfig;
private _prix_Achat = ["NUMBER",["LifeCfgVehicles", _classname,"achat"]]call ALFTools_Client_Config_fnc_getConfig;
if (_prix_Achat > 50000) then {_prix_Sortie = round(_prix_Achat * 0.0001);};

closeDialog 0;

if (_type_Garage in ["Civil Garage"] AND {!(cursorObject in life_vehicles)}) then 
{
	private _quitter_handle = false;
	if(_prix_Sortie <= life_cash) exitWith {life_cash = life_cash - _prix_Sortie;};

	private _handle = [_prix_Sortie,false] call ALF_fnc_handleCB;

	if (_handle) exitWith {_quitter = true;};
	if !(_handle) exitWith {_quitter_handle = true;};
	if (_quitter_handle) exitWith {};

	["GARAGE", "Vous n'avez pas assez d'argent sur vous ou votre compte pour sortir votre véhicule.", "warning"] spawn ALF_fnc_doMsg;
	_quitter = true;
};
if (_quitter) exitWith {};

[] call
{
	if (typeof cursorObject isequalto "Land_ALF_MaisonContemporaine") exitwith {_type_Garage ="MaisonContemporaine";};
	if ("Land_House" in typeof cursorObject) exitwith {_type_Garage ="LandHouse";};
	if ("Land_ALF_MaisonMitoyenne" in typeof cursorObject) exitwith {_type_Garage ="MaisonMitoyenne";};
	private _maisonGarage = life_pInact_curObject;
	if (!isNull _maisonGarage AND {"Land_Residence_A" in typeof _maisonGarage}) exitwith {_type_Garage = "Residence_A";};
	if ("Land_Residence_A" in typeof cursorObject) exitwith {_type_Garage = "Residence_A";};
};

_vehicle = [_classname,_type_Garage,player,_plaque] call MRPV2_fnc_Vehicule_Creation;
if (isNull _vehicle) exitWith 
{
	if (_type_Garage in ["Civil Garage"]) then 
	{
		if !(cursorObject in life_vehicles) then 
		{
			life_cash = life_cash + _prix_Sortie;
			["GARAGE",format ["Votre véhicule n'a pu être livré. Vous avez été remboursé de %1 € en liquide.",_prix_Sortie], "success"] spawn ALF_fnc_doMsg;
		};
	};
	
	closeDialog 0;
};

["INFO", "Votre véhicule a bien été livré.", "success"] spawn ALF_fnc_doMsg;
// };