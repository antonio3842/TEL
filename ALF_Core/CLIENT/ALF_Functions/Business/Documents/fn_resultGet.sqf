/* Copyright 2023 - Association Get Your Path. All rights reserved */
_result = param [0,[],[]];
disableSerialization;

private _display = findDisplay 4510;

{
    (_display displayCtrl _x) ctrlShow false;
} forEach [1000,1001,4520,4521,4523,4525];

private _docList = _display displayCtrl 4515;

lbClear _docList;
_docList lbSetCurSel -1;

if ((count _result) isEqualTo 0) exitWith {
    _docList lbSetCurSel -1;
    _docList lbAdd "Aucun document n'a été trouvé";

    _docList lbSetData [(lbSize _docList)-1,"NULL"];
    _docList lbSetColor [0,[1,0,0,1]];
};

{
    _returnClass = [["Documents", "types_documents", (_x select 5)]] call ALFTools_Client_Config_fnc_isClass;
    if (_returnClass) then {
        private _displayName = ["STRING",["Documents", "types_documents", (_x select 5), "displayName"]] call ALFTools_Client_Config_fnc_getConfig;

        _docList lbAdd format ["#%1 - %2",(_x select 0),_displayName];
        _docList lbSetData [(lbSize _docList)-1,(str _x)]; 
    };
} forEach _result;
