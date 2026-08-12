#include "\ALF_Client\script_macros.hpp"

private["_shopTitle"];
_shopTitle = ["STRING", ["ItemsVente", (SEL(_this,3)), "name"]] call ALFTools_Client_Config_fnc_getConfig;
uiNamespace setVariable ["Items_Vente",SEL(_this,3)];
if(!(createDialog "life_itemsventedealer")) exitWith {};
_returnClass = [["ItemsVente", (SEL(_this,3))]] call ALFTools_Client_Config_fnc_isClass;
if(!_returnClass) exitWith {}; //Bad config entry.
disableSerialization;
ctrlSetText[39401,_shopTitle];

[] call ALF_fnc_itemsVenteLoad;
