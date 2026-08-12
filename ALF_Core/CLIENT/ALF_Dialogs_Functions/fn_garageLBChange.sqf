// ALF_fnc_garageLBChange = {
// [toupper 'dans ALF_fnc_garageLBChange'] remoteExec ['systemchat',0];

_control = (_this select 0);
_index = (_this select 1);

private ["_plaque","_fuel","_control","_index","_className","_dataArr","_vehicleColor","_vehicleInfo","_sellPrice","_retrievePrice","_insure"];

private _display = findDisplay 2800;
private _controlsGroup = _display displayCtrl 2804;
private _controlText = _controlsGroup controlsGroupCtrl 2803;

private _btnassu = _display displayCtrl 97480;
private _btnassupro = _display displayCtrl 97481;
private _btntransfert = _display displayCtrl 97484;
private _btnsortir = _display displayCtrl 97482;
private _btnvendre = _display displayCtrl 97483;

_dataArr = _control lbData _index;
if (_dataArr isEqualTo "affichage") exitWith 
{
	_btnassu ctrlShow false;
	_btnassupro ctrlShow false;
	_btntransfert ctrlShow false;
	_btnsortir ctrlShow false;
	_btnvendre ctrlShow false;
	ctrlShow [2804,false];
	ctrlShow [2830,false];
};

_dataArr = parseSimpleArray _dataArr;

_btnassu ctrlShow true;
_btnassupro ctrlShow true;
_btnsortir ctrlShow true;
_btnvendre ctrlShow true;
ctrlShow [2804,true];

