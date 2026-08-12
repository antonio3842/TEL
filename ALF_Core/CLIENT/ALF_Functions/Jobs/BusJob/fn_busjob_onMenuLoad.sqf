/*
    Fichier : fn_busjob_onMenuLoad.sqf
    Desc    : Remplit les boutons de lignes (après création complète du dialog)
*/

[] call ALF_fnc_busjob_ensureConfig;

waitUntil { !isNull (findDisplay 9901) };
uiSleep 0.01;

private _dlg = findDisplay 9901;
uiNamespace setVariable ["ALF_BusJob_Display", _dlg];

if (isNil "MRP_BusJob_EnService") then { MRP_BusJob_EnService = false; };

private _idcs = [9911, 9912, 9913, 9914, 9915, 9916];

{
    private _ligne   = _x;
    private _id      = _ligne select 0;
    private _nom     = _ligne select 1;
    private _salaire = _ligne select 2;
    private _coords  = [_id] call ALF_fnc_busjob_getArretsCoords;
    private _nb      = count _coords;

    private _ctrl = _dlg displayCtrl (_idcs select _forEachIndex);
    if (isNull _ctrl) then {
        diag_log format ["[MRP_BUSJOB] onMenuLoad: ctrl idc %1 introuvable", _idcs select _forEachIndex];
    } else {
        _ctrl ctrlSetFont "PuristaMedium";
        _ctrl ctrlSetFontHeight 0.032;

        if (_nb isEqualTo 0) then {
            _ctrl ctrlSetText format ["[EN CONSTRUCTION] %1", _nom];
            _ctrl ctrlSetTextColor [0.55, 0.58, 0.65, 1.0];
        } else {
            _ctrl ctrlSetText format [
                "%1  |  %2 arrets  |  %3 EUR/arret",
                _nom, _nb, _salaire
            ];
            _ctrl ctrlSetTextColor [0.92, 0.94, 1.0, 1.0];
        };

        if (MRP_BusJob_EnService && { MRP_BusJob_LigneActive isEqualTo _id }) then {
            _ctrl ctrlSetTextColor [0.20, 0.90, 0.45, 1.0];
            _ctrl ctrlSetBackgroundColor [0.04, 0.16, 0.08, 0.95];
        };
    };
} forEach MRP_BusJob_Config;

private _ctrlStats = _dlg displayCtrl 9950;
if (!isNull _ctrlStats) then {
    _ctrlStats ctrlSetFont "PuristaMedium";
    _ctrlStats ctrlSetFontHeight 0.032;
    if (MRP_BusJob_EnService) then {
        _ctrlStats ctrlSetText format [
            "EN SERVICE  |  Arret %1/%2  |  Gagne %3 EUR",
            MRP_BusJob_ArretActuel, MRP_BusJob_ArretTotal, MRP_BusJob_SalaireTotal
        ];
    } else {
        _ctrlStats ctrlSetText "";
    };
};

private _ctrlStop = _dlg displayCtrl 9920;
if (!isNull _ctrlStop) then {
    _ctrlStop ctrlSetFont "PuristaMedium";
    _ctrlStop ctrlSetFontHeight 0.032;
    _ctrlStop ctrlEnable MRP_BusJob_EnService;
    if (!MRP_BusJob_EnService) then {
        _ctrlStop ctrlSetTextColor [0.45, 0.45, 0.45, 1.0];
    };
};
