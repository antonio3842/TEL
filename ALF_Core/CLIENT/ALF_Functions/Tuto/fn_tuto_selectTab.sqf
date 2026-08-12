/*
    Fichier : fn_tuto_selectTab.sqf
    Param : id section (ile | metiers | entreprises | ...)
*/
params [["_tabId", "ile", [""]], ["_syncCombo", true, [true]]];

private _dlg = uiNamespace getVariable ["ALF_Tuto_Display", displayNull];
if (isNull _dlg) then {
    _dlg = findDisplay 9903;
};
if (isNull _dlg) exitWith {};

private _ctrlGroup = _dlg displayCtrl 9930;
private _ctrlContent = controlNull;
if (!isNull _ctrlGroup) then {
    _ctrlContent = _ctrlGroup controlsGroupCtrl 9940;
};
private _ctrlImage = _dlg displayCtrl 9941;
private _ctrlCombo = _dlg displayCtrl 9928;

private _isImageTab = _tabId isEqualTo "touches";

if (!isNull _ctrlGroup) then {
    _ctrlGroup ctrlShow !_isImageTab;
};

if (!isNull _ctrlImage) then {
    _ctrlImage ctrlShow _isImageTab;
    if (_isImageTab) then {
        private _tex = ["textures\tuto\touche.paa"] call ALF_fnc_tuto_resolveTexture;
        _ctrlImage ctrlSetText _tex;
    };
};

if (!_isImageTab) then {
    private _config = [] call ALF_fnc_tuto_ensureConfig;
    private _entry = _config select {(_x select 0) isEqualTo _tabId};
    if (_entry isNotEqualTo [] && {!isNull _ctrlContent}) then {
        private _contenu = (_entry select 0) select 2;
        _ctrlContent ctrlSetStructuredText parseText _contenu;
        _ctrlContent ctrlSetPosition [0, 0, 0.98, 5.5];
        _ctrlContent ctrlCommit 0;
    };
};

if (!_isImageTab && {!isNull _ctrlGroup}) then {
    _ctrlGroup ctrlShow false;
    _ctrlGroup ctrlShow true;
};

if (_syncCombo && {!isNull _ctrlCombo}) then {
    private _count = lbSize _ctrlCombo;
    for "_i" from 0 to (_count - 1) do {
        if ((_ctrlCombo lbData _i) isEqualTo _tabId) exitWith {
            _ctrlCombo lbSetCurSel _i;
        };
    };
    _ctrlCombo ctrlSetTextColor [1, 1, 1, 1];
};

uiNamespace setVariable ["ALF_Tuto_ActiveTab", _tabId];