private _className = _dataArr # 0;
private _plaque = _dataArr # 3;
private _pos_veh = (parseSimpleArray (_dataArr # 4)) # 0;
private _fuel = _dataArr # 5;
private _insure = _dataArr # 6;
private _insurecount = _dataArr # 7;
private _en_Fourierre = _dataArr # 8;
private _tp_Fourierre = _dataArr # 9;
private _damage = _dataArr # 10;

_fuelFinal = format ["%1",floor(_fuel * 100)];

_returnClass = [["LifeCfgVehicles", _className]]call ALFTools_Client_Config_fnc_isClass;
if (!_returnClass) then 
{
	_className = "Default"; 
	diag_log format["%1: LifeCfgVehicles class doesn't exist",_className];
};

_vehicleInfo = [_className] call ALF_fnc_fetchVehInfo;

_retrievePrice = ["NUMBER", ["LifeCfgVehicles",_className,"sortie"]] call ALFTools_Client_Config_fnc_getConfig;
private _purchasePrice = ["NUMBER", ["LifeCfgVehicles",_className,"achat"]] call ALFTools_Client_Config_fnc_getConfig;
_sellPrice = ["NUMBER", ["LifeCfgVehicles",_className,"vente"]] call ALFTools_Client_Config_fnc_getConfig;

if (_purchasePrice > 50000) then 
{
	_retrievePrice = round(_purchasePrice * 0.0001);
};

if(_sellPrice < 1) then {_sellPrice = 50;};
if(_retrievePrice < 1) then {_retrievePrice = 5;};

if (life_axa isEqualTo 0) then 
{
	_btnassu ctrlShow false;
	_btnassupro ctrlShow false;
} else 
{
	if(life_axa isEqualTo 1 && {life_axacount >= 2}) then 
	{
		_btnassu ctrlShow false;
	} else 
	{
		if(life_axa isEqualTo 2 && {life_axacount >= 5}) then 
		{
			_btnassu ctrlShow false;
		} else 
		{
			if(life_axa isEqualTo 3 && {life_axacount >= 10}) then 
			{
				_btnassu ctrlShow false;
			} else 
			{
				if(life_axa isEqualTo 4 && {life_axacount >= 20}) then 
				{
					_btnassu ctrlShow false;
				} else 
				{
					_btnassu ctrlShow true;
				};
			};
		};
	};
};
if (_insure isEqualTo 1) then 
{
	_btnassu ctrlShow true;
	_btnassupro ctrlShow false;
	_btnassu ctrlSetStructuredText parseText "RESILIATION";
	_btnassu buttonSetAction "[0] spawn ALF_fnc_insureSystem;";
} else 
{
	if (_insure isEqualTo 2) then 
	{
		_btnassu ctrlShow false;
		_btnassupro ctrlSetStructuredText parseText "RESILIATION PRO";
		_btnassupro buttonSetAction "[2] spawn ALF_fnc_insureSystem;";
	} else 
	{
		_btnassu ctrlSetStructuredText parseText "ASSURER";
		_btnassu buttonSetAction "[1] spawn ALF_fnc_insureSystem;";
		_btnassupro ctrlSetStructuredText parseText "ASSURER PRO";
		_btnassupro buttonSetAction "[3] spawn ALF_fnc_insureSystem;";
		
		if (life_axaprocount >= 3) then {_btnassupro ctrlShow false;};		
		if (life_axaprocount <= 15 && {b_1}) then {_btnassupro ctrlShow true;};
		if (life_axaprocount <= 8 && {life_copLevel >= 1 || life_medicLevel >= 1 || life_penit >= 1}) then {_btnassupro ctrlShow true;};
	};	
};

if (life_penit <= 0 && {!b_1}) then {_btnassupro ctrlShow false;};

if ((player getVariable ["isEmployed",""]) isNotEqualTo "") then 
{
	_btntransfert ctrlShow true;
	_btntransfert buttonSetAction "[] spawn ALF_fnc_businessTransfertVeh;";
};

private _textassurance = switch (_insure) do 
{
	case 0: {"<t color='#FF0000'>Pas d'assurance</t>"};
	case 1: {"<t color='#8cff9b'>Assurance particulier</t>"};
	case 2: {"<t color='#8cff9b'>Assurance professionnel</t>"};
};

if (_en_Fourierre isequalto 1) then 
{
	_controlText ctrlSetStructuredText parseText format
	["
		Véhicule : %1<br/>
		Plaque : <t color='#8cff9b'>%2</t><br/>
		Heure(s) restante(s) : <t color='#8cff9b'>%3</t><br/>
		",
		_vehicleInfo # 3,
		_plaque,
		_tp_Fourierre
	];

	_btnassu ctrlShow false;
	_btnassupro ctrlShow false;
	_btnsortir ctrlShow false;
	_btnvendre ctrlShow false;
} else 
{
	_controlText ctrlSetStructuredText parseText format
	["
		Véhicule : %1<br/>
		Prix de sortie : <t color='#8cff9b'>%2€</t><br/>
		Prix de vente : <t color='#8cff9b'>%3€</t><br/>
		Assurance : %12<br/>
		Sinistre : %13<br/><br/>
		Siège passager : <t color='#8cff9b'>%9</t><br/>
		Réservoir : <t color='#8cff9b'>%4%5</t><br/>
		Plaque : <t color='#8cff9b'>%6</t><br/>
		Vitesse Max : <t color='#8cff9b'>%7 km/h</t><br/>
		Puissance : <t color='#8cff9b'>%10 rtpm</t><br/>
		Résistance : <t color='#8cff9b'>%8</t><br/>
		Volume du coffre : <t color='#8cff9b'>%11</t><br/>
		Endommagé : <t %14</t><br/>
		Présence : %15<br/>
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
		_textassurance,
		_insurecount,
		["color='#db3939'> Oui","color='#8cff9b'> Non"] select (_damage isEqualTo [] || {({_x > 0.1} count _damage) isEqualTo 0}),
		if (_pos_veh distance player < 50) then 
		{
			"<t color='#8cff9b'>Dans ce garage</t>"
		} else 
		{
			"<t color='#FF0000'>A importer</t>"
		}
	]; 

	if (_pos_veh distance player < 60) then 
	{
		_btnsortir ctrlSetText "SORTIR";
		_btnsortir buttonSetAction format ["['%1','Civil','Civil Garage','%2'] spawn MRPV2_fnc_Vehicule_Garage_Sortir;",_className,_plaque];
	} else 
	{
		_btnsortir ctrlSetText "Importer";
		_btnsortir buttonSetAction format ["['Civil','%1','%2'] spawn MRPV2_fnc_Vehicule_Garage_Importer;",_plaque,_className];
		_btnassu ctrlShow false;
		_btnassupro ctrlShow false;
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