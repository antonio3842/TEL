disableSerialization;

_color = lbData[2304, (lbCurSel 2304)];

if (isNull life_preview_3D_vehicle_object) exitWith {};

private _className = typeOf life_preview_3D_vehicle_object;

if (isNull life_preview_3D_vehicle_object || {!alive life_preview_3D_vehicle_object} || {_color isEqualTo ""}) exitWith {};

_returnClass = [["LifeCfgVehicles", _className]] call ALFTools_Client_Config_fnc_isClass;
if (!_returnClass) then {
    diag_log format ["%1: LifeCfgVehicles class doesn't exist",_className];
    _className = "Default";
};

life_preview_3D_vehicle_object setObjectTextureGlobal [0, _color];