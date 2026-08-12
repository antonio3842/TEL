// ALF_fnc_garageLBChangeCopSP = {
disableSerialization;
private["_control","_index","_dataArr","_vehicleInfo"];
_control = _this # 0;
_index = _this # 1;

private _display = findDisplay 2801;
private _controlsGroup = _display displayCtrl 2804;
private _controlText = _controlsGroup controlsGroupCtrl 2803;

private _btnsortir = _display displayCtrl 97482;
private _btnvendre = _display displayCtrl 97483;
_btnvendre ctrlShow false;

_dataArr = _control lbData _index;
if (_dataArr isEqualTo "affichage") exitWith 
{
	_btnsortir ctrlShow false;
	_btnvendre ctrlShow false;
	ctrlShow [2804,false];
	ctrlShow [2830,false];
};

_dataArr = parseSimpleArray _dataArr;

_btnsortir ctrlShow true;

if (!isnil  {life_mediclevel} AND {life_mediclevel > 8}) then 
{
	_btnvendre ctrlShow true;
};

if (!isnil  {life_coplevel} AND {life_coplevel > 8}) then 
{
	_btnvendre ctrlShow true;
};

if (!isnil  {life_penit} AND {life_penit > 8}) then 
{
	_btnvendre ctrlShow true;
};

ctrlShow [2804,true];

private _className = _dataArr # 0;
private _plaque = _dataArr # 1;
private _pos_veh = (parseSimpleArray (_dataArr # 2)) # 0;
private _fuel = _dataArr # 3;
private _damage = _dataArr # 4;

_returnClass = [["LifeCfgVehicles", _className]]call ALFTools_Client_Config_fnc_isClass;
if !(_returnClass) then 
{
	_className = "Default"; 
	diag_log format["%1: LifeCfgVehicles class doesn't exist",_className];
};

_vehicleInfo = [_className] call ALF_fnc_fetchVehInfo;

if ((count _dataArr) isEqualTo 4) then 
{
	_controlText ctrlSetStructuredText parseText format
	["
		Véhicule : %1<br/>
		Plaque : <t color='#8cff9b'>%2</t><br/>
		Heure(s) restante(s) : <t color='#8cff9b'>%3</t><br/>
		",
		_vehicleInfo # 3,
		_plaque,
		_dataArr # 4
	];
	_btnsortir ctrlShow false;
	_btnvendre ctrlShow false;
} else 
{
	_controlText ctrlSetStructuredText parseText format
	["
		Véhicule : %1<br/>
		Assurance : <t color='#8cff9b'>Assuré</t><br/>
		Siège passager : <t color='#8cff9b'>%2</t><br/>
		Réservoir : <t color='#8cff9b'>%3%4</t><br/>
		Plaque : <t color='#8cff9b'>%5</t><br/>
		Vitesse Max : <t color='#8cff9b'>%6 km/h</t><br/>
		Puissance : <t color='#8cff9b'>%7 rtpm</t><br/>
		Résistance : <t color='#8cff9b'>%8</t><br/>
		Volume du coffre : <t color='#8cff9b'>%9</t><br/>
		Endommagé : <t %10</t><br/>
		Présence : %11<br/>
		",
		_vehicleInfo # 3,
		_vehicleInfo # 10,
		floor (_fuel * 100),
		"%",
		_plaque,
		_vehicleInfo # 7,
		_vehicleInfo # 8,
		_vehicleInfo # 9,
		_vehicleInfo # 12,
		["color='#db3939'> Oui","color='#8cff9b'> Non"] select (_damage isEqualTo [] OR {({_x > 0.1} count _damage) isEqualTo 0}),
		if (_pos_veh distance player < 50) then 
		{
			"<t color='#8cff9b'>Dans ce garage</t>"
		} else 
		{
			"<t color='#FF0000'>A importer</t>"
		}
	];

	private _type_Veh    = "";
	private _type_Garage = "";

	if ("SP" in str cursorObject) then {
	    _type_Veh    = "SP";
	    _type_Garage = "SP Garage";
	} else {
	    if ("GN" in str cursorObject) then {
	        _type_Veh    = "GN";
	        _type_Garage = "GN Garage";
	    } else {
	        _type_Veh    = "PM";
	        _type_Garage = "AP Garage";
	    };
	};

	if (_pos_veh distance player < 50) then {
	    _btnsortir ctrlSetText "SORTIR";
	    _btnsortir buttonSetAction format [
	        "['%1','%2','%3','%4'] spawn MRPV2_fnc_Vehicule_Garage_Sortir;",
	        _className, _type_Veh, _type_Garage, _plaque
	    ];
	} else {
	    _btnsortir ctrlSetText "Importer";
	    _btnsortir buttonSetAction format [
	        "['%1','%2','%3'] spawn MRPV2_fnc_Vehicule_Garage_Importer;",
	        _type_Veh, _plaque, _className
	    ];
	    _btnvendre ctrlShow false;
	};
};

private _h = ctrlTextHeight _controlText;
private _position = ctrlPosition _controlText;
_controlText ctrlSetPosition [_position # 0,_position # 1,_position # 2,_h];
_controlText ctrlCommit 0;

ctrlShow [2803,true];
ctrlShow [2830,true];
// };