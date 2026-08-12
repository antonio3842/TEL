private["_idc","_y","_w","_longest_word","_max_length","_length"];
params [
	["_data",[],[[]]],
	["_player",objNull,[objNull]]
];
disableSerialization;

_idc = ctrlIDC (_data select 0);
_selectedIndex = _data select 1;
private _item = format ["%1",lbData [_idc, _selectedIndex]];
private _itemName = format ["%1", lbText [_idc, _selectedIndex]];

if (_item isEqualTo "") exitWith {};

if (_item in ALF_Mobiliers_Items) exitWith {
	closeDialog 602;
 	if (_item isEqualTo "ALF_Coco_boite") then {
 		[_item] spawn ALF_fnc_placeDrugSystem;
 	} else {
 		[_item] spawn ALF_fnc_mobilierSystem;
 	};
};

ALF_item_current_selected = _item;

_pos = getMousePosition;

// Get previous control and delete it
_active_control = uiNamespace getVariable ["ALF_inventory_subControl", controlNull];
if !(isNull _active_control) then {
	_active_control ctrlShow false;
	ctrlDelete _active_control;
};

// Create ControlsGroup
_display = (findDisplay 46) createDisplay "RscDisplayEmpty";
//_display closeDisplay 1;
private _control = _display ctrlCreate ["Life_RscControlsGroupNoScrollbars",50000];

//Get the longest word for the width
_length = 1;
_longest_word = "Donner";
_max_length = count _longest_word;
{
	_params = ["ALF_CfgInventory", _item, _x, "displayName"];
	_display_name = (["STRING", _params] call ALFTools_Client_Config_fnc_getConfig);

	if (_max_length < (count _display_name)) then {
		_max_length = count _display_name;
		_longest_word = _display_name;
	};
	_length = _length + 1;
} forEach (["CLASSES", ["ALF_CfgInventory",_item]] call ALFTools_Client_Config_fnc_getConfig);

_width = _longest_word getTextWidth ["PuristaLight", 0.06];

_control ctrlSetPosition [_pos select 0,_pos select 1,_width,_length * 0.2];
_control ctrlCommit 0;

uiNamespace setVariable["ALF_inventory_subControl",_control];
uiNamespace setVariable["ALF_inventory_display",_display];


_actions = [];

_idc = 60000;
_y1 = 0;
_w = 0.05;
{
	_display_name = (["STRING", ["ALF_CfgInventory",_item,_x,"displayName"]] call ALFTools_Client_Config_fnc_getConfig);
	_statement = (["STRING", ["ALF_CfgInventory",_item,_x,"statement"]] call ALFTools_Client_Config_fnc_getConfig);
	_condition = (["STRING", ["ALF_CfgInventory",_item,_x,"condition"]] call ALFTools_Client_Config_fnc_getConfig);

	if (call compile _condition) then {
		_button = _display ctrlCreate ["Life_RscButtonMenu",_idc,_control];
		_idc = _idc + 1;
		_button ctrlSetFade 1;
		_button ctrlCommit 0;

		_name_grp = _display ctrlCreate ["Life_RscStructuredText",_idc,_control];
		_idc = _idc + 1;
		_name_grp ctrlSetFade 1;
		_name_grp ctrlCommit 0;

		_name_grp ctrlEnable false;
		_name_grp ctrlSetStructuredText parseText format["<t font='PuristaLight'>%1</t>",_display_name];
		_name_grp ctrlSetTextColor [1, 1, 1, 1];

		_cur_pos = [0,_y1,_width,_w];

		_name_grp ctrlSetPosition _cur_pos;
		_button ctrlSetPosition _cur_pos;

		_statement = "(uiNamespace getVariable['ALF_inventory_subControl',controlNull]) ctrlShow false; (uiNamespace getVariable['ALF_inventory_display',displayNull]) closeDisplay 1;" + _statement;
		_button ctrlAddEventHandler ["ButtonClick",_statement];

		_actions pushBack [_statement,_button];

		_name_grp ctrlSetFade 0;
		_button ctrlSetFade 0;

		_button ctrlCommit 0.2;
		_name_grp ctrlCommit 0.2;

		_y1 = _y1 + _w;
	};
} forEach (["CLASSES", ["ALF_CfgInventory",_item]] call ALFTools_Client_Config_fnc_getConfig);

if (count _actions == 0) exitWith {
	["Info", "Cet objet n'est pas utilisable.", "warning", false] spawn ALF_fnc_doMsg;
};




uiNamespace setVariable ["ALF_inventory_actions",_actions];

_display displaySetEventHandler ["MouseButtonDown", "
	_display = uiNamespace getVariable['ALF_inventory_display',displayNull];
	_ctrl = uiNamespace getVariable['ALF_inventory_subControl',controlNull];
	_actions = uiNamespace getVariable['ALF_inventory_actions',[]];
	if (_actions isEqualTo []) exitWith {};
	_coord_x = _this select 2;
	_coord_y = _this select 3;
	_ctrl_pos = ctrlPosition _ctrl;
	private _exit = false;
	{
		_statement = _x select 0;
		_coords = ctrlPosition (_x select 1);
		_coords set [0,(_coords select 0) + (_ctrl_pos select 0)];
		_coords set [1,(_coords select 1) + (_ctrl_pos select 1)];

		if ((_coords select 0) <= _coord_x && ((_coords select 0) + (_coords select 2)) >= _coord_x
		    && (_coords select 1) <= _coord_y && ((_coords select 1) + (_coords select 3) >= _coord_y)) exitWith {
			call compile _statement;
			_exit = true;
		};
	} forEach _actions;

	if (_exit) exitWith {};

	_display closeDisplay 0;
"];