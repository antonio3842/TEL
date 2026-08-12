// ALF_fnc_garageLBBusiness = {
disableSerialization;
private _control = _this # 0;
private _index = _this # 1;

private _dataArr = _control lbData _index;
_dataArr = call compile format["%1",_dataArr];

private _className = _dataArr # 0;
private _plaque = _dataArr # 1;
private _fuel = _dataArr # 2;
private _insure = _dataArr # 3;

private _building = life_veh_shop;
private _var = _building getVariable ["business",[]];

private _uid = getPlayerUID player;
 
   private _joueur_Est_Gerant = ((_var # 5) select { 
    (_x # 1) isEqualTo _uid AND {(_x # 2) in [3,4]} 
   }) isNotEqualTo [];


private _fuelFinal = format["%1",floor(_fuel * 100)];

_returnClass = [["LifeCfgVehicles", _className]] call ALFTools_Client_Config_fnc_isClass;
if !(_returnClass) then {_className = "Default";};

private _vehicleInfo = [_className] call ALF_fnc_fetchVehInfo;

private _retrievePrice = ["NUMBER",["LifeCfgVehicles", _className, "sortie"]] call ALFTools_Client_Config_fnc_getConfig;
private _sellPrice = ["NUMBER",["LifeCfgVehicles", _className, "vente"]] call ALFTools_Client_Config_fnc_getConfig;

if(_sellPrice < 1) then {_sellPrice = 50;};
if(_retrievePrice < 1) then {_retrievePrice = 50;};
if(_insure isEqualTo 0 && {_joueur_Est_Gerant}) then { ctrlShow [97480,true]; } else { ctrlShow [97480,false]; };
if(_joueur_Est_Gerant) then { ctrlShow [97479,true]; } else { ctrlShow [97479,false]; };
private _d = findDisplay 2800;
private _btnassu = _d displayCtrl 97480;

if (_joueur_Est_Gerant && {_insure isEqualTo 1 OR _insure isEqualTo 3}) then 
{
	_btnassu ctrlShow true;
	_btnassu ctrlSetStructuredText parseText toupper "RéSILIATION";
	_btnassu buttonSetAction "[1] spawn ALF_fnc_insureBusiness;";
} else 
{
	if (_joueur_Est_Gerant) then 
	{
		_btnassu ctrlShow true;
		_btnassu ctrlSetStructuredText parseText "ASSURER";
		_btnassu buttonSetAction "[0] spawn ALF_fnc_insureBusiness;";
	} else 
	{
		_btnassu ctrlShow false;
	};
};

(((findDisplay 2800) displayCtrl 2803)) ctrlSetStructuredText parseText format["
	Véhicule : %1<br/>
	Prix de sortie : <t color='#8cff9b'>%2€</t><br/>
	Prix de vente : <t color='#8cff9b'>%3€</t><br/>
	Assurance : %12<br/>
	Siège passager : <t color='#8cff9b'>%9</t><br/>
	Réservoir : <t color='#8cff9b'>%4%5</t><br/>
	Plaque : <t color='#8cff9b'>%6</t><br/>
	Vitesse Max : <t color='#8cff9b'>%7 km/h</t><br/>
	Puissance : <t color='#8cff9b'>%10 rtpm</t><br/>
	Résistance : <t color='#8cff9b'>%8</t><br/>
	Volume du coffre : <t color='#8cff9b'>%11</t><br/>
	",
_vehicleInfo # 3,
[_retrievePrice] call ALF_fnc_numberText,
[_sellPrice] call ALF_fnc_numberText,
_fuelFinal,
"%",
_plaque,
_vehicleInfo # 7,
_vehicleInfo # 8,
_vehicleInfo # 9,
_vehicleInfo # 10,
_vehicleInfo # 12,
if(_insure >= 1) then {"<t color='#8cff9b'>Assuré</t>"} else {"<t color='#FF0000'>Pas d'assurance</t>"}
];

ctrlShow [2803,true];
ctrlShow [2830,true];
// };