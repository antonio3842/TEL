// ALF_fnc_garageLBChangeLock = {

disableSerialization;
private["_plaque","_fuel","_control","_index","_className","_dataArr","_vehicleColor","_vehicleInfo","_sellPrice","_retrievePrice","_insure","_pid"];
_control = (_this # 0);
_index = (_this # 1);

private _d = findDisplay 2800;

_dataArr = _control lbData _index;
_dataArr = parseSimpleArray _dataArr;

_className = _dataArr # 0;
_pid = _dataArr # 1;
_plaque = _dataArr # 2;
_fuel = _dataArr # 3;
_insure = _dataArr # 4;
_heure_Fourr = parseSimpleArray (_dataArr # 5);
MRPV2_ClassName_Fourr = _className;
MRPV2_Plaque_Fourr = _plaque;


private _systemTimeUTC_Format = systemTimeutc;
_systemTimeUTC_Format resize 5;

private _dateToNumber_Date_Auj = dateToNumber _systemTimeUTC_Format;
private _dateToNumber_Date_Fourr = dateToNumber _heure_Fourr;

private _nombre_Temps_Restant = (_dateToNumber_Date_Fourr - _dateToNumber_Date_Auj);
MRPV2_Nombre_Temps_Restant_Fourriere = _nombre_Temps_Restant toFixed 12;

private _temps_Restant = numberToDate [systemTimeutc # 0,_nombre_Temps_Restant];

private _heures = 0;
private _minutes = 0;

if (_nombre_Temps_Restant > 0) then 
{
	if (_temps_Restant # 2 > 1) then 
	{
		_heures = _temps_Restant # 3 + (((_temps_Restant # 2)-1) * 24);
	} else 
	{
		_heures = _temps_Restant # 3;
	};
	
	_minutes = _temps_Restant # 4;
};

private _fuelFinal = format ["%1",floor(_fuel * 100)];

private _returnClass = [["LifeCfgVehicles", _className]]call ALFTools_Client_Config_fnc_isClass;
if !(_returnClass) then 
{
	_className = "Default"; 
	diag_log format ["%1: LifeCfgVehicles class doesn't exist",_className];
};

_vehicleInfo = [_className] call ALF_fnc_fetchVehInfo;

_retrievePrice = ["NUMBER",["LifeCfgVehicles", _className, "sortie"]]call ALFTools_Client_Config_fnc_getConfig;
_sellPrice = ["NUMBER",["LifeCfgVehicles", _className, "vente"]]call ALFTools_Client_Config_fnc_getConfig;

if (_sellPrice < 1) then {_sellPrice = 50;};
if (_retrievePrice < 1) then {_retrievePrice = 50;};

((findDisplay 2800) displayCtrl 2803) ctrlSetStructuredText parseText format
["
	Véhicule : %1<br/>
	Temps restant(s) : <t color='#8cff9b'>%2h%3m</t><br/>
	Prix de sortie : <t color='#8cff9b'>%4€</t><br/>
	Assurance : %5<br/><br/>
	Siège passager : <t color='#8cff9b'>%6</t><br/>
	Réservoir : <t color='#8cff9b'>%7</t><br/>
	Plaque : <t color='#8cff9b'>%8</t><br/>
	Vitesse Max : <t color='#8cff9b'>%9 km/h</t><br/>
	Puissance : <t color='#8cff9b'>%10 rtpm</t><br/>
	Résistance : <t color='#8cff9b'>%11</t><br/>
	Volume du coffre : <t color='#8cff9b'>%12</t><br/>
	",
	_vehicleInfo # 3,
	_heures,
	_minutes,
	[_retrievePrice] call ALF_fnc_numberText,
	if (_insure isEqualTo 1) then {"<t color='#8cff9b'>Assuré</t>"} else {"<t color='#FF0000'>Pas d'assurance</t>"},
	_vehicleInfo # 9,
	_fuelFinal,
	_plaque,
	_vehicleInfo # 7,
	_vehicleInfo # 10,
	_vehicleInfo # 11,
	_vehicleInfo # 12
];

ctrlShow [2803,true];
ctrlShow [2830,true];
// };