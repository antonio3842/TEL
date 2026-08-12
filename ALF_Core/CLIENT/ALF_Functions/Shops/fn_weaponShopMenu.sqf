// ALF_fnc_weaponShopMenu = {
private _exit = false;
private _shopTitle = ["STRING", ["WeaponShops", (_this select 3), "name"]] call ALFTools_Client_Config_fnc_getConfig;
private _license = ["STRING", ["WeaponShops", (_this select 3), "license"]] call ALFTools_Client_Config_fnc_getConfig;

if (_shopTitle isEqualto "Pharmacie" AND {((alf_ordonnance select 0) isEqualto 0) OR ((alf_ordonnance select 1) isEqualto 0)}) exitwith 
{
    ["Pharmacien", "Il vous faut une ordonnance. Veuillez consulter un médecin", "danger"] spawn ALF_fnc_doMsg;
    _exit = true;
};

if (_license isNotEqualto "") then 
{
    private _varnameConfig = ["STRING", ["Licenses", _license, "variable"]] call ALFTools_Client_Config_fnc_getConfig;
    private _licenseValueConfig = missionNamespace getVariable [format["license_%1",_varnameConfig], false];

    if !(_licenseValueConfig) exitwith 
    {
        ["Info", "VOus n'avez pas la licence pour accéder à ce magasin.", "danger"] spawn ALF_fnc_doMsg;
        _exit = true;
    };
};
if (_exit) exitwith {};

uiNamespace setVariable ["Weapon_Shop", (_this select 3)];

if (!(createdialog "life_weapon_shop")) exitwith {};
_returnClass = [["WeaponShops", (_this select 3)]] call ALFTools_Client_Config_fnc_isClass;
if (!_returnClass) exitwith {};

disableSerialization;

ctrlsettext[38401, _shopTitle];

private _filters = ((findDisplay 38400) displayCtrl 38402);
lbClear _filters;

_filters lbAdd localize "str_Shop_Weapon_Shopinv";
_filters lbAdd localize "str_Shop_Weapon_Yourinv";

_filters lbsetCurSel 0;
// };