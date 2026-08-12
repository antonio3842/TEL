// ALF_fnc_sellGarage = {
private["_vehicle","_vehicleLife","_vid","_pid","_price","_insure"];
disableSerialization;
if (lbCurSel 2802 isEqualTo -1) exitWith {hint "1"};
_vehicle = lbData[2802,(lbCurSel 2802)];
_vehicle = (call compile format["%1",_vehicle]) # 0;
_insure = lbData[2802,(lbCurSel 2802)];
_insure = (call compile format["%1",_insure]) # 3;
_vehicleLife = _vehicle;
_vid = lbValue[2802,(lbCurSel 2802)];
_pid = getPlayerUID player;

if (isNil "_vehicle") exitWith {hint "2"};
if ((time - life_action_delay) < 1.5) exitWith {hint "Vous appuyez trop vite."};

_returnClass = [["LifeCfgVehicles", _vehicleLife]] call ALFTools_Client_Config_fnc_isClass;
if !(_returnClass) then {_vehicleLife = "Default"};

_price = ["NUMBER",["LifeCfgVehicles", _vehicleLife,"vente"]] call ALFTools_Client_Config_fnc_getConfig;

private _action = [format["Etes-vous sur de vouloir vendre ce véhicule pour %1 €.",[_price] call ALF_fnc_numberText],"GARAGE","OUI","NON"] call BIS_fnc_guiMessage;
if !(_action) exitWith {};
closeDialog 0;

if (_insure isEqualTo 1) then {
	[format["UPDATE vehicles SET insure='0' WHERE id='%1'",_vid],1] remoteExecCall ["ALF_Server_fnc_asyncCall",2];
	life_axacount = life_axacount - 1 max 0;
	[15] call SOCK_fnc_updatePartial;
};

if (_insure isEqualTo 2) then {
	[format["UPDATE vehicles SET insure='0' WHERE id='%1'",_vid],1] remoteExecCall ["ALF_Server_fnc_asyncCall",2];
	life_axaprocount = life_axaprocount - 1 max 0;
	[17] call SOCK_fnc_updatePartial;
};

[_vid,_pid] remoteExecCall ["ALF_Server_fnc_vehicleDelete",2];

life_cash = life_cash + _price;
[0] call SOCK_fnc_updatePartial;

["GARAGE",format ["Vous avez vendu le véhicule pour %1 €.",_price],"success"] remoteExec ["ALF_fnc_doMsg",player];
[name player,getPlayerUID player,"VEHICULE",format["vient de vendre %1 pour %2 €.",_vehicleLife,_price]] remoteExec ["ALF_Server_fnc_logIt",2];
[_vehicleLife] remoteExecCall ["ALF_Server_fnc_vehicleStockAfterSell",2];

life_action_delay = time;
// };
