#include "\ALF_Client\script_macros.hpp"
/*
File:
Author: ALF Team
Description:

0 = Bourse légal
1 = Bourse illégal

*/

params [
	["_param",0] 
];



if (isNil "ALFBOURSE_Prices") then {[getPlayerUID player] remoteExecCall ["ALF_Server_fnc_loggedBourse",2]; ["NASDAC", "Mise à jour de le bourse.", "warning", false] spawn ALF_fnc_doMsg; sleep 1;};

disableSerialization;
_dialog = findDisplay 24500;
_listbox = _dialog displayCtrl 24525;

if (_param == 1) then {

lbClear _listbox;
{
 	_itemName = _x select 0;  //,"ALF_Relique_1","ALF_Relique_2","ALF_Relique_3","ALF_Cupidon"
 	if (_itemName in ["ALF_Weed_P","ALF_Weed_P_2","ALF_Weed_P_3","ALF_Weed","ALF_Weed_2","ALF_Weed_3","ALF_Cocaine","ALF_Cocaine_2","ALF_Meth50","ALF_Meth90"]) then {
		_itemInfo = [_itemName] call ALF_fnc_fetchCfgDetails;
 		_itemDisplayIcon = _itemInfo select 2;
 		_itemDisplayName = _itemInfo select 1;
 		_tmp = [_forEachIndex];
 		_tmp = str(_tmp);
		_listbox lbAdd format["%1",_itemDisplayName];
		_listbox lbSetPicture [(lbSize _listbox )-1,_itemDisplayIcon];
		_listbox lbSetData [(lbSize _listbox)-1,_tmp];
	};
} forEach ALFBOURSE_Prices;

} else {

lbClear _listbox;
{
 	_itemName = _x select 0;
 	if !(_itemName in ["ALF_Weed_P","ALF_Weed_P_2","ALF_Weed_P_3","ALF_Weed","ALF_Weed_2","ALF_Weed_3","ALF_Cocaine","ALF_Cocaine_2","ALF_Relique_1","ALF_Relique_2","ALF_Relique_3","ALF_Cupidon","ALF_Meth50","ALF_Meth90"]) then {
		_itemInfo = [_itemName] call ALF_fnc_fetchCfgDetails;
 		_itemDisplayIcon = _itemInfo select 2;
 		_itemDisplayName = _itemInfo select 1;
 		_tmp = [_forEachIndex];
 		_tmp = str(_tmp);
		_listbox lbAdd format["%1",_itemDisplayName];
		_listbox lbSetPicture [(lbSize _listbox )-1,_itemDisplayIcon];
		_listbox lbSetData [(lbSize _listbox)-1,_tmp];
	};
} forEach ALFBOURSE_Prices;
};
