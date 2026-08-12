/* Copyright 2023 - Association Get Your Path. All rights reserved */
disableSerialization;

private _list = _this select 0;
private _index = _this select 1;

private _display = findDisplay 5540;
private _curConfig = _list lbData _index;

_durationCtrl = _display displayCtrl 5544;

_config = ["CLASS", ["Documents", "types_documents", _curConfig]] call ALFTools_Client_Config_fnc_getConfig;
_forcedDuration = ["NUMBER", ["force_duration"],_config] call ALFTools_Client_Config_fnc_getConfig;

if (_forcedDuration <= 0) then {
    _durationCtrl ctrlEnable true;
    _durationCtrl ctrlSetText "";

    _minimumDuration = ["NUMBER", ["min_duration"],_config] call ALFTools_Client_Config_fnc_getConfig;
    _maximumDuration = ["NUMBER", ["max_duration"],_config] call ALFTools_Client_Config_fnc_getConfig;

    if ((_minimumDuration <= 0) && (_maximumDuration <= 0)) then {
        (_display displayCtrl 5548) ctrlSetStructuredText parseText "<t color='#FFBD0E'>Validité (en jours) :</t>";
    } else {
        if (_maximumDuration <= 0) then {
            (_display displayCtrl 5548) ctrlSetStructuredText parseText format ["<t color='#FFBD0E'>Validité (au minimum %1 jours) :</t>",_minimumDuration];
        } else {
            (_display displayCtrl 5548) ctrlSetStructuredText parseText format ["<t color='#FFBD0E'>Validité (entre %1 et %2 jours) :</t>",_minimumDuration,_maximumDuration];
        };
    };
} else {
    _durationCtrl ctrlEnable false;
    _durationCtrl ctrlSetText (str _forcedDuration);
    (_display displayCtrl 5548) ctrlSetStructuredText parseText "<t color='#FFBD0E'>Validité (en jours) :</t>";
};
