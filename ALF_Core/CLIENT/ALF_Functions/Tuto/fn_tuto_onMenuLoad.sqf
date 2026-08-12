/*
    Fichier : fn_tuto_onMenuLoad.sqf
*/
[] call ALF_fnc_tuto_ensureConfig;

waitUntil { !isNull (findDisplay 9903) };
uiSleep 0.01;

private _dlg = findDisplay 9903;
uiNamespace setVariable ["ALF_Tuto_Display", _dlg];

private _fontBase = (((safezoneW / safezoneH) min 1.2) / 1.2) / 25;
private _fontTab = _fontBase * 1.1;
private _fontBody = _fontBase * 1.05;

private _ctrlLogo = _dlg displayCtrl 9925;
if (!isNull _ctrlLogo) then {
    private _texLogo = ["textures\tuto\LogoMRP.paa"] call ALF_fnc_tuto_resolveTexture;
    _ctrlLogo ctrlSetText _texLogo;
};

private _ctrlCombo = _dlg displayCtrl 9928;
if (!isNull _ctrlCombo) then {
    _ctrlCombo ctrlSetFont "PuristaMedium";
    _ctrlCombo ctrlSetFontHeight _fontTab;
    _ctrlCombo ctrlSetTextColor [1, 1, 1, 1];

    lbClear _ctrlCombo;
    private _config = [] call ALF_fnc_tuto_ensureConfig;
    {
        _x params ["_id", "_titre", "_contenu"];
        private _idx = _ctrlCombo lbAdd _titre;
        _ctrlCombo lbSetData [_idx, _id];
    } forEach _config;

    _ctrlCombo ctrlAddEventHandler ["LBSelChanged", {
        params ["_ctrl", "_idx"];
        if (_idx < 0) exitWith {};
        private _tabId = _ctrl lbData _idx;
        if (_tabId isEqualTo "") exitWith {};
        _ctrl ctrlSetTextColor [1, 1, 1, 1];
        [_tabId, false] call ALF_fnc_tuto_selectTab;
    }];
};

private _ctrlFermer = _dlg displayCtrl 9939;
if (!isNull _ctrlFermer) then {
    _ctrlFermer ctrlSetFont "PuristaMedium";
    _ctrlFermer ctrlSetFontHeight (_fontTab * 1.08);
};

private _ctrlGroup = _dlg displayCtrl 9930;
private _ctrlContent = controlNull;
if (!isNull _ctrlGroup) then {
    _ctrlContent = _ctrlGroup controlsGroupCtrl 9940;
};
if (!isNull _ctrlContent) then {
    _ctrlContent ctrlSetFont "PuristaMedium";
    _ctrlContent ctrlSetFontHeight _fontBody;
};

["ile", true] call ALF_fnc_tuto_selectTab;
