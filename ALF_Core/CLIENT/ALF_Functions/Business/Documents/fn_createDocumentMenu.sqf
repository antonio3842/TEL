/* Copyright 2023 - Association Get Your Path. All rights reserved */
private ["_display","_texturePath","_playersList","_typeList","_side","_license"];

disableSerialization;
_display = findDisplay 5540;

_texturePath = ["STRING", ["Documents", "textures_base_path"]] call ALFTools_Client_Config_fnc_getConfig;
(_display displayCtrl 5541) ctrlSetText (format ["%1\new_document.paa",_texturePath]);

_playersList = _display displayCtrl 5543;
lbClear _playersList;

private _allow = ["NUMBER", ["Documents", "allow_to_create_self_document"]] call ALFTools_Client_Config_fnc_getConfig;
if (_allow isEqualTo 1) then {
    _playersList lbAdd format ["%1",player getVariable ["realname",(name player)]];
    _playersList lbSetData [(lbSize _playersList)-1,(str player)];
};

{
    if (!(isNull _x) && (alive _x) && ((_x distance player) < 20) && !(_x isEqualTo player)) then {
        _playersList lbAdd format ["%1",_x getVariable ["realname",name _x]];
        _playersList lbSetData [(lbSize _playersList)-1,(str _x)];
    };
} forEach playableUnits;

_typeList = _display displayCtrl 5547;
lbClear _typeList;

_oneDocOrMore = false;
private _typeDocuments = ["CLASSES", ["Documents", "types_documents"]] call ALFTools_Client_Config_fnc_getConfig;
{
    _condition = ["STRING", ["condition"],_y] call ALFTools_Client_Config_fnc_getConfig;

    if (_condition) then {
        private _displayName = ["STRING", ["displayName"],_y] call ALFTools_Client_Config_fnc_getConfig;
        _oneDocOrMore = true;
        _typeList lbAdd format ["%1",_displayName];
        _typeList lbSetData [(lbSize _typeList)-1,_x];
    };
} forEach _typeDocuments;

if !(_oneDocOrMore) exitWith {["Erreur","Vous ne pouvez pas créer de documents !","warning"] spawn ALF_fnc_doMsg; closeDialog 0;};

(_display displayCtrl 5545) ctrlSetStructuredText parseText "<t font='PuristaBold' align='center' size='2.5' color='#ffffff'>Créer un document</t>";
(_display displayCtrl 5546) ctrlSetStructuredText parseText "<t color='#FFBD0E'>Document :</t>";
(_display displayCtrl 5551) ctrlSetStructuredText parseText "<t color='#FFBD0E'>Destinataire :</t>";
(_display displayCtrl 5548) ctrlSetStructuredText parseText "<t color='#FFBD0E'>Validité (en jours) :</t>";
(_display displayCtrl 5549) ctrlSetStructuredText parseText "<t color='#FFBD0E'>Informations supplémentaires (optionnel) :</t>";
(_display displayCtrl 5550) ctrlSetStructuredText parseText "<t font='PuristaBold' align='center' size='1.2' color='#ffffff'>Envoyer</t>";

(_display displayCtrl 5549) ctrlAddEventHandler ["KeyDown","
    if ((_this select 1) isEqualTo 28) then {
        ((findDisplay 5540) displayCtrl 5549) ctrlSetText format [""%1%2%3"",(ctrlText 5549),endl,""""];
    };
"];
