private _item = _this select 0;
private _mode =  _this select 1;

if (_item isEqualTo "") exitWith {};

if !(_mode) then {
	private _config = ["CLASS", ["ALF_VACCINS", _item]] call ALFTools_Client_Config_fnc_getConfig;
	_returnClass = [["ALF_VACCINS", _item]] call ALFTools_Client_Config_fnc_isClass;
	if (!_returnClass) exitWith {};

	player removeMagazine _item;

	private _amount = ["NUMBER", ["time"], _config] call ALFTools_Client_Config_fnc_getConfig;
	private _protectC = ["CLASSES", ["protect"], _config] call ALFTools_Client_Config_fnc_getConfig;
	{
		private _desease = _x;
		private _index = -1;
		{
			if (_desease in _x) exitWith {_index = _forEachIndex};
		} forEach alf_vaccins;
		
		if (_index isEqualTo -1) then {
			alf_vaccins pushBack [_desease,_amount];
			
			{
				if (_desease in _x) exitWith {_index = _forEachIndex};
			} forEach alf_deseases;
			
			if (_index != -1) then {
				alf_deseases deleteAt _index;
			};
		};
	} forEach _protectC;
} else {
	private _config = ["CLASS", ["ALF_MEDECINE", _item]] call ALFTools_Client_Config_fnc_getConfig;
	_returnClass = [["ALF_MEDECINE", _item]] call ALFTools_Client_Config_fnc_isClass;
	if (!_returnClass) exitWith {};

	player removeMagazine _item;

	private _index = -1;
	{
		if (_item in _x) exitWith {_index = _forEachIndex};
	} forEach alf_medecine;
	
	if (_index isEqualTo -1) then {
		{
			{
				if (_item in _x) exitWith {_index = _forEachIndex};
			} forEach (_x select 1);
			
			if (_index != -1) then {
				_amount = (((_x select 1) select _index) select 1) - 1;
				if (_amount < 1) then {
					((alf_deseases select _forEachIndex) select 1) deleteAt _index;
				} else {
					(((alf_deseases select _forEachIndex) select 1) select _index) set [1,_amount];
				};
			};
		} forEach alf_deseases;

		private _interValC = ["NUMBER", ["interval"], _config] call ALFTools_Client_Config_fnc_getConfig;
		alf_medecine pushBack [_item,_interValC];
	} else {
		["INFO", "Vous n'avez pas respecté les prescriptions du médecin. Des effets indésirables peuvent survenir.", "warning"] call ALF_fnc_doMsg;
		[0.02] call ALF_fnc_handleDrug;
	};
};