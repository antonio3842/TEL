/* Copyright 2023 - Association Get Your Path. All rights reserved */
private ["_display","_array","_from_name","_to_name","_curConfig","_text","_copy","_expiration","_fromstr","_formatedDate","_textstr"];

_array = player getVariable ["advanced_documents_temporary",[]];
if ((count _array) isEqualTo 0) exitWith {};

disableSerialization;
createDialog "Advanced_Documents_Documents";
_display = findDisplay 6510;

_from_name = _array select 3;
_to_name = _array select 4;
_curConfig = _array select 5;
_text = _array select 6;
_copy = _array select 8;
_expiration = _array select 9;

_fromstr = _from_name splitString " ";
_tostr = _to_name splitString " ";

_dateYear = (_expiration select [1,4]);

if ((parseNumber _dateYear) >= 2035) then {
    _formatedDate = "Jamais";
} else {
    _formatedDate = ((_expiration select [9,2]) + "/" + (_expiration select [6,2]) + "/" + _dateYear);
};

_textstr = _text splitString """";

private _config = ["CLASS",["The_Programmer_Advanced_Documents", "types_documents", _curConfig]] call ALFTools_Client_Config_fnc_getConfig;

_returnClass = [["The_Programmer_Advanced_Documents", "types_documents", _curConfig]] call ALFTools_Client_Config_fnc_isClass;
if !(_returnClass) exitWith {};

private _displayName = ["STRING",["displayName"], _config] call ALFTools_Client_Config_fnc_getConfig;
private _displayType = ["STRING",["type"], _config] call ALFTools_Client_Config_fnc_getConfig;
private _texture = ["STRING",["texture"], _config] call ALFTools_Client_Config_fnc_getConfig;
private _logo = ["STRING",["logo"], _config] call ALFTools_Client_Config_fnc_getConfig;
private _signature = ["STRING",["signature"], _config] call ALFTools_Client_Config_fnc_getConfig;

private _texturePath = ["STRING",["The_Programmer_Advanced_Documents", "textures_base_path"]] call ALFTools_Client_Config_fnc_getConfig;
(_display displayCtrl 6511) ctrlSetText (format ["%1\%2",_texturePath,_texture]);
(_display displayCtrl 6512) ctrlSetText (format ["%1\%2",_texturePath,_logo]);
(_display displayCtrl 6532) ctrlSetText (format ["%1\%2",_texturePath,_signature]);

(_display displayCtrl 6513) ctrlSetStructuredText parseText format ["<t align='center' color='#000000' size='2.5'>%1</t>",([_displayName] call theprogrammer_core_fnc_escapeXML)];
(_display displayCtrl 6514) ctrlSetStructuredText parseText format ["<t align='center' color='#797979'>%1</t>",([_displayType] call theprogrammer_core_fnc_escapeXML)];

if (_copy isEqualTo 0) then {
    (_display displayCtrl 6538) ctrlShow false;
} else {
    _texturePath = ["STRING",["The_Programmer_Advanced_Documents", "textures_base_path"]] call ALFTools_Client_Config_fnc_getConfig;
    (_display displayCtrl 6538) ctrlSetText (format ["%1\copy.paa",_texturePath]);
};

(_display displayCtrl 6515) ctrlSetStructuredText parseText (["STR_INFORMATION","The_Programmer_Advanced_Documents","Advanced_Documents_Localization"] call theprogrammer_core_fnc_localize);

(_display displayCtrl 6516) ctrlSetStructuredText parseText format ["<t align='center'>%1 </t><t color='#797979' align='center'>%2</t>",(["STR_LASTNAME","The_Programmer_Advanced_Documents","Advanced_Documents_Localization"] call theprogrammer_core_fnc_localize),(_fromstr select 1)];
(_display displayCtrl 6518) ctrlSetStructuredText parseText format ["<t align='center'>%1 </t><t color='#797979' align='center'>%2</t>",(["STR_FIRSTNAME","The_Programmer_Advanced_Documents","Advanced_Documents_Localization"] call theprogrammer_core_fnc_localize),(_fromstr select 0)];

(_display displayCtrl 6520) ctrlSetStructuredText parseText (["STR_AUTHORIZED","The_Programmer_Advanced_Documents","Advanced_Documents_Localization"] call theprogrammer_core_fnc_localize);
(_display displayCtrl 6521) ctrlSetStructuredText parseText format ["<t align='center' color='#000000'>%1</t>",(_tostr select 1)];
(_display displayCtrl 6522) ctrlSetStructuredText parseText (["STR_LASTNAME","The_Programmer_Advanced_Documents","Advanced_Documents_Localization"] call theprogrammer_core_fnc_localize);
(_display displayCtrl 6523) ctrlSetStructuredText parseText format ["<t align='center' color='#000000'>%1</t>",(_tostr select 0)];
(_display displayCtrl 6524) ctrlSetStructuredText parseText (["STR_FIRSTNAME","The_Programmer_Advanced_Documents","Advanced_Documents_Localization"] call theprogrammer_core_fnc_localize);

_isValid = (["STR_VALID","The_Programmer_Advanced_Documents","Advanced_Documents_Localization"] call theprogrammer_core_fnc_localize);
if ((_array select 11) == 1) then {_isValid = (["STR_NOT_VALID","The_Programmer_Advanced_Documents","Advanced_Documents_Localization"] call theprogrammer_core_fnc_localize);};

(_display displayCtrl 6525) ctrlSetStructuredText parseText format ["<t align='center' color='#000000'>%1</t> %2",_formatedDate,_isValid];
(_display displayCtrl 6526) ctrlSetStructuredText parseText (["STR_EXPIRATION","The_Programmer_Advanced_Documents","Advanced_Documents_Localization"] call theprogrammer_core_fnc_localize);

(_display displayCtrl 6527) ctrlSetStructuredText parseText format ["<t align='center' color='#000000'>%1</t>",([(_textstr select 0)] call theprogrammer_core_fnc_escapeXML)];
(_display displayCtrl 6528) ctrlSetStructuredText parseText (["STR_INFOS","The_Programmer_Advanced_Documents","Advanced_Documents_Localization"] call theprogrammer_core_fnc_localize);
(_display displayCtrl 6529) ctrlSetStructuredText parseText (["STR_TERMSSIGNING","The_Programmer_Advanced_Documents","Advanced_Documents_Localization"] call theprogrammer_core_fnc_localize);
(_display displayCtrl 6530) ctrlSetStructuredText parseText (["STR_TERMS","The_Programmer_Advanced_Documents","Advanced_Documents_Localization"] call theprogrammer_core_fnc_localize);

(_display displayCtrl 6531) ctrlSetStructuredText parseText format ["<t align='center' color='#000000' size='2.5'>%1</t>",_from_name];

_control = _display displayCtrl 6527;
_myControlPos = ctrlPosition _control;

_control ctrlSetPosition [(_myControlPos select 0),(_myControlPos select 1),(_myControlPos select 2),(ctrlTextHeight _control)];
_control ctrlCommit 0;

if ((count _array) > 0) then {player setVariable ["advanced_documents_temporary",[],true];};

{
    (_display displayCtrl _x) ctrlShow false;
} forEach [1000,1001,1002];
