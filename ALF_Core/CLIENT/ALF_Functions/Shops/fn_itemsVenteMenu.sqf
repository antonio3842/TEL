
private _shopTitle = ["STRING", ["ItemsVente", ((_this # 3)), "name"]] call ALFTools_Client_Config_fnc_getConfig;
uiNamespace setVariable ["Items_Vente",(_this # 3)];

if(!(createDialog "life_itemsvente")) exitWith {};

private _returnClass = [["ItemsVente", ((_this # 3))]] call ALFTools_Client_Config_fnc_isClass;
if(!_returnClass) exitWith {}; 

disableSerialization;
ctrlSetText[39401,_shopTitle];

[] call ALF_fnc_itemsVenteLoad;